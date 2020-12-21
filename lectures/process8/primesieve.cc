#include "helpers.hh"
void append_filter(char** argv);

int main() {
    // Start with a filter chain that produces all integers starting from 2

    // Your code here!


    int n;
    while (scanf("%d", &n) == 1) {
        // `n` is the next prime; print it to stdout
        printf("%d\n", n);

        // Append a filter that eliminates all multiples of `n`

        // Your code here!
    }
}


// append_filter(argv)
//    Append a process running the `argv[0]` program (with arguments `argv`)
//    to the current filter chain.

void append_filter(char** argv) {
    (void) argv;
    // Your code here (if you'd like)
}
