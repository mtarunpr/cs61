#include "kernel.hh"
#include "k-apic.hh"
#include "k-vmiter.hh"
#include "obj/k-firstprocess.h"
#include <atomic>

// kernel.cc
//
//    This is the kernel.


// INITIAL PHYSICAL MEMORY LAYOUT
//
//  +-------------- Base Memory --------------+
//  v                                         v
// +-----+--------------------+----------------+--------------------+---------/
// |     | Kernel      Kernel |       :    I/O | App 1        App 1 | App 2
// |     | Code + Data  Stack |  ...  : Memory | Code + Data  Stack | Code ...
// +-----+--------------------+----------------+--------------------+---------/
// 0  0x40000              0x80000 0xA0000 0x100000             0x140000
//                                             ^
//                                             | \___ PROC_SIZE ___/
//                                      PROC_START_ADDR

#define PROC_SIZE 0x40000       // initial state only

proc ptable[NPROC];             // array of process descriptors
                                // Note that `ptable[0]` is never used.
proc* current;                  // pointer to currently executing proc

std::atomic<unsigned long> ticks; // # timer interrupts so far


// Memory state
//    Information about physical page with address `pa` is stored in
//    `pages[pa / PAGESIZE]`. In the handout code, each `pages` entry
//    holds an `refcount` member, which is 0 for free pages.
//    You can change this as you see fit.

pageinfo pages[NPAGES];


[[noreturn]] void schedule();
[[noreturn]] void run(proc* p);
void exception(regstate* regs);
uintptr_t syscall(regstate* regs);
ssize_t syscall_pipewrite(proc* p);
ssize_t syscall_piperead(proc* p);


// kernel_start(command)
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

static void process_setup(pid_t pid, const char* program_name);

void kernel_start(const char* command) {
    // initialize hardware
    init_hardware();
    log_printf("Starting WeensyOS\n");

    ticks = 1;
    init_timer(HZ);

    // clear screen
    console_clear();

    // (re-)initialize kernel page table:
    // all of physical memory is accessible to kernel except `nullptr`;
    // console is accessible to all
    for (vmiter it(kernel_pagetable);
         it.va() < MEMSIZE_PHYSICAL;
         it += PAGESIZE) {
        if (it.va() == CONSOLE_ADDR) {
            it.map(it.va(), PTE_P | PTE_W | PTE_U);
        } else if (it.va() != 0) {
            it.map(it.va(), PTE_P | PTE_W);
        } else {
            it.map(it.va(), 0);
        }
    }

    // set up process descriptors and run first processes
    for (pid_t i = 0; i < NPROC; i++) {
        ptable[i].pid = i;
        ptable[i].state = P_FREE;
    }
    if (!command) {
        command = WEENSYOS_FIRST_PROCESS;
    }
    if (command && !program_image(command).empty()) {
        process_setup(1, command);
    } else {
        process_setup(1, "pipewriter");
        process_setup(2, "pipereader");
    }
    run(&ptable[1]);
}



// kalloc_user_pagetable()
//    Return a newly allocated page table with the minimal set of
//    mappings required for user processes.

x86_64_pagetable* kalloc_user_pagetable() {
    x86_64_pagetable* pt = kalloc_pagetable();
    if (pt) {
        for (vmiter it(pt), kit(kernel_pagetable);
             it.va() < PROC_START_ADDR;
             it += PAGESIZE, kit += PAGESIZE) {
            it.map(kit.pa(), kit.perm());
        }
    }
    return pt;
}



