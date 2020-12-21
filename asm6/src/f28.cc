unsigned f(unsigned a) {
    if (a > 0) {
        return a + f(a - 1);
    } else {
        return 0;
    }
}
