#include "hexdump.hh"
#include <utility>
#include <cstdio>

extern "C" {
[[gnu::noinline]]
void modify(std::pair<int, const char*>& p) {
    printf("modify:\n");
    hexdump_object(p);

    p = std::make_pair(2, "hello");
    hexdump_object(p);
}
}

int main() {
    std::pair<int, const char*> p;
    modify(p);
}
