#include "helpers.hh"
#if __linux__
#include <sys/signalfd.h>
#endif
bool quiet = false;
double exit_delay = 0.5;
double timeout = 0.75;

int main(int argc, char** argv) {
    parse_arguments(argc, argv);

#if __linux__
    // Create a signalfd
    sigset_t mask;
    sigemptyset(&mask);
    sigaddset(&mask, SIGCHLD);
    int r = sigprocmask(SIG_BLOCK, &mask, nullptr);
    assert(r == 0);
    int sigfd = signalfd(-1, &mask, SFD_CLOEXEC);
    assert(sigfd >= 0);

    double start_time = tstamp();

    // Start a child
    pid_t p1 = fork();
    assert(p1 >= 0);
    if (p1 == 0) {
        if (exit_delay > 0.0) {
            usleep((unsigned) (exit_delay * 1000000));
        }
        if (!quiet) {
            fprintf(stderr, "Goodbye from %s child pid %d\n", argv[0], getpid());
        }
        exit(0);
    }

    // Wait for the timeout, or until something is written to `sigfd`,
    // whichever happens first
    fd_set fds;
    FD_ZERO(&fds);
    FD_SET(sigfd, &fds);
    struct timeval timeout_timeval = make_timeval(timeout);
    r = select(sigfd + 1, &fds, nullptr, nullptr, &timeout_timeval);

    int status;
    pid_t exited_pid = waitpid(p1, &status, WNOHANG);
    assert(exited_pid == 0 || exited_pid == p1);

    // Print results
    if (exited_pid == 0) {
        fprintf(stderr, "%s child %d timed out\n", argv[0], p1);
    } else if (WIFEXITED(status)) {
        double lifetime = tstamp() - start_time;
        if (!quiet || lifetime > exit_delay + 0.1) {
            fprintf(stderr, "%s child %d exited with status %d after %g sec\n",
                    argv[0], p1, WEXITSTATUS(status), lifetime);
        }
    } else {
        fprintf(stderr, "%s child %d exited abnormally [%x]\n",
                argv[0], p1, status);
    }

#else
    fprintf(stderr, "%s: This program only works on Linux.\n",
            argv[0]);
    exit(1);
#endif
}
