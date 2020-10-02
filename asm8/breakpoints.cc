#include "hexdump.hh"
#include <unistd.h>

int f() {
    return getpid() + 2;
}

int g() {
    return getpid() + 1;
}

int main() {
    hexdump((void*) f, 32);
    printf("%d\n", f());
}

