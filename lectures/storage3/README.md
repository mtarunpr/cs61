CS61 2020: Storage 3
====================

Today’s meeting discusses file APIs.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

The Unix API for file access uses the following system calls (among
others): `open`, `read`, `write`, `close`, `lseek`, `fstat`.

1\. Read the manual page for `open`. What C++ data type is used to
represent open files, as far as system calls are concerned?

2\. Read the manual page for `lseek`. How could you use `lseek` to
return the size of an open file?

3\. Read the manual page for `fstat`. How could you use `fstat` to
return the size of an open file?

4\. How could you use `lseek` and `read` to read a file in *reverse
order* (last byte first)?
