CS61 2020: Kernel 7
===================

Today’s meeting is about confused deputy attacks, segments, and process
creation.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

1\. This operating system runs two processes, `p-hello.cc` and `p-yield.cc`.
The processes have isolated address spaces. Which lines of kernel code are
ensuring isolation? How does that code work?

2\. Modify the arguments to one system call in `p-hello.cc` to destroy some
portion of `yield`’s memory or registers and prevent it from running.

(If you have additional time, also complete the first step in P1.)

P1\. Segments
-------------

1\. This operating system’s `process_setup` function has an expanded comment
describing program segments. Read the comment and talk through the segment
concepts with your group.

2\. `process_setup` works using two loops. In the first loop, new process
memory is allocated and mapped. In the second loop, data is copied from the
program image into the newly-allocated memory. The second loop only works
because process images are initially identity-mapped.

The following helper function could be used to integrate memory initialization
into the first loop (and make the second loop redundant).

```c++
// initialize_segment_page(pg, va, seg)
//    Initialize the single page of memory at kernel address `pg`
//    using `seg` to the page of initial process memory at
//    process virtual address `va`.
//    This will zero the page, and may copy some data from `seg.data()`
//    into the page depending on `va`.
//    Requires that `pg` and `va` are page-aligned.
void initialize_segment_page(char* pg, uintptr_t va,
                             const program_image_segment& seg) {
    assert(va % PAGESIZE == 0 && (uintptr_t) pg % PAGESIZE == 0);
    // ... Your code here ...
}
```

It would be called from the first loop as follows.

```c++
            initialize_segment_page((char*) pg, va, seg);
```

However, implementing this function is tricky, because of the edge cases shown
in the segment diagram (especially different page alignments). Discuss these
edge cases and sketch an algorithm for implementing the function. Implement
and test your algorithm if you have time.

**Hint:** First consider the case where `seg.va()` is page aligned (`seg.va()
% PAGESIZE == 0`). Then extend your logic to handle the case when `seg.va()`
is not page aligned.

P2\. Spawn
----------

The `sys_spawn` system call should create a new process. It is called as
`sys_spawn(PROGRAMNAME)`. The implementation of `sys_spawn` should:

1. Find an unused process slot.
2. Initialize that process slot to a new process running the named program.
3. Return the process ID of the new process.

An implementation of `sys_spawn` can start from the code in `process_setup`,
but must use fully virtual page allocation, rather than the current
`process_setup`’s identity mapping.

1\. Discuss how to implement `sys_spawn` and try to implement it. `make
run-spawn` to check your work.

2\. How does `sys_spawn` differ from `sys_fork`? Are there reasons to prefer
one interface over the other?
