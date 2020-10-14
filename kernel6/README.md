CS61 2020: Kernel 6
===================

Today’s lecture is about how processes are represented inside kernels.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

1\. This operating system runs two processes, `p-hello.cc` and `p-yield.cc`.
Examine their source code, then `make run`. You will see output like this:

```
Hello!                                
hello: getpid #1 returns 1            
hello: getpid #2 returns 1            
hello: getpid #3 returns 1            
Yielding!                             
hello: yield #1 returns 0             
yielder: yield #1 returns 0           
hello: yield #2 returns 0             
yielder: yield #2 returns 0           
hello: yield #3 returns 0             
yielder: yield #3 returns 0           
```

What system call behavior causes these lines of output to appear in this
order?

2\. Which line of code in `kernel.cc` sets the return value for `sys_getpid`?
Which line sets the return value for `sys_yield`? Check your work by modifying
the lines and examining `make run`’s output.

3\. Change the kernel so that `sys_yield` *does not* yield to a different
process, and `sys_getpid` *does* yield to a different process.
