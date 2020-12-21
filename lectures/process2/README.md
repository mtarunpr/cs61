CS61 2020: Process control 2
============================

Today’s meeting is about inter-process communication.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

1\. Run the command `seq 1 100`. What does it do?

2\. Run the command line `seq 1 100 | rev`. What does it do?

3\. Run the command line `seq 1 10000000000 | head -n 10`. What does
it do, and how long does it take?

4\. The pipe symbol `|` redirects the left-hand process’s standard
output so that, instead of going to the terminal, it is read by the
right-hand process’s standard input. What would happen if these
redirections were emulated using the normal file system? For instance,
`seq 1 100 | rev` could be implemented as:

    seq 1 100 > /tmp/commandline1.out
    head -n 10 < /tmp/commandline1.out

What are some advantages and disadvantages of this scheme?
