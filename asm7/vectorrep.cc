#include "hexdump.hh"
#include <vector>
#include <cstdio>

extern "C" {
[[gnu::noinline]]
void modify(std::vector<char>& v) {
    // print representations of an empty vector and a small vector
    printf("modify:\n");
    printf("size %zu (0x%zx), capacity %zu (0x%zx), data %p\n",
           v.size(), v.size(), v.capacity(), v.capacity(), v.data());
    hexdump_object(v);

    v.push_back('s');
    v.push_back('h');
    v.push_back('o');
    v.push_back('r');
    v.push_back('t');
    printf("size %zu (0x%zx), capacity %zu (0x%zx), data %p\n",
           v.size(), v.size(), v.capacity(), v.capacity(), v.data());
    hexdump_object(v);
}

[[gnu::noinline]]
void iterate1(std::vector<char>& v) {
    for (auto ch : v) {
        hexdump_object(ch);
    }
}

[[gnu::noinline]]
void iterate2(std::vector<char>& v) {
    for (auto& ch : v) {
        hexdump_object(ch);
    }
}

[[gnu::noinline]]
void iterate3(std::vector<char>& v) {
    for (auto it = v.begin(); it != v.end(); ++it) {
        hexdump_object(it);
    }
}
}

int main() {
    std::vector<char> v;
    modify(v);

    printf("\niterate:\n");
    iterate1(v);
    iterate2(v);
    iterate3(v);
}
