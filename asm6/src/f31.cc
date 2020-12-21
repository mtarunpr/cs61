//! -O1
//! -O3 -funroll-all-loops -mno-mmx -mno-sse

long f(const int* v, int n) {
    long sum = 0;
    for (int i = 0; i < n; ++i) {
        sum += v[i];
    }
    return sum;
}
