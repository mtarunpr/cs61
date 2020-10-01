#include "hexdump.hh"
#include <map>
#include <cstdio>

extern "C" {
[[gnu::noinline]]
void modify(std::map<int, int>& m) {
    printf("modify:\n");
    printf("size %zu (0x%zx)\n", m.size(), m.size());
    hexdump_object(m);

    m.insert({2, 2});
    m.insert({4, 4});
    m.insert({1, 1});
    m.insert({5, 5});
    m.insert({3, 3});
    printf("size %zu (0x%zx)\n", m.size(), m.size());
    hexdump_object(m);
}

[[gnu::noinline]]
void iterate1(std::map<int, int>& m) {
    for (auto p : m) {
        hexdump_object(p);
    }
}

[[gnu::noinline]]
void iterate2(std::map<int, int>& m) {
    for (auto& p : m) {
        hexdump_object(p);
    }
}

[[gnu::noinline]]
void iterate3(std::map<int, int>& m) {
    for (auto it = m.begin(); it != m.end(); ++it) {
        hexdump_object(it);
    }
}
}

int main() {
    std::map<int, int> m;
    modify(m);

    printf("\niterate:\n");
    iterate1(m);
    iterate2(m);
    iterate3(m);
}
