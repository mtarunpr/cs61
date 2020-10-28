#include <cstdio>
#include <cstdlib>
#include <cassert>
#include <unistd.h>
#include <sys/fcntl.h>

#define TESTFILE "consistency-test.txt"

void overwrite(const char* contents) {
    FILE* f = fopen(TESTFILE, "w");
    fputs(contents, f);
    fclose(f);
}

size_t read_using_stdio(char buf[BUFSIZ]) {
    overwrite("CS 61 is terrible!\n");

        FILE* f = fopen(TESTFILE, "r");
        size_t nr = fread(buf, 1, 9, f);
        assert(nr == 9);

    overwrite("CS 61 is awesome!!\n");

        nr += fread(buf + nr, 1, BUFSIZ - nr, f);
        fclose(f);
        return nr;
}

size_t read_using_syscalls(char buf[BUFSIZ]) {
    overwrite("CS 61 is terrible!\n");

        int fd = open(TESTFILE, O_RDONLY);
        ssize_t nr = read(fd, buf, 9);
        assert(nr == 9);

    overwrite("CS 61 is awesome!!\n");

        nr += read(fd, buf + nr, BUFSIZ - nr);
        close(fd);
        assert(nr >= 9);
        return nr;
}

int main() {
    char buf[BUFSIZ];

    printf("Reading using stdio:\n");
    size_t n = read_using_stdio(buf);
    fwrite(buf, 1, n, stdout);

    printf("\nReading using system calls:\n");
    n = read_using_syscalls(buf);
    fwrite(buf, 1, n, stdout);
}