// process_setup(pid, program_name)
//    Load application program `program_name` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, const char* program_name) {
    proc* p = &ptable[pid];
    init_process(p, 0);

    // We expect all process memory to reside between
    // first_addr and last_addr.
    uintptr_t first_addr = PROC_START_ADDR + (pid - 1) * PROC_SIZE;
    uintptr_t last_addr = PROC_START_ADDR + pid * PROC_SIZE;

    // initialize process page table
    ptable[pid].pagetable = kalloc_user_pagetable();

    // obtain reference to the program image
    program_image pgm(program_name);

    // allocate and map all memory
    for (auto seg = pgm.begin(); seg != pgm.end(); ++seg) {
        for (uintptr_t va = round_down(seg.va(), PAGESIZE);
             va < seg.va() + seg.size();
             va += PAGESIZE) {
            assert(va >= first_addr && va < last_addr);
            assert(!pages[va / PAGESIZE].used());
            ++pages[va / PAGESIZE].refcount;
            void* pg = (void*) va;
            vmiter(p->pagetable, va).map(pg, PTE_P | PTE_W | PTE_U);
        }
    }

    // copy instructions and data into place
    // XXX This only works because the initial process is identity-mapped!
    for (auto seg = pgm.begin(); seg != pgm.end(); ++seg) {
        memset((void*) seg.va(), 0, seg.size());
        memcpy((void*) seg.va(), seg.data(), seg.data_size());
    }

    // mark entry point
    p->regs.reg_rip = pgm.entry();

    // allocate stack
    uintptr_t stack_addr = last_addr - PAGESIZE;
    assert(!pages[stack_addr / PAGESIZE].used());
    ++pages[stack_addr / PAGESIZE].refcount;
    vmiter(p->pagetable, stack_addr).map(stack_addr, PTE_P | PTE_W | PTE_U);
    p->regs.reg_rsp = stack_addr + PAGESIZE;

    // mark process as runnable
    p->state = P_RUNNABLE;
}



// kalloc(sz)
//    Kernel memory allocator. Allocates `sz` contiguous bytes and
//    returns a pointer to the allocated memory, or `nullptr` on failure.
//
//    The returned memory is initialized to 0xCC, which corresponds to
//    the x86 instruction `int3` (this may help you debug). You'll
//    probably want to reset it to something more useful.

void* kalloc(size_t sz) {
    if (sz <= PAGESIZE) {
        for (uintptr_t pa = 0; pa != MEMSIZE_PHYSICAL; pa += PAGESIZE) {
            if (allocatable_physical_address(pa)
                && !pages[pa / PAGESIZE].used()) {
                ++pages[pa / PAGESIZE].refcount;
                memset((void*) pa, 0xCC, PAGESIZE);
                return (void*) pa;
            }
        }
    }
    return nullptr;
}



// exception(regs)
//    Exception handler (for interrupts, traps, and faults).
//
//    The register values from exception time are stored in `regs`.
//    The processor responds to an exception by saving application state on
//    the kernel's stack, then jumping to kernel assembly code (in
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled when the kernel is running.

void exception(regstate* regs) {
    // Copy the saved registers into the `current` process descriptor.
    current->regs = *regs;
    regs = &current->regs;

    // It can be useful to log events using `log_printf`.
    // Events logged this way are stored in the host's `log.txt` file.
    /* log_printf("proc %d: exception %d at rip %p\n",
                current->pid, regs->reg_intno, regs->reg_rip); */

    // Show the current cursor location.
    console_show_cursor(cursorpos);

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();


    // Actually handle the exception.
    switch (regs->reg_intno) {

    case INT_IRQ + IRQ_TIMER:
        ++ticks;
        lapicstate::get().ack();
        schedule();

    case INT_PF: {
        // Analyze faulting address and access type.
        uintptr_t addr = rdcr2();
        const char* entity = regs->reg_errcode & PFERR_USER
                ? "Process" : "Kernel";
        const char* operation = regs->reg_errcode & PFERR_WRITE
                ? "write" : "read";
        const char* problem = regs->reg_errcode & PFERR_PRESENT
                ? "protection" : "missing";

        error_printf("%s %d page fault at %p (%s %s, rip=%p)!\n",
            entity, current->pid, addr, operation, problem, regs->reg_rip);
        goto unhandled;
    }

    case INT_GP: {
        const char* entity = regs->reg_cs & 3 ? "Process" : "Kernel";

        error_printf("%s general protection fault (rip=%p)!\n",
            entity, regs->reg_rip);
        goto unhandled;
    }

    default:
    unhandled:
        if ((regs->reg_cs & 3) != 0) {
            error_printf("Process %d unexpected exception %d (rip=%p)!\n",
                         current->pid, regs->reg_intno, regs->reg_rip);
            current->state = P_BROKEN;
            break;
        } else {
            panic("Unexpected exception %d!\n", regs->reg_intno);
        }

    }


    // Return to the current process (or run something else).
    if (current->state == P_RUNNABLE) {
        run(current);
    } else {
        schedule();
    }
}


