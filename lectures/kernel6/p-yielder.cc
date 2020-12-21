#include "u-lib.hh"

void process_main() {
    console_printf(0x1F00, "Yielding!\n");
    for (int i = 1; i <= 3; ++i) {
        int r = sys_yield();
        console_printf(0x1F00, "yielder: yield #%d returns %d\n", i, r);
    }
    while (true) {
        sys_yield();
    }
}
