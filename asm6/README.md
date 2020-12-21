CS61 2020: Assembly 6
=====================

Today’s lecture will discuss compiler optimizations.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

1\. The function in `src/f28.cc` is recursive. Look at the function and
understand what it does.

2\. Create a couple different compiled versions using different optimization
and compilation flags. We found the following compiled versions; can you find
at least three of these? (Even better, can you find *all* of them, and more?)

* A version containing a recursive call.
* A version containing a loop.
* A version containing *no* loop.
* A version containing two conditional branches and zero unconditional branches.
* A version containing one conditional branch and one unconditional branch.
* A version containing one conditional branch and zero unconditional branches.
* A version containing *zero branches*.
* A version referring to 128-bit registers, which have names like `%xmm0`.

You will learn the most if, for each compiled version, you spend a minute
trying to understand why the assembly correctly implements the function. (That
said, course staff have no idea why the `%xmm0` version correctly implements
the function.)

The main flags that you will use are the following. The flags can be combined;
for instance, `make COMPILER=gcc O=0` builds with the g++ compiler and no
optimization.

* `make COMPILER=gcc`: Build with [the g++ compiler](https://gcc.gnu.org/).
* `make COMPILER=clang`: Build with [the clang++ compiler](https://clang.llvm.org/).

* `make O=0`: Build with the `-O0` flag, which turns off optimization.
* `make O=1`: Build with the `-O1` flag, which turns on optimization.
* `make O=2`: Build with the `-O2` flag, which turns on even more
  optimization. Compared with `-O1`, `-O2` performs stronger code analysis
  takes more compilation time.
* `make O=3`: Build with the `-O3` flag, which turns on even more
  optimization. Compared with `-O2`, `-O3` can cause greatly expand the number
  of instructions it takes to represent a function, but the expanded functions
  will generally execute faster.
* `make O=s`: Build with the `-Os` flag. This turns on optimization, but asks
  the compiler to minimize the *number of instructions in the function* rather
  than the expected time it takes to execute the function.
* `make O=z` (`COMPILER=clang` only): Build with the `-Oz` flag, which is like
  `-Os` but tries to reduce instruction count even more.

Optimization can be controlled in an even more fine-grained way by supplying
[optimization flags](https://gcc.gnu.org/onlinedocs/gcc-9.3.0/gcc/Optimize-Options.html).
Our makefiles support this by the `CXXFLAGS=` parameter. Go nuts if you’d
like. The following options may be interesting:

* `-fomit-frame-pointer` or `-fno-omit-frame-pointer`: Control `%rbp` usage
* `-funroll-all-loops`: “Unroll loops”, which makes loops take more
  instructions but branch less frequently, even when doing so seems silly
