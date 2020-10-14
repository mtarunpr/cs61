# Solutions

## P1. Examining memory

The first question is how to find the addresses corresponding to these
symbols. Well, here’s one way: *ask GDB*, which knows the addresses for things.

```sh
cs61-user@9d076324193b:~/cs61-lectures/kernel4$ make run
* Run `gdb -x build/weensyos.gdb` to connect gdb to qemu.
...
kohler@elsewhere$ gdb -x build/demoos.gdb
GNU gdb (GDB) 9.2
Copyright (C) 2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
...blah blah blah...
(gdb) p syscall_entry
$1 = {<text variable, no debug info>} 0x40ad6 <syscall_entry>
(gdb) p process_main
$2 = {void (void)} 0x100000 <process_main()>
(gdb) p kernel_pagetable
$3 = 0x4e000 <kernel_pagetable>
(gdb) 
```

Then you can pass those address to `vmiter`.

Another way is to take advantage of the symbol and assembly files created in
the `obj/` directory. If you’re not sure what file to check, use `grep` to
check them all:

```sh
cs61-user@9d076324193b:~/cs61-lectures/kernel4$ grep syscall_entry obj/*
Binary file obj/kernel matches
obj/kernel.asm:0000000000040ad6 <syscall_entry>:
obj/kernel.asm:    wrmsr(MSR_IA32_LSTAR, reinterpret_cast<uint64_t>(syscall_entry));
Binary file obj/kernel.full matches
obj/kernel.sym:0000000000040ad6 T syscall_entry
Binary file obj/k-exception.ko matches
Binary file obj/k-hardware.ko matches
```

Or you can get addresses from the compiler—though this is not as easy as it
might first appear.

### `syscall_entry`

The `syscall_entry` function is defined in `k-exception.S` as an assembly function, so
we cannot access it directly from inside `kernel.cc` since the C compiler will not know
what the symbol refers to. To be able to access it from inside `kernel.cc`, we can define
a `syscall_entry` function marked as `extern`, meaning the implementation is external
and will be provided during linking.

Placing this line of code above the definition of `kernel_start` will allow us
to access the function now!

```
extern "C" { extern void syscall_entry(); }
```

We mark the function with `extern "C"` because the name of the function in
assembly code is just `syscall_entry` and we want to prevent the C++ compiler
from automatically doing name mangling of function names.

Now we can look up the address of this function in our `kernel_pagetable` and
print it (this code goes in `kernel_start` right before the call to
`process_setup`):

```
auto se = vmiter(kernel_pagetable, (uintptr_t) &syscall_entry);
log_printf("syscall_entry pa: %p\n", (uintptr_t) se.pa());
```

### Kernel pagetable

The `kernel_pagetable` variable has type `x86_64_pagetable*`. This means it is
a pointer to the actually pagetable memory. We can just convert that virtual
address to a physical address and print it:

```
auto kp = vmiter(kernel_pagetable, (uintptr_t) kernel_pagetable);
log_printf("kernel_pagetable pa: %p\n", kp.pa());
```

### Process main

The `process_main` function is not linked into the kernel so it is not
accessible by using the same trick we used to get the `syscall_entry` function.
However, we can look in `process_setup` for some ideas! The address of process
main will be the first address that gets executed by that process, so that
process's initial value of `%rip` will be the address of process main. We see
the line

```
p->regs.reg_rip = pgm.entry();
```

in `process_setup`, so we can use the same functionality to print the address
of `process_main` in `kernel_start`:

```
program_image pgm(WEENSYOS_FIRST_PROCESS);
auto pm = vmiter(kernel_pagetable, (uintptr_t) pgm.entry());
log_printf("process_main pa: %p\n", pm.pa());
```

### Do the physical addresses change?

If we run the same print statements after the call to `process_setup`, the
addresses do not appear to change. This makes sense, because `process_setup`
does not modify any of the virtual addresses, and does not perform any mappings
that are not identity mappings.

## P2. Examining permissions

We can use the same `vmiter` objects as before, but print the permission bits
instead:

```
log_printf("syscall_entry perm: 0x%x\n", se.perm());
log_printf("kernel_pagetable perm: 0x%x\n", kp.perm());
log_printf("process_main perm: 0x%x\n", pm.perm());
```

### Do the permissions change?

After printing the permissions before and after `process_setup` it looks like
the permissions for the `process_main` address have changed. This makes sense
because that page needs to be user-accessible so that the user process
`p-hello` can access its own code/data to execute. In particular, the page for
`process_main` is now marked with the `PTE_U` bit, and it wasn't before calling
`process_setup`.

Some other bits also change. In particular, the permissions before
`process_setup` equal `0x3` (`PTE_W|PTE_P`), but afterward you might see
`0x27` or `39`. `x86-64.h` says that these bits are `PTE_U|PTE_W|PTE_P|PTE_A`.
The `PTE_A` bit is set automatically by the processor hardware to indicate
that the relevant address range has been **A**ccessed.

## P3. Examining page table structures

Let's use a `ptiter` to print the page table pages:

```
for (ptiter it(kernel_pagetable); it.va() < MEMSIZE_VIRTUAL; it.next()) {
    log_printf("[%p, %p): level-%d ptp at pa %p\n",
               it.va(), it.last_va(), it.level() + 1, it.kptr());
}
```

I see

```
[0x0, 0x200000): level-1 ptp at pa 0x51000
[0x200000, 0x400000): level-1 ptp at pa 0x52000
[0x0, 0x40000000): level-2 ptp at pa 0x50000
[0x0, 0x8000000000): level-3 ptp at pa 0x4f000
```

