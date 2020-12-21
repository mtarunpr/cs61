CS61 2020: Storage 5
====================

Today’s meeting is about access patterns and reference strings.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

An **access pattern** is a style of accessing storage over time. Some
especially imporant access patterns are as follows:

* **Sequential access**. A sequential access pattern accesses a contiguous
  increasing sequence of addresses with nothing skipped, like 1, 2, 3, 4, 5,
  6… or 1009, 1010, 1011, 1012, 1013….

* **Random access**. A random access pattern skips around in address space at
  random, like 1, 10403, 96, 2, 51934, ….

* **Reverse-sequential access**. A reverse-sequential access pattern access a
  contiguous decreasing sequence of addresses with nothing skipped, like
  60274, 60273, 60272, 60271, 60270, ….

* **Strided access**. A strided access pattern accesses a sequence of
  addresses with a uniform skip between each referenced address. For example,
  sequence 1, 1001, 2001, 3001, 4001, 5001, … is a strided access pattern with
  a stride of +1000. Sequential access is a kind of strided access with stride
  +1, and reverse-sequential access has stride -1.

* **Access sizes**. The number of data units transferred per call is another
  aspect of an access pattern. For example, sequential byte reads transfer 1
  byte at a time, at contiguous addresses; sequential 4096-byte block reads
  transfer 4096 bytes at a time, at contiguous addresses.

These terms describe whole access patterns, but they are often used more
loosely, to describe parts of a reference string. For instance, we might see a
reference string that starts with a sequential region, then skips ahead by
tens of thousands of bytes and has another sequential region, then does some
stuff that you don’t understand that you classify as “random.”

This directory contains the `strace` output for different programs with
different access patterns.

1\. How would you describe the access pattern in `strace01.out`?

2\. How would you describe the access pattern in `strace02.out`?
