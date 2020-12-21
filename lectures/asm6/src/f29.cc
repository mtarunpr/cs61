//! -O0

extern int g(int);

int f(int a, int b) {
    int x = g(a);
    int y = g(b);
    int z = g(x + y);
    int w = g(y + z);
    int v = g(z + w);
    return g(w + v);
}
