#include <unistd.h>
#include <cstdio>
#include <cassert>

int main() {
    pid_t p1 = fork();
    assert(p1 >= 0);

    const char* identity = (p1 == 0 ? "child" : "initial");
    printf("Hello from %s pid %d\n", identity, getpid());
}
