#include "u-lib.hh"

void process_main() {
    console_printf(0x0F00, "Hello from spawner!\n");
    pid_t y1pid = sys_spawn("yielder");
    assert(y1pid > 0 && y1pid != sys_getpid());
    pid_t y2pid = sys_spawn("yielder");
    assert(y2pid > 0 && y2pid != sys_getpid() && y2pid != y1pid);
    for (int i = 1; i <= 3; ++i) {
        int r = sys_yield();
        console_printf(0x0F00, "hello: yield #%d returns %d\n", i, r);
    }
    while (true) {
        sys_yield();
    }
}
