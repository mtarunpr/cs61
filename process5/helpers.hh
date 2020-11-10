#ifndef HELPERS_HH
#define HELPERS_HH
#include <unistd.h>
#include <cstdio>
#include <cassert>
#include <cstdlib>
#include <cstring>
#include <cctype>
#include <cmath>
#include <csignal>
#include <ctime>
#include <sys/wait.h>
#include <sys/time.h>
#include <sys/select.h>
#include <sched.h>
#include <errno.h>

// tstamp()
//    Return the current time as a double.

inline double tstamp() {
    struct timespec tv;
    clock_gettime(CLOCK_REALTIME, &tv);
    return tv.tv_sec + tv.tv_nsec * 1.0e-9;
}


// set_signal_handler(signo, handler)
//    Install `handler` as the signal handler for `signo`.
//    The `handler` is automatically re-installed after signal delivery.
//    Has the same interface as `signal()` (`man 2 signal`), but is portable.

inline int set_signal_handler(int signo, void (*handler)(int)) {
    struct sigaction sa;
    sa.sa_handler = handler;    // call `handler` on signal
    sigemptyset(&sa.sa_mask);   // don't block other signals in handler
    sa.sa_flags = 0;            // don't restart system calls
    return sigaction(signo, &sa, nullptr);
}


// parse_arguments(argc, argv)
//    Parse arguments for `-q`, `-e DELAY`, `-t DELAY`.

inline void parse_arguments(int argc, char* argv[]) {
    extern bool quiet;
    extern double exit_delay, timeout;
    int ch;
    while ((ch = getopt(argc, argv, "qe:t:")) != -1) {
        double* ptr = nullptr;
        if (ch == 'e') {
            ptr = &exit_delay;
        } else if (ch == 't') {
            ptr = &timeout;
        } else if (ch == 'q') {
            quiet = true;
        }
        if (ptr) {
            char* endptr;
            double val = strtod(optarg, &endptr);
            if (*endptr == '\0') {
                *ptr = val;
            }
        }
    }
}

#endif
