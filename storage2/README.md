CS61 2020: Storage 2
====================

Today’s meeting discusses caches in general, then introduces some tools for
investigating the system call behaviors of processes.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

This advance work builds on the Storage 1 work, so do that if you haven’t.

1\. Linux’s `strace` program prints a human-readable trace of all the system
calls made by another process! This is an amazing debugging tool for figuring
out process behavior.

In the `../storage1` directory, build the `w` programs, then run (on Linux or
Docker):

```sh
$ strace ./w-osbyte -qs1
```

In this command line, the `./w-osbyte` program writes one byte to the `data`
file, using a system call. meanwhile, `strace` spies on all the system calls
made by `w-osbyte` and prints those system calls to the terminal.

> **Note.** The `w` programs now have command line arguments.
>
> * `-s SIZE`: Write `SIZE` bytes total (rather than 5120000 or whatever).
> * `-b BLOCKSIZE` (`block` programs only): Write blocks of `BLOCKSIZE` bytes
>   (rather than 512).
> * `-q`: Print a single speed report at the end of the run, rather than
>   continuously updating the speed report.

Find the line of output that corresponds to writing the data. This line will
come pretty late in the `strace` output—processes make many system calls as
they boot that can be ignored for now. If you can’t find the critical line,
try `strace ./w-osbyte -qs2`, `./w-osbyte -qs3`, `./w-osbyte -qs4`, etc.

2\. Can you find a set of arguments for `./w-osblock` that produce an
essentially identical system call trace to `./w-osbyte -qs3`?

(“Essentially identical” means that some addresses will change because of
address space randomization. For instance, the addresses passed to and
returned from `mmap`, `brk`, and `mprotect` change every time a program runs.)

3\. Can you find a set of arguments for `./w-osblock` that produce an
essentially identical system call trace to `./w-stdiobyte -qs30000`?
