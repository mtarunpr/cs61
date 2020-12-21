// subprocess(file, argv, pfd)
//    Run the command `file` with arguments `argv` in a child process.
//    Three pipes are opened between this process and the child process:
//    one for the child’s standard input, one for its standard output,
//    and one for its standard error. The `pfd` argument is populated
//    with this process’s pipe ends.
//
//    * Data written by this process to `pfd[0]` is read from the child’s
//      standard input.
//    * Data written to the child’s standard output is read by this
//      process from `pfd[1]`.
//    * Data written to the child’s standard error is read by this
//      process from `pfd[2]`.
//
//    Returns the process ID of the child or -1 on error.

pid_t subprocess(const char* file, char* const argv[], int pfd[3]) {
    // create pipes
    int inpfd[2] = {-1, -1}, outpfd[2] = {-1, -1}, errpfd[2] = {-1, -1};
    pid_t p = -1;
    if (pipe(inpfd) < 0
        || pipe(outpfd) < 0
        || pipe(errpfd) < 0) {
        goto error;
    }

    // create child
    p = fork();
    if (p == 0) {
        dup2(inpfd[0], STDIN_FILENO);
        close(inpfd[0]);
        close(inpfd[1]);

        dup2(outpfd[1], STDOUT_FILENO);
        close(outpfd[0]);
        close(outpfd[1]);

        dup2(errpfd[1], STDERR_FILENO);
        close(errpfd[0]);
        close(errpfd[1]);

        execvp(file, argv);
        _exit(1);
    } else if (p < 0) {
        goto error;
    }

    // clean up file descriptors
    close(inpfd[0]);
    pfd[0] = inpfd[1];
    close(outpfd[1]);
    pfd[1] = outpfd[0];
    close(errpfd[1]);
    pfd[2] = errpfd[0];

    // return pid
    return p;

  error:
    if (inpfd[0] >= 0) {
        close(inpfd[0]);
        close(inpfd[1]);
    }
    if (outpfd[0] >= 0) {
        close(outpfd[0]);
        close(outpfd[1]);
    }
    if (errpfd[0] >= 0) {
        close(errpfd[0]);
        close(errpfd[1]);
    }
    return -1;
}
