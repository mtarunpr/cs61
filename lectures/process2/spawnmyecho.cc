#include "helpers.hh"
#include <spawn.h>

int main() {
    const char* args[] = {
        "./myecho", // argv[0] is the string used to execute the program
        "Hello, world",
        nullptr
    };

    fprintf(stderr, "About to spawn myecho from pid %d\n", getpid());

    pid_t p;
    int r = posix_spawn(&p, "./myecho", nullptr, nullptr,
                        (char**) args, nullptr);

    assert(r == 0);
    fprintf(stderr, "Parent pid %d spawned child pid %d with status %d\n",
            getpid(), p, r);
}
