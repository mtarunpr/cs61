//! -O1 -fno-stack-protector
// Let's figure out the local variable layout convention on this compiler!
#include "hexdump.hh"

void f(int arg) {
    if (arg > 0) {
        printf("%d: %p\n", arg, &arg);
        f(arg - 1);
        printf("%d: %p\n", arg, &arg);
    } else {
        printf("%d: %p\n", arg, &arg);
    }
}

int main(int argc, char* argv[]) {
    (void) argv;
    f(argc);
}
