#include "u-lib.hh"

void process_main() {
    console_printf(0x0F00, "Hello!\n");
    for (int i = 1; i <= 3; ++i) {
        int r = sys_getpid();
        console_printf(0x0F00, "hello: getpid #%d returns %d\n", i, r);
    }
    for (int i = 1; i <= 3; ++i) {
        int r = sys_yield();
        console_printf(0x0F00, "hello: yield #%d returns %d\n", i, r);
    }
    while (true) {
        sys_yield();
    }
}
