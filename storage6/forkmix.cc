#include <cstdio>
#include <cstring>
#include <cassert>
#include "unistd.h"

int main(int argc, char* argv[]) {
    // use stdio unless the `-y` flag is provided
    bool use_stdio = true;
    if (argc > 1) {
        assert(strcmp(argv[1], "-s") == 0 || strcmp(argv[1], "-y") == 0);
        use_stdio = strcmp(argv[1], "-s") == 0;
    }

    // fork one child
    pid_t p1 = fork();
    assert(p1 >= 0);

    const char* identity;
    if (p1 == 0) {
        identity = "BABY\n";
    } else {
        identity = "mama\n";
    }

    // maybe reopen stdout
    //freopen("data", "w", stdout);

    // print process’s identity 1,000,000 times
    if (use_stdio) {
        for (int i = 0; i != 1000000; ++i) {
            fputs(identity, stdout);
        }
    } else {
        for (int i = 0; i != 1000000; ++i) {
            ssize_t nw = write(STDOUT_FILENO, identity, 5);
            assert(nw == 5);
        }
    }
}
