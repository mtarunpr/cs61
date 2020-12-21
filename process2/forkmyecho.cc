#include <unistd.h>
#include <cstdio>
#include <cassert>
#include <cstdlib>
#include <sys/wait.h>

int main() {
    const char* args[] = {
        "./myecho", // argv[0] is the string used to execute the program
        "Hello, world",
        nullptr
    };

    pid_t p = fork();
    assert(p >= 0);

    if (p == 0) {
        int r = execv("./myecho", (char**) args);

        fprintf(stderr, "Error: execv returned %d in pid %d\n", r, getpid());
        exit(1);
    } else {
        fprintf(stderr, "Parent pid %d forked child pid %d\n", getpid(), p);
    }
}
