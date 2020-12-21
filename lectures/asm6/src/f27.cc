//! -O1 -fno-stack-protector
//@disassemble _Z1fPc
#include "hexdump.hh"

char* f(char* s) {
    char* comma = strchr(s, ',');
    if (comma) {
        *comma = 0;
        char* nexts = f(comma + 1);
        int cmp = strcmp(s, nexts);
        printf("\"%s\" %c \"%s\"\n", s, '<' + (cmp >= 0) + (cmp > 0), nexts);
    }
    return s;
}

int main(int argc, char* argv[]) {
    assert(argc > 1);
    f(argv[1]);
}
