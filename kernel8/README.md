CS61 2020: Kernel 8
===================

Today’s meeting is about kernel scheduling. Our version of WeensyOS runs two
processes, `p-pipewriter.cc` and `p-pipereader.cc`, that communicate with each
other using a kernel buffer—the “pipe buffer”—as intermediary. The pipewriter
program picks a random message and writes it to the kernel; the pipereader
program reads this message from the kernel and prints it. Use `make run` to
see it work.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

1\. Read the explanations for the `sys_piperead` and `sys_pipewrite` system
calls in u-lib.cc. What do these system calls remind you of?

2\. Find the implementations of `syscall_pipewrite` and `syscall_piperead` in
`kernel.cc`. What is the maximum number of bytes these system calls can read
or write at a time? How can this be a performance problem?

3\. How many system calls do the writer and reader make per message? Is there
a discrepancy? Look at their code; can you explain the discrepancy?

Class work
----------

In class, we will change the kernel, and only the kernel, to reduce the number
of system calls required to transfer a message to the minimum, which is one.
Here are some techniques we will use. If you’re interested, try doing some of
this work on your own.

* **Confused deputy prevention.** The kernel’s pipe system calls allow
  a confused deputy attack. This should be fixed.

* **Scheduling.** When process P is unlikely to be able to do useful work,
  it often makes sense to run a process other than P next. The handout
  kernel does not follow this rule of thumb.

* **Batching/buffering.** It is more efficient to transfer more than one byte
  at a time.

* **Blocking.** When process P cannot make progress, it can be more
  efficient overall to put process P to sleep until the state changes
  and it has a chance to progress again. This is called *blocking*
  process P. For instance, perhaps the `sys_piperead` system call
  might block the calling process until there is at least one byte
  available to read.
