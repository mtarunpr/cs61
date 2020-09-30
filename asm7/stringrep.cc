#include "hexdump.hh"
#include <string>
#include <cstdio>

extern "C" {
[[gnu::noinline]]
void modify(std::string& s) {
    // print representations of a medium-length C++ string and a long one
    printf("modify:\n");
    s = "medium-length";
    printf("length %zu (0x%zx), capacity %zu (0x%zx), data “%s”\n",
           s.length(), s.length(), s.capacity(), s.capacity(), s.c_str());
    hexdump_object(s);

    s += " was this string in the past, but now it is long";
    printf("length %zu (0x%zx), capacity %zu (0x%zx), data “%s”\n",
           s.length(), s.length(), s.capacity(), s.capacity(), s.c_str());
    hexdump_object(s);

    s = "short";
    printf("length %zu (0x%zx), capacity %zu (0x%zx), data “%s”\n",
           s.length(), s.length(), s.capacity(), s.capacity(), s.c_str());
    hexdump_object(s);
}

[[gnu::noinline]]
void iterate(std::string& s) {
    // print representations of foreach-based and iterator-based iteration
    printf("\niterate:\n");

    // First, iterate over the characters of the string.
    for (auto ch : s) {
        hexdump_object(ch);
    }
    // Second, iterate over references to the characters of the string.
    for (auto& ch : s) {
        hexdump_object(ch);
    }
    // Third, use explicit iterators to traverse over the string.
    for (auto it = s.begin(); it != s.end(); ++it) {
        hexdump_object(it);
    }
}
}

int main() {
    std::string s;
    modify(s);
    iterate(s);
}
