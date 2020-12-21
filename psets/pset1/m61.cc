#define M61_DISABLE 1
#include "m61.hh"
#include <cstdlib>
#include <cstring>
#include <cstdio>
#include <cinttypes>
#include <cassert>
#include <utility>
#include <string>
#include <algorithm>

// Counter type to store counters for heavy hitters
// `counter_t` is a pair whose first element stores
// (filename, line) and whose second element stores the count
typedef std::pair<std::pair<std::string, long>, size_t> counter_t;

/// metadata
///    Structure to store metadata for each allocation.
///    This metadata uses 64 bytes of memory per allocation and is
///    stored internally, immediately before the address of the pointer returned
///    to the user. The last 15 bytes of padding ensure an alignment of 16.

struct metadata {
    uintptr_t checksum;    // base address of metadata; acts as checksum
    size_t size;           // size of requested allocation in bytes
    const char* file;      // name of file requesting allocation
    long line;             // line number of call to allocation
    metadata* next;        // pointer to metadata of next block of allocated memory
    metadata* prev;        // pointer to metadata of previous block of allocated memory
    bool freed;            // flag indicating if block has already been freed
    char padding[15];      // padding to ensure alignment of 16
};

// Pointer to front of linked list consisting of metadata units
// This linked list will be used to check for memory leaks
metadata* front = nullptr;

// Arbitrary sequence of bytes to denote end of allocated memory
// Lack of obvious pattern to reduce chance of user writing these very bytes
const unsigned char terminator[] = {42, 183, 229, 13};

// Global variable to keep track of allocation stats
m61_statistics g_stats = {
    .nactive = 0,
    .active_size = 0,
    .ntotal = 0,
    .total_size = 0,
    .nfail = 0,
    .fail_size = 0,
    .heap_min = UINTPTR_MAX,
    .heap_max = 0
};

// Heavy hitters globals
const short n_counters = 5;
counter_t size_counters[n_counters];
counter_t freq_counters[n_counters];
size_t size_decr = 0;
size_t freq_decr = 0;


/// update_heavy_hitters(counters, decr, sz, file, line)
///    Updates heavy hitter data.
///    Implementation based on Algorithm FREQUENT, as defined in
///    Frequency Estimation of Internet Packet Streams with Limited Space,
///    Demaine, López-Ortiz, and Munro.

void update_heavy_hitters(counter_t counters[], size_t* decr, size_t sz, const char* file, long line) {
    short index = -1;   // index of counter monitoring this allocation
    // Check if already monitored
    for (short i = 0; i < n_counters; ++i) {
        if (counters[i].first == make_pair((std::string) file, line)) {
            index = i;
        }
    }
    // If not, check if some counter is zero
    if (index == -1) {
        for (short i = 0; i < n_counters; ++i) {
            if (counters[i].second == 0) {
                // Define this to be monitored element at index `i`
                counters[i].first = make_pair((std::string) file, line);
                index = i;
            }
        }
    }
    // If now monitored, increment counter
    if (index != -1) {
        counters[index].second += sz;
    } else {
        // Otherwise, decrement every counter
        size_t min_idx = 0;
        // Find index of minimum count
        for (short i = 1; i < n_counters; ++i) {
            if (counters[i].second < counters[min_idx].second) {
                min_idx = i;
            }
        }
        // If count is high enough, decrement all by `sz`
        if (sz <= counters[min_idx].second) {
            for (short i = 0; i < n_counters; ++i) {
                counters[i].second -= sz;
            }
            *decr += sz;
        } else {
            // Otherwise, only decrement all by the min count
            // to avoid entering negative counts
            // NOTE: Frequency updates should never enter this else branch
            for (short i = 0; i < n_counters; ++i) {
                counters[i].second -= counters[min_idx].second;
            }
            *decr += counters[min_idx].second;
            // Then simulate monitoring this allocation
            // and incrementing its count by the remaining bytes
            counters[min_idx].first = make_pair((std::string) file, line);
            counters[min_idx].second += sz - counters[min_idx].second;
        }
    }
}


/// m61_malloc(sz, file, line)
///    Return a pointer to `sz` bytes of newly-allocated dynamic memory.
///    The memory is not initialized. If `sz == 0`, then m61_malloc must
///    return a unique, newly-allocated pointer value. The allocation
///    request was at location `file`:`line`.

