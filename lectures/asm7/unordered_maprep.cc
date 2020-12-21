#include "hexdump.hh"
#include <unordered_map>
#include <cstdio>

extern "C" {
[[gnu::noinline]]
void modify(std::unordered_map<int, int>& m) {
    printf("modify:\n");
    printf("size %zu (0x%zx), bucket_count %zu (0x%zx)\n",
           m.size(), m.size(), m.bucket_count(), m.bucket_count());
    hexdump_object(m);

    m.insert({2, 2});
    m.insert({4, 4});
    m.insert({1, 1});
    m.insert({5, 5});
    m.insert({3, 3});
    printf("size %zu (0x%zx), bucket_count %zu (0x%zx)\n",
           m.size(), m.size(), m.bucket_count(), m.bucket_count());
    hexdump_object(m);
}

[[gnu::noinline]]
void iterate1(std::unordered_map<int, int>& m) {
    for (auto p : m) {
        hexdump_object(p);
    }
}

[[gnu::noinline]]
void iterate2(std::unordered_map<int, int>& m) {
    for (auto& p : m) {
        hexdump_object(p);
    }
}

[[gnu::noinline]]
void iterate3(std::unordered_map<int, int>& m) {
    auto it = m.begin(), last = m.end();
    while (it != last) {
        hexdump_object(it);
        ++it;
    }
}

[[gnu::noinline]]
void iterate4(std::unordered_map<int, int>& m) {
    // HERE BE DRAGONS!
    size_t nbuckets = m.bucket_count();
    for (size_t bucket = 0; bucket != nbuckets; ++bucket) {
        auto it = m.begin(bucket), last = m.end(bucket);
        while (it != last) {
            hexdump_object(*it);
            ++it;
        }
    }
}
}

int main() {
    std::unordered_map<int, int> m;
    modify(m);

    printf("\niterate:\n");
    iterate1(m);
    iterate2(m);
    iterate3(m);
    iterate4(m);
}
