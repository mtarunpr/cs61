#include <cstdio>
#include <cstdlib>
#include <cassert>
#include <unistd.h>

int main() {
    char buf[BUFSIZ];

    // Prepare a buffer.
    int buflen = snprintf(buf, sizeof(buf), "%ld\n", random());
    // Print that buffer to stdout.
    ssize_t n = write(STDOUT_FILENO, buf, buflen);
    assert(n == buflen);

    snprintf(buf, sizeof(buf), "%d\n", getpid());
    n = write(STDOUT_FILENO, buf, buflen);
    assert(n == buflen);
}