void* m61_malloc(size_t sz, const char* file, long line) {
    (void) file, (void) line;   // avoid uninitialized variable warnings

    metadata* metaptr = nullptr;
    void* ptr = nullptr;

    // Ensure size does not overflow after adding metadata + terminator
    if (sz <= SIZE_MAX - sizeof(metadata) - sizeof(terminator)) {
        metaptr = (metadata*) base_malloc(sz + sizeof(metadata) + sizeof(terminator));
    }

    if (metaptr) {
        metaptr->checksum = (uintptr_t) metaptr;
        metaptr->size = sz;
        metaptr->file = file;
        metaptr->line = line;
        metaptr->freed = false;

        // Linked list updates
        if (front) {
            front->prev = metaptr;
        }
        metaptr->next = front;
        metaptr->prev = nullptr;
        front = metaptr;

        ptr = metaptr + 1;
        
        memcpy((char*) ptr + sz, terminator, sizeof(terminator));

        // Statistics updates
        ++g_stats.ntotal;
        g_stats.total_size += sz;
        ++g_stats.nactive;
        g_stats.active_size += sz;

        uintptr_t addr = (uintptr_t) ptr;
        if (addr < g_stats.heap_min) {
            g_stats.heap_min = addr;
        }
        if (addr + sz - 1 > g_stats.heap_max) {
            g_stats.heap_max = addr + sz - 1;
        }

        // Heavy hitters updates
        update_heavy_hitters(size_counters, &size_decr, sz, file, line);  // size
        update_heavy_hitters(freq_counters, &freq_decr, 1, file, line);   // frequency
    } else {
        ++g_stats.nfail;
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
        // Ensure `ptr` is within range of allocated pointers in heap
        if ((uintptr_t) ptr < g_stats.heap_min || (uintptr_t) ptr > g_stats.heap_max) {
            fprintf(stderr, 
                "MEMORY BUG: %s:%li: invalid free of pointer %p, not in heap\n",
                file, line, ptr);
            abort();
        }
        metaptr = (metadata*) ptr - 1;

        // Ensure `ptr` was allocated earlier
        if ((uintptr_t) metaptr % alignof(max_align_t) != 0 || metaptr->checksum != (uintptr_t) metaptr) {
            fprintf(stderr,
                "MEMORY BUG: %s:%li: invalid free of pointer %p, not allocated\n",
                file, line, ptr);

            // Check if `ptr` is inside a different allocated block
            for (metadata* iterator = front; iterator; iterator = iterator->next) {
                if (ptr > iterator + 1 && ptr < (char*) (iterator + 1) + iterator->size) {
                    fprintf(stderr,
                        "%s:%li: %p is %li bytes inside a %lu byte region allocated here\n",
                        iterator->file, iterator->line, ptr,
                        (char*) ptr - (char*) (iterator + 1), iterator->size);
                }
            }

            abort();
        }
        // Ensure `ptr` has not already been freed
        if (metaptr->freed) {
            fprintf(stderr,
                "MEMORY BUG: %s:%li: invalid free of pointer %p, double free\n",
                file, line, ptr);
            abort();
        }
        // Check for boundary write errors
        if (memcmp((char*) ptr + metaptr->size, terminator, sizeof(terminator))) {
            fprintf(stderr,
                "MEMORY BUG: %s:%li: detected wild write during free of pointer %p\n",
                file, line, ptr);
            abort();
        }

        // Linked list updates
        metaptr->freed = true;
        if (metaptr->prev) {
            metaptr->prev->next = metaptr->next;
        } else {
            front = metaptr->next;
        }
        if (metaptr->next) {
            metaptr->next->prev = metaptr->prev;
        }

        // Statistics updates
        --g_stats.nactive;
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
        // Impossible to keep track of fail_size due to overflow,
        // so we only keep track of nfail
        ++g_stats.nfail;
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
    for (metadata* metaptr = front; metaptr; metaptr = metaptr->next) {
        printf("LEAK CHECK: %s:%li: allocated object %p with size %lu\n", 
            metaptr->file, metaptr->line, metaptr + 1, metaptr->size);
    }
}

/// compare(counter1, counter2)
///    Compare function for sorting `counter_t` arrays.

bool compare(counter_t counter1, counter_t counter2) {
    return counter1.second > counter2.second;
}

/// m61_print_heavy_hitter_report_helper(heavy)
///    Helper function that abstracts out behavior
///    common to both heavy hitter reports and frequent
///    hitter reports. Prints heavy hitter reports if `heavy` is 
///    true, or frequent hitter reports otherwise.

void m61_print_heavy_hitter_report_helper(bool heavy) {
    counter_t* counters = nullptr;
    size_t decr;
    unsigned long long total;
    if (heavy) {
        counters = size_counters;
        decr = size_decr;
        total = g_stats.total_size;
    } else {
        counters = freq_counters;
        decr = freq_decr;
        total = g_stats.ntotal;
    }
    std::sort(counters, counters + n_counters, compare);
    for (short i = 0; i < n_counters; ++i) {
        // Ensure positive count
        if (counters[i].second > 0) {
            size_t estimated_count = counters[i].second + decr;
            double percentage = (double) estimated_count / total * 100;
            if (percentage >= 20.0) {
                printf(heavy ? "HEAVY HITTER: %s:%li: %lu bytes (~%0.1f%%)\n"
                    : "FREQUENT HITTER: %s:%li: %lu allocations (~%0.1f%%)\n",
                    counters[i].first.first.c_str(),
                    counters[i].first.second, estimated_count, percentage);
            }
        }
    }
}

/// m61_print_heavy_hitter_report()
///    Print a report of heavily-used allocation locations.

void m61_print_heavy_hitter_report() {
    m61_print_heavy_hitter_report_helper(true);   // print heavy hitter reports
    m61_print_heavy_hitter_report_helper(false);  // print frequent hitter reports
}
