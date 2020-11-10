#include "helpers.hh"
bool quiet = false;
double exit_delay = 0.5;
double timeout = 0.75;

void signal_handler(int signal) {
    (void) signal;
}

int main(int argc, char** argv) {
    parse_arguments(argc, argv);

    // Demand that SIGCHLD interrupt system calls
    int r = set_signal_handler(SIGCHLD, signal_handler);
    assert(r >= 0);

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

    // Wait for the child and print its status
    r = usleep((unsigned) (timeout * 1000000));
    (void) r;

    int status;
    pid_t exited_pid = waitpid(p1, &status, WNOHANG);
    assert(exited_pid == 0 || exited_pid == p1);
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
}
