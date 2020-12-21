//! -O1 -fno-stack-protector
// Let's figure out the local variable layout convention on this compiler!
#include "hexdump.hh"

void f(int args[6]) {
    int a = args[0];
    int b = args[1];
    short c = args[2];
    short d = args[3];
    signed char e = args[4];
    signed char f = args[5];

    hexdump_object(a);
    hexdump_object(b);
    hexdump_object(c);
    hexdump_object(d);
    hexdump_object(e);
    hexdump_object(f);
}

int main() {
    int a[6];
    for (int i = 0; i != 6; ++i) {
        a[i] = random();
    }
    f(a);
}
