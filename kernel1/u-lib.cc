#include "u-lib.hh"

// sys_getpid
//    Return current process ID.
__noinline pid_t sys_getpid() {
    return make_syscall(SYSCALL_GETPID);
}

// sys_yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
__noinline void sys_yield() {
    make_syscall(SYSCALL_YIELD);
}

// sys_page_alloc(addr)
//    Allocate a page of memory at address `addr`. `Addr` must be page-aligned
//    (i.e., a multiple of PAGESIZE == 4096). Returns 0 on success and -1
//    on failure.
__noinline int sys_page_alloc(void* addr) {
    return make_syscall(SYSCALL_PAGE_ALLOC, (uintptr_t) addr);
}

// sys_getsysname()
//    Write the name of the current OS into `buf`.
__noinline int sys_getsysname(char* buf) {
    return make_syscall(SYSCALL_GETSYSNAME, (uintptr_t) buf);
}

// sys_panic(msg)
//    Panic.
[[noreturn]] __noinline void sys_panic(const char* msg) {
    make_syscall(SYSCALL_PANIC, (uintptr_t) msg);

    // should never get here
    while (true) {
    }
}


// panic, assert_fail
//     Call the SYSCALL_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
    va_list val;
    va_start(val, format);
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
    sys_panic(nullptr);
}

int error_vprintf(int cpos, int color, const char* format, va_list val) {
    return console_vprintf(cpos, color, format, val);
}

void assert_fail(const char* file, int line, const char* msg) {
    error_printf(CPOS(23, 0), COLOR_ERROR,
                 "%s:%d: user assertion '%s' failed\n",
                 file, line, msg);
    sys_panic(nullptr);
}
