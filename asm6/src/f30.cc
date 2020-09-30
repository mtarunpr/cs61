//! -O1 -fno-if-conversion -fno-if-conversion2

unsigned f(unsigned a, unsigned b) {
    if (a < b) {
        return b;
    } else {
        return a;
    }
}
