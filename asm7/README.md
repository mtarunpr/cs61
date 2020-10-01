CS61 2020: Assembly 7
=====================

Today’s lecture will discuss assembly and data representation for C++ library
structures.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

1\. Examine `stringrep.cc`. This program creates a string, extends its length,
and iterates over its characters.

2\. Examine `vectorrep.cc`. This program performs similar actions on a vector
of characters. (Vectors are C++’s datatype for dynamically sized arrays.)

3\. Run `make; ./stringrep | less` and think about the results. Come prepared
with any questions you have. You may want to use gdb to examine the contents
of memory at various points, or `objdump -d` to examine the assembly. Some
example questions:

* Which parts of `std::string`’s representation seem to have similar meaning
  in all three hexdumps from `modify`?
* What differentiates the addresses and values in the `iterate*` loops?

4\. If you have extra time, repeat this exercise for `./vectorrep | less`.
