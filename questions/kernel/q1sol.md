Kernel solution
===============
(a) XYZ = e41. This is because pages are of size and alignment 0x1000, and the contents of a page are contiguous across virtual and physical memory.

(b) L4 and L3 would both be 0. L2 would be 1, and L1 would be 149.

(c) (3 x 2^28) / 2^12 x 2^3 = 1572864 bytes.

(d) 6 x 4096 = 24576 bytes. (1 page each for L4, L3, and L2; 3 L1 pages to account for the 1024 non-page table pages plus the page table pages.)
