CS61 2020: Assembly 8
=====================

Today’s lecture will discuss machine code aspects of how a program
interacts with the “outside world”, which means anything outside of
the program’s own memory space.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

1\. Examine `syscalls.cc`. This program prepares two buffers and
prints them to the standard output. The program interacts with the
outside world in two ways: by printing messages, and through the
`getpid()` library function, which returns an identifier (the *process
ID*) for the currently running program instance.

2\. Run this program in gdb using `layout asm`. Step through `main`
one instruction at a time. You may step over the `snprintf` and
`random` calls (using the `ni` command, for example), but step *into*
`write` and `getpid` (using `si`). Can you find the instruction that
interacts with the outside world? What can you determine about its
calling convention?
