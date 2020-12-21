#include "helpers.hh"
void append_filter(char** argv);

int main() {
    // Turn off buffering on stdin and stdout
    // It is *extremely important* that `primesieve` do this! Why?
    // Test without it -- use `strace` to examine what happens.
    setvbuf(stdin, nullptr, _IONBF, 0);
    setvbuf(stdout, nullptr, _IONBF, 0);

    // Start with a filter chain that produces all integers starting from 2
    {
        const char* argv[] = { "seq", "2", "1000000", nullptr };
        append_filter((char**) argv);
    }

    int n;
    while (scanf("%d", &n) == 1) {
        // `n` is the next prime; print it to stdout
        printf("%d\n", n);

        // Append a filter that eliminates all multiples of `n`
        char buf[20];
        sprintf(buf, "%d", n);
        const char* argv[] = { "./filtermultiples", buf, nullptr };
        append_filter((char**) argv);
    }
}


// append_filter(argv)
//    Append a process running the `argv[0]` program (with arguments `argv`)
//    to the current filter chain. On return, the new process reads from
//    the previous standard input, and the new standard input reads from
//    the new process’s standard output.

void append_filter(char** argv) {
    // Create pipe and child process
    int pipefd[2];
    int r = pipe(pipefd);
    assert(r >= 0);

    pid_t pid = fork();
    assert(pid >= 0);

    if (pid == 0) {
        // Child process (1) standard input reads from our previous standard
        // input (which requires no file descriptor manipulations, because
        // standard input is inherited!), and (2) standard output writes to the
        // write end of the pipe.
        close(pipefd[0]);  // hygiene
        dup2(pipefd[1], STDOUT_FILENO);
        close(pipefd[1]);  // hygiene

        execvp(argv[0], (char**) argv);
        _exit(1);
    }

    // Parent process's standard input is switched to read from the
    // read end of the pipe.
    dup2(pipefd[0], STDIN_FILENO);
    close(pipefd[0]);  // hygiene
    close(pipefd[1]);  // hygiene
}
