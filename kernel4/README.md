CS61 2020: Kernel 4
===================

Today’s lecture is in section style: You’ll work through a set of problems.

Solutions are available in the `solution.md` file, but please try working
through the exercises yourself before peeking.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

1\. Familiarize yourself with the WeensyOS source code as described in
lecture and the initial parts of the [problem set handout][WeensyOS].

2\. Read the [“About virtual memory iterators”][about-vmiter] and [“About
physical memory iterators”][about-ptiter] sections of the problem set handout.

3\. Read about the `log_printf` function in the [problem set
handout][WeensyOS].

The remaining portions of this handout are taken up with section problems.

P1\. Examining memory
---------------------

Use `vmiter` and `log_printf` to print the physical addresses that are mapped
to the following virtual addresses by `kernel_pagetable`:

1. The `syscall_entry` function
2. The `kernel_pagetable`
3. The `p-hello` process’s `process_main`

Print these physical addresses both (A) immediately before the call to
`process_setup`, and (B) immediately after that call. Do the values change?
Why or why not?

P2\. Examining permissions
--------------------------

Use `vmiter` and `log_printf` to print the *permissions* active for the
following virtual addresses in `kernel_pagetable`:

1. The `syscall_entry` function
2. The `kernel_pagetable`
3. The `p-hello` process’s `process_main`

Print these physical addresses both (A) immediately before the call to
`process_setup`, and (B) immediately after that call. Do the values change?
Why or why not?

P3\. Examining page table structures
------------------------------------

Use `ptiter` to print the page table pages active in `kernel_pagetable`. Then
use GDB (or the QEMU monitor, or `log_printf`) to examine the memory stored in
those page table pages. All page table pages have the same structure; can you
deduce anything about that structure from their contents? Try adding some
`vmiter::map` calls to investigate further.

P4\. Warped virtual memory
--------------------------

Run `make run-bigdata`. Boo! Examine `p-bigdata.cc`. Now add *one line* of
virtual memory manipulation code to `process_startup` so that `run-bigdata`
prints `CS 61 Is Amazing`. (Don’t modify process memory directly; just modify
memory mappings.)

Make sure you remove your VM manipulation code before moving on to another
problem.

P5\. Examining faults
---------------------

Now run `make run-recurse`. This will run `p-recurse` instead of `p-hello`.
Examine `p-recurse` and understand how it works.

1\. What is the size of a stack frame for the `f` function? Try to determine
this by examining `obj/p-recurse.asm`, then check your understanding by adding
`console_printf` lines that print the address of some local variable (say
`i`).

2\. Find the smallest `DEPTH` constant that causes `p-recurse` to fail with a
page fault exception. What is that constant?

3\. What is your explanation for the page fault?

4\. Change the kernel so that `p-recurse` supports a larger `DEPTH`.

[WeensyOS]: https://cs61.seas.harvard.edu/site/2020/WeensyOS/
[about-vmiter]: https://cs61.seas.harvard.edu/site/2020/WeensyOS/#about-vmiter
[about-ptiter]: https://cs61.seas.harvard.edu/site/2020/WeensyOS/#about-ptiter
