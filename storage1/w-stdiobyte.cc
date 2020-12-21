#include "iobench.hh"
bool quiet = false;
double start_tstamp;

int main(int argc, char* argv[]) {
    FILE* f = stdout;
    if (isatty(fileno(f))) {
        f = fopen(DATAFILE, "w");
    }
    if (!f) {
        perror("fopen");
        exit(1);
    }

    size_t size = 51200000;
    parse_arguments(argc, argv, &size, nullptr);

    const char* buf = "6";
    start_tstamp = tstamp();

    size_t n = 0;
    while (n < size) {
        size_t r = fwrite(buf, 1, 1, f);
        if (r != 1) {
            perror("write");
            exit(1);
        }
        n += r;
        if (n % PRINT_FREQUENCY == 0) {
            report(n);
        }
    }

    fclose(f);
    report(n, true);
}