// syscall(regs)
//    System call handler.
//
//    The register values from system call time are stored in `regs`.
//    The return value, if any, is returned to the user process in `%rax`.
//
//    Note that hardware interrupts are disabled when the kernel is running.

uintptr_t syscall(regstate* regs) {
    // Copy the saved registers into the `current` process descriptor.
    current->regs = *regs;
    regs = &current->regs;

    // It can be useful to log events using `log_printf`.
    // Events logged this way are stored in the host's `log.txt` file.
    /* log_printf("proc %d: syscall %d at rip %p\n",
                  current->pid, regs->reg_rax, regs->reg_rip); */

    // Show the current cursor location.
    console_show_cursor(cursorpos);

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();


    // Actually handle the exception.
    switch (regs->reg_rax) {

    case SYSCALL_PANIC:
        panic(nullptr);         // does not return

    case SYSCALL_GETPID:
        return current->pid;

    case SYSCALL_GETTICKS:
        return ticks;

    case SYSCALL_YIELD:
        current->regs.reg_rax = 0;
        schedule();             // does not return

    case SYSCALL_GETSYSNAME: {
        const char* osname = "DemoOS 61.61";
        size_t oslen = strlen(osname);
        char* buf = (char*) current->regs.reg_rdi;
        size_t bufsz = current->regs.reg_rsi;
        strncpy(buf, osname, bufsz);
        return oslen;
    }

    case SYSCALL_PIPEWRITE:
        return syscall_pipewrite(current);

    case SYSCALL_PIPEREAD:
        return syscall_piperead(current);

    default:
        panic("Unexpected system call %ld!\n", regs->reg_rax);

    }

    panic("Should not get here!\n");
}


// pipe buffer

char pipebuf[1];
size_t pipebuf_len = 0;

// syscall_pipewrite([buf, sz])
//    Handles the SYSCALL_PIPEWRITE system call; see `sys_pipewrite`
//    in `u-lib.hh`.

ssize_t syscall_pipewrite(proc* p) {
    const char* buf = (const char*) p->regs.reg_rdi;
    size_t sz = p->regs.reg_rsi;

    if (sz == 0) {
        // nothing to write
        return 0;
    } else if (pipebuf_len == 1) {
        // kernel buffer full, try again
        return -1;
    } else {
        // write one character
        pipebuf[0] = buf[0];
        pipebuf_len = 1;
        return 1;
    }
}

// syscall_piperead([buf, sz])
//    Handles the SYSCALL_PIPEREAD system call; see `sys_piperead`
//    in `u-lib.hh`.

ssize_t syscall_piperead(proc* p) {
    char* buf = (char*) p->regs.reg_rdi;
    size_t sz = p->regs.reg_rsi;

    if (sz == 0) {
        // no room to read
        return 0;
    } else if (pipebuf_len == 0) {
        // kernel buffer empty, try again
        return -1;
    } else {
        // read one character
        buf[0] = pipebuf[0];
        pipebuf_len = 0;
        return 1;
    }
}


// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule() {
    pid_t pid = current->pid;
    for (unsigned spins = 1; true; ++spins) {
        pid = (pid + 1) % NPROC;
        if (ptable[pid].state == P_RUNNABLE) {
            run(&ptable[pid]);
        }

        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
    }
}


// run(p)
//    Run process `p`. This involves setting `current = p` and calling
//    `exception_return` to restore its page table and registers.

void run(proc* p) {
    assert(p->state == P_RUNNABLE);
    current = p;

    // Check the process's current pagetable.
    check_pagetable(p->pagetable);

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(p);

    // should never get here
    while (true) {
    }
}
