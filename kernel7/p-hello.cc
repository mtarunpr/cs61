#include "u-lib.hh"

void process_main() {
    char buf[100];
    sys_getsysname(buf, sizeof(buf));
    console_printf(0x0F00, "Hello from %s!\n", buf);
    for (int i = 1; i <= 3; ++i) {
        int r = sys_yield();
        console_printf(0x0F00, "hello: yield #%d returns %d\n", i, r);
    }
    while (true) {
        sys_yield();
    }
}
