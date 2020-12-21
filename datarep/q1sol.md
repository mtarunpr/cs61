Data representation solution
============================
(a) Although it is not required to do the computation by hand, the calculation is shown here for clarity.

```
  0001 1110 0110 1001 1110 1111 0000
^ 0001 1010 0100 1011 0001 0101 0000
------------------------------------
  0000 0100 0010 0010 1111 1010 0000
------------------------------------
```

In hexadecimal, this value comes out to be `0x422fa0`.

(b) Similarly, we can calculate `0x422fa0 ^ 0x1e69ef0`:

```
  0001 1110 0110 1001 1110 1111 0000
^ 0000 0100 0010 0010 1111 1010 0000
------------------------------------
  0001 1010 0100 1011 0001 0101 0000
------------------------------------
```
In hexadecimal, the resulting value is `0x1a4b150`. Notice that this is the same as `ptr2`, which suggests that computing the XOR of the result and one of the original operands yields the other one.

(c) The size of `metadata` is 64 bytes and its alignment is 8.

(d) The `struct` can be redefined as follows: 

```c++
struct metadata {
    uintptr_t checksum;    // base address of metadata; acts as checksum
    size_t size;           // size of requested allocation in bytes
    const char* file;      // name of file requesting allocation
    long line;             // line number of call to allocation
    uintptr_t link;        // bitwise XOR of next and previous addresses
    bool freed;            // flag indicating if block has already been freed
};
```

This new `struct` has a size of 48 bytes. Note that the padding of 7 bytes need not be explicitly included in the `struct` as it is added automatically to ensure that its size (48) is a multiple of its alignment (8). Also note that `link` must be of type `uintptr_t` and not `metadata*` to avoid forming a pointer to some arbitrary location in memory (at the address computed by the bitwise XOR), which constitutes undefined behavior.

(e) The solution is as follows: 

```c++
void m61_print_leak_report() {
    metadata* metaptr = front;
    uintptr_t prev = 0;
    uintptr_t next = 0;
    while (metaptr) {
        printf("LEAK CHECK: %s:%li: allocated object %p with size %lu\n", 
             metaptr->file, metaptr->line, metaptr + 1, metaptr->size);
        next = prev ^ metaptr->link;
        prev = (uintptr_t) metaptr;
        metaptr = (metadata*) next;
    }
}
```

NB: In practice, it may not be the best idea to implement such a linked list for problem set 1 because of other considerations/complications (e.g., when freeing) that may increase the run time. However, this question serves to simply demonstrate this application of XOR and its potential usefulness in certain situations. 