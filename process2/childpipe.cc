#include <unistd.h>
#include <cstdio>
#include <cstring>
#include <cerrno>
#include <cassert>
#include <cstdlib>

int main() {
    // Create pipe
    int pipefd[2];
    int r = pipe(pipefd);
    assert(r == 0);

    pid_t p1 = fork();
    assert(p1 >= 0);

    if (p1 == 0) {
        // Child: Write message to pipe, then exit
        const char* message = "Hello, mama!\n";
        ssize_t nw = write(pipefd[1], message, strlen(message));
        assert(nw == (ssize_t) strlen(message));
        exit(0);

    } else {
        // Parent: Read all messages from child; exit when child
        // is done
        close(pipefd[1]); // I no write!!!!
        while (true) {
            char buf[BUFSIZ];
            ssize_t nr = read(pipefd[0], buf, sizeof(buf));
            if (nr == 0
                || (nr == -1 && errno != EINTR && errno != EAGAIN)) {
                break;
            } else if (nr > 0) {
                printf("I got a message! It was “%.*s”\n", (int) nr, buf);
            }
        }
        printf("No more messages :(\n");
        close(pipefd[0]);
        exit(0);
    }
}