> **Note.** If you ran this code on the original handout, you would have seen
> *only one* page table page, the first. This is because the handout OS’s
> `MEMSIZE_VIRTUAL` was originally too small.

We can modify our code slightly to print the contents of each page table page.

```
for (ptiter it(kernel_pagetable); it.va() < MEMSIZE_VIRTUAL; it.next()) {
    uint64_t* bytes = (uint64_t*) it.kptr();
    for (unsigned i = 0; i < PAGESIZE / sizeof(uint64_t); i++) {
        log_printf("0x%lx\n", bytes[i]);
    }
}
```

We see a lot of numbers like

```
0x0
0x1003
0x2003
0x3003
0x4003
0x5003
0x6003
0x7003
0x8003
0x9003
0xa003
0xb003
0xc003
0xd003
...
```

Specifically, almost all end with `3`—which we know from P2 is
`PTE_P|PTE_W`—but some end with `7`—which is `PTE_P|PTE_W|PTE_U`. The
fourth hex digit always increases by 1. And in the later page table
pages, we see some numbers that look like addresses of earlier page
table pages. Fascinating!

## P4. Warped virtual memory

Without any modification, `p-bigdata` prints `CS 61 Is Awful` :(. To fix this, we
can notice that there is a page boundary at `&big_data[4096]`, which happens to
correspond to the point 10 bytes into the string. The `|` marks the page boundary
in the string below:

```
CS 61 Is A|wful
```

Let's try printing some of the addresses in the process. We can add another
print statement below the initial one:

```
console_printf(0x3000, "%p %p %p\n", &big_data[0], &big_data[4086], &big_data[4096]);
```

This prints

```
0x102000 0x102ff6 0x103000
```

So what if we map virtual address `0x102000` to physical address `0x103000`?
Then the memory space will look like this after running the two calls to
`strcpy`:

```
(va: 0x102000/pa: 0x103000): mazing
...
(va: 0x102ff6/pa: 0x103ff6): CS 61 Is A
(va: 0x103000/pa: 0x103000): mazing
```

This looks good! When we print the bytes at virtual address `0x102ff6`, we will
see `CS 61 Is Amazing`.  Remember, virtual address `0x103000` is still mapped
to physical address `0x103000` because we didn't modify that mapping!

So if we add the following line of code to `process_setup`, we can perform the
mapping described above:

```
vmiter(p->pagetable, 0x102000).map(0x103000, PTE_PWU);
```

(it doesn't really matter where this code goes, but I put it after the
assignment to `reg_rip`).

If we didn't want to rely on the fact that the pagetable is an identity
mapping, we could look up the physical address of virtual address `0x103000`
and use that for the mapping:

```
vmiter(p->pagetable, 0x102000).map(vmiter(p->pagetable, 0x103000).pa(), PTE_PWU);
```

## P5. Examining faults

### 1.

Here is the assembly for most of the recursive `f` function in `p-recurse` (the
important bits):

```
__noinline unsigned f(unsigned i) {
  100000:	f3 0f 1e fa          	endbr64
  100004:	55                   	push   %rbp
  100005:	48 89 e5             	mov    %rsp,%rbp
  100008:	53                   	push   %rbx
  100009:	48 83 ec 08          	sub    $0x8,%rsp
  10000d:	89 fb                	mov    %edi,%ebx
  10000f:	85 ff                	test   %edi,%edi
  100011:	75 09                	jne    10001c <f(unsigned int)+0x1c>
  100013:	89 d8                	mov    %ebx,%eax
  100015:	48 83 c4 08          	add    $0x8,%rsp
  100019:	5b                   	pop    %rbx
  10001a:	5d                   	pop    %rbp
  10001b:	c3                   	retq
  ...
```

The only parts we care about for determining the size of the stack frame are
the function entry or exit. At the entry we see:

```
push   %rbp
push   %rbx
sub    $0x8,%rsp
```

This uses 24 bytes of space on the stack. Combined with the fact that there is
also a 64-bit return address on the stack for this function (pushed by the
`call` instruction), is appears the stack frame for this function is 32 bytes.
(Similarly at the exit, we see the corresponding instructions to undo the `sub`,
`push`, and `call` instructions.)

### 2.

Testing around with the for loop maximum (by default it's 10), I found that 127
is the smallest number where it still succeeds.

### 3.

For each process, WeensyOS allocates a 1-page stack. This means the stack is
4096 bytes. If there are 127 (recursive) calls to `f`, and each one uses 32
bytes of stack space, we use 4064 bytes of stack space, so we are fine
(remember `process_main` also uses some stack space).  If there are 128 calls,
we would need 4096 bytes of stack space for just the recursive calls, and since
`process_main` is using some stack space too, there is not enough space!

### 4.

Let's allocate two stack pages for every process instead of just 1.

```
uintptr_t stack_addr = last_addr - PAGESIZE;
pages[stack_addr / PAGESIZE].refcount = 1;
vmiter(p->pagetable, stack_addr).map(stack_addr, PTE_P | PTE_W | PTE_U);

uintptr_t stack_addr_extra = last_addr - PAGESIZE - PAGESIZE;
pages[stack_addr_extra / PAGESIZE].refcount = 1;
vmiter(p->pagetable, stack_addr_extra).map(stack_addr_extra, PTE_P | PTE_W | PTE_U);

p->regs.reg_rsp = stack_addr + PAGESIZE;
```

Now we can handle more depth without faulting. With bigger numbers, the stack
would still overflow though... As food for thought, is it possible to
dynamically grow the stack if a process needs more memory? How could this be
implemented?
