#include "hexdump.hh"
#include <ctime>

struct example {
    int x;
    int y;
    int z;
    int w;
};

int main() {
    example e;

    e.x = 61;
    e.y = 62;
    e.z = 63;
    e.w = 64;

    hexdump_object(e);
}
