#include "iobench.hh"
bool quiet = false;
double start_tstamp;

int main(int argc, char* argv[]) {
    int fd = STDIN_FILENO;
    if (isatty(fd)) {
        fd = open(DATAFILE, O_RDONLY);
    }
    if (fd < 0) {
        perror("open");
        exit(1);
    }

    size_t size = filesize(fd);
    size_t nread = size;
    parse_arguments(argc, argv, &nread, nullptr);

    char* buf = (char*) malloc(1);
    start_tstamp = tstamp();

    off_t pos = size;
    size_t n = 0;
    while (n < nread) {
        pos -= 1;
        if (lseek(fd, pos, SEEK_SET) == (off_t) -1) {
            perror("lseek");
            exit(1);
        }
        ssize_t r = read(fd, buf, 1);
        if (r == -1) {
            perror("read");
            exit(1);
        } else if (r != 1) {
            break;
        }
        n += r;
        if (n % PRINT_FREQUENCY == 0) {
            report(n);
        }
    }

    close(fd);
    report(n, true);
}
