#define M61_DISABLE 1
#include "m61.hh"
#include <cstdlib>
#include <cstring>
#include <cstdio>
#include <cinttypes>
#include <cassert>

struct metadata {
    uintptr_t checksum;
    size_t size;
    bool freed;
    char padding[15];
};

m61_statistics g_stats = {0, 0, 0, 0, 0, 0, UINTPTR_MAX, 0};

/// m61_malloc(sz, file, line)
///    Return a pointer to `sz` bytes of newly-allocated dynamic memory.
///    The memory is not initialized. If `sz == 0`, then m61_malloc must
///    return a unique, newly-allocated pointer value. The allocation
///    request was at location `file`:`line`.

void* m61_malloc(size_t sz, const char* file, long line) {
    (void) file, (void) line;   // avoid uninitialized variable warnings

    metadata* metaptr = nullptr;
    void* ptr = nullptr;

    // Ensure size does not overflow after adding 16 bytes of metadata
    if (sz <= SIZE_MAX - sizeof(metadata)) {
        metaptr = (metadata*) base_malloc(sz + sizeof(metadata));
    }

    if (metaptr) {
        metaptr->checksum = (uintptr_t) metaptr;
        metaptr->size = sz;
        metaptr->freed = false;
        ptr = metaptr + 1;

        g_stats.ntotal++;
        g_stats.total_size += sz;
        g_stats.nactive++;
        g_stats.active_size += sz;

        uintptr_t addr = (uintptr_t) ptr;
        if (addr < g_stats.heap_min) {
            g_stats.heap_min = addr;
        }
        if (addr + sz - 1 > g_stats.heap_max) {
            g_stats.heap_max = addr + sz - 1;
        }
    } else {
        g_stats.nfail++;
        g_stats.fail_size += sz;
    }
    return ptr;
}


/// m61_free(ptr, file, line)
///    Free the memory space pointed to by `ptr`, which must have been
///    returned by a previous call to m61_malloc. If `ptr == NULL`,
///    does nothing. The free was called at location `file`:`line`.

void m61_free(void* ptr, const char* file, long line) {
    metadata* metaptr = nullptr;

    if (ptr) {
        if ((uintptr_t) ptr < g_stats.heap_min || (uintptr_t) ptr > g_stats.heap_max) {
            fprintf(stderr, "MEMORY BUG: %s:%li: invalid free of pointer %p, not in heap\n", file, line, ptr);
            abort();
        }

        metaptr = (metadata*) ptr - 1;

        if (metaptr->checksum != (uintptr_t) metaptr) {
            fprintf(stderr, "MEMORY BUG: %s:%li: invalid free of pointer %p, not allocated\n", file, line, ptr);
            abort();
        }

        if (metaptr->freed) {
            fprintf(stderr, "MEMORY BUG: %s:%li: invalid free of pointer %p, double free\n", file, line, ptr);
            abort();
        }

        metaptr->freed = true;
        g_stats.nactive--;
        g_stats.active_size -= metaptr->size;
    }
    base_free(metaptr);
}


/// m61_calloc(nmemb, sz, file, line)
///    Return a pointer to newly-allocated dynamic memory big enough to
///    hold an array of `nmemb` elements of `sz` bytes each. If `sz == 0`,
///    then must return a unique, newly-allocated pointer value. Returned
///    memory should be initialized to zero. The allocation request was at
///    location `file`:`line`.

void* m61_calloc(size_t nmemb, size_t sz, const char* file, long line) {

    void* ptr = nullptr;

    // Ensure `nmemb * sz` does not overflow 
    if (nmemb <= SIZE_MAX / sz) {
        ptr = m61_malloc(nmemb * sz, file, line);
    } else {
        // Impossible to keep track of fail_size due to oveflow,
        // so we only keep track of nfail
        g_stats.nfail++;
    }
    
    if (ptr) {
        memset(ptr, 0, nmemb * sz);
    }
    return ptr;
}


/// m61_get_statistics(stats)
///    Store the current memory statistics in `*stats`.

void m61_get_statistics(m61_statistics* stats) {    
    *stats = g_stats;
}


/// m61_print_statistics()
///    Print the current memory statistics.

void m61_print_statistics() {
    m61_statistics stats;
    m61_get_statistics(&stats);

    printf("alloc count: active %10llu   total %10llu   fail %10llu\n",
           stats.nactive, stats.ntotal, stats.nfail);
    printf("alloc size:  active %10llu   total %10llu   fail %10llu\n",
           stats.active_size, stats.total_size, stats.fail_size);
}


/// m61_print_leak_report()
///    Print a report of all currently-active allocated blocks of dynamic
///    memory.

void m61_print_leak_report() {
    // Your code here.
}


/// m61_print_heavy_hitter_report()
///    Print a report of heavily-used allocation locations.

void m61_print_heavy_hitter_report() {
    // Your heavy-hitters code here
}
