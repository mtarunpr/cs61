#include <cstdio>
#include <thread>
#include <atomic>

#define NUM_THREADS 4

std::atomic_flag spinlock = ATOMIC_FLAG_INIT;

void threadfunc(unsigned* x) {
    for (int i = 0; i != 10000000; ++i) {
        while (spinlock.test_and_set()) {
        }

        *x += 1;

        spinlock.clear();
    }
}

int main() {
    std::thread th[NUM_THREADS];
    unsigned n = 0;
    for (int i = 0; i != NUM_THREADS; ++i) {
        th[i] = std::thread(threadfunc, &n);
    }
    for (int i = 0; i != NUM_THREADS; ++i) {
        th[i].join();
    }
    printf("%u\n", n);
}
