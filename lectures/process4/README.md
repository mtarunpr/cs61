CS61 2020: Process control 4
============================

Today’s meeting is about pipelines and blocking.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

1\. Data written to a pipe is buffered in the kernel until a reader
reads it. How would you write a program to experimentally derive the
size of that kernel buffer? Try it!

2\. In a shell pipeline, the writing process and the reading process
generally run in parallel. Is it possible for a writing process to
complete its work and successfully write data to the pipe before the
reading process *even begins*?
