CS61 2020: Kernel 5
===================

Today’s lecture is about how page tables are implemented.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

The x86-64 memory system is based on *page translation*. Virtual memory and
physical memory are both organized as aligned *pages*, where a page comprises
4096 bytes (2<sup>12</sup>, or 0x1000) starting at an address that is a
multiple of 4096. Physical memory is contiguous—basically an array. However,
virtual address translation, as implemented by page tables, means that virtual
memory is *not* necessarily contiguous. Any virtual page can map to any
physical page, and there can be gaps in the virtual address space (such as the
large, unmapped gap between the data and stack segments).

Page table translation can map a virtual page to any physical page. However,
the same mapping applies to all addresses within a page. If virtual address
`va` (a multiple of 4096) maps to physical address `pa` (which must also be a
multiple of 4096), then `va+2` maps to `pa+2`, and `va+4000` maps to
`pa+4000`. However, `va+4096`, which starts a different page, may map to *any*
aligned physical address (or to nothing at all).

1\. Given the following address translation function, `page_v2p`:

```c++
// Returns the physical address corresponding to virtual address `va`
// in the current page table. IMPORTANT CAVEAT: `va` must be page-aligned.
uint64_t page_v2p(uintptr_t va) {
    assert((va % PAGESIZE) == 0);
    /* ... */
}
```

Use `page_v2p` and address arithmetic to complete this address translation
function, `addr_v2p`, which does the same job but is not restricted to
page-aligned addresses.

```c++
// Returns the physical address corresponding to virtual address `va`
// in the current page table.
uint64_t addr_v2p(uintptr_t va) {
    // Your code here
}
```

2\. Say that x86-64 implemented page tables as a simple array of physical
addresses, where the mapping for the virtual page starting at address `va` was
stored in the array at index `va >> 12`. What’s a lower bound on the amount of
memory required to represent the page table for a Linux process?
