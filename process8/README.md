CS61 2020: Process control 8
============================

Today’s meeting is about pipes and process organization.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

Your goal is to write a function that implements a version of Python’s
[`subprocess` functionality][Python subprocess]. Your function should have the
following specification:

```c++
// subprocess(file, argv, pfd)
//    Run the command `file` with arguments `argv` in a child process.
//    The `pfd` argument is populated with three file descriptors that
//    communicate to and from the child, as follows:
//
//    * `pfd[0]` is open for writing. Data written to `pfd[0]` can be
//      read from the child’s standard input.
//    * `pfd[1]` is open for reading. Data read from `pfd[1]` was
//      written to the child’s standard output.
//    * `pfd[2]` is open for reading. Data read from `pfd[2]` was
//      written to the child’s standard error.
//
//    Returns the process ID of the child or -1 on error.
pid_t subprocess(const char* file, char* const argv[], int pfd[3]);
```

A full implementation would use the `pipe`, `dup2`, `fork`, `execvp`, `close`,
and `_exit` system calls.

1\. How many `pipe` system calls must `subprocess` make?

2\. How many `fork` system calls must `subprocess` make?

3\. Must the `pipe` system call(s) occur before or after the `fork`(s), or
does it matter?

4\. Sketch a version of this function that works correctly **when no system
call returns an error**. Come prepared to discuss your approach in a breakout
room.

5\. List errors that could occur, and describe how these errors should be
handled.

[Python subprocess]: https://docs.python.org/3/library/subprocess.html
