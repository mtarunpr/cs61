#include "sh61.hh"
#include <cstring>
#include <cerrno>
#include <vector>
#include <sys/stat.h>
#include <sys/wait.h>

static volatile sig_atomic_t recd_signal;

// struct command
//    Data structure describing a command. Add your own stuff.

struct command {
    std::vector<std::string> args;   // vector of arguments
    pid_t pid;      // process ID running this command, -1 if none
    command* next;  // next command in linked list
    int link;       // control operator terminating this command
    int readfd;     // read-end fd if read end of pipe, -1 otherwise

    std::string in_filename;    // stdin file name, if any
    std::string out_filename;   // stdout file name, if any
    std::string err_filename;   // stderr file name, if any

    command();
    ~command();

    pid_t make_child(pid_t pgid);
};


// command::command()
//    This constructor function initializes a `command` structure. You may
//    add stuff to it as you grow the command structure.

command::command() {
    this->pid = -1;
    this->next = nullptr;
    this->link = TYPE_SEQUENCE;
    this->readfd = -1;
}


// command::~command()
//    This destructor function is called to delete a command.

command::~command() {
    if (this->next) {
        delete this->next;
    }
}


// signal_handler(signal)
//    Handles SIGINT signals for the shell.

void signal_handler(int signal) {
    (void) signal;
    recd_signal = 1;
}

// COMMAND EXECUTION

// command::make_child(pgid)
//    Create a single child process running the command in `this`.
//    Sets `this->pid` to the pid of the child process and returns `this->pid`.
//
//    PART 1: Fork a child process and run the command using `execvp`.
//       This will require creating an array of `char*` arguments using
//       `this->args[N].c_str()`.
//    PART 5: Set up a pipeline if appropriate. This may require creating a
//       new pipe (`pipe` system call), and/or replacing the child process's
//       standard input/output with parts of the pipe (`dup2` and `close`).
//       Draw pictures!
//    PART 7: Handle redirections.
//    PART 8: The child process should be in the process group `pgid`, or
//       its own process group (if `pgid == 0`). To avoid race conditions,
//       this will require TWO calls to `setpgid`.

pid_t command::make_child(pid_t pgid) {
    assert(this->args.size() > 0);

    // Set up argument vector
    const char* argv[args.size() + 1];
    for (size_t i = 0; i < args.size(); ++i) {
        argv[i] = this->args[i].c_str();
    }
    argv[args.size()] = nullptr;

    // Set up pipeline if necessary
    int pfd[2];
    if (this->link == TYPE_PIPE && pipe(pfd) == -1) {
        fprintf(stderr, "%s\n", strerror(errno));
        return -1;
    }

    pid_t child_pid = fork();
    if (child_pid == -1) {
        fprintf(stderr, "%s\n", strerror(errno));
        return -1;
    } else if (child_pid == 0) {
        // Child process
        // Set process group ID
        setpgid(0, pgid);

        // Set up stdin redirection if necessary
        if (!this->in_filename.empty()) {
            int fd = open(this->in_filename.c_str(), O_RDONLY);
            if (fd == -1) {
                perror(this->in_filename.c_str());
                _exit(EXIT_FAILURE);
            }
            dup2(fd, STDIN_FILENO);
            close(fd);
        } else if (this->readfd != -1) {
                // Pipe dance (reader)
                dup2(this->readfd, STDIN_FILENO);
                close(this->readfd);
        }

        // Set up stdout redirection if necessary
        if (!this->out_filename.empty()) {
            int fd = open(this->out_filename.c_str(), O_WRONLY | O_CREAT | O_TRUNC, 0666);
            if (fd == -1) {
                perror(this->out_filename.c_str());
                _exit(EXIT_FAILURE);
            }
            dup2(fd, STDOUT_FILENO);
            close(fd);
        } else if (this->link == TYPE_PIPE) {
                // Pipe dance (writer)
                close(pfd[0]);
                dup2(pfd[1], STDOUT_FILENO);
                close(pfd[1]);
        }

        // Set up stderr redirection if necessary
        if (!this->err_filename.empty()) {
            int fd = open(this->err_filename.c_str(), O_WRONLY | O_CREAT | O_TRUNC, 0666);
            if (fd == -1) {
                perror(this->err_filename.c_str());
                _exit(EXIT_FAILURE);
            }
            dup2(fd, STDERR_FILENO);
            close(fd);
        }

        // Execute process
        if (execvp(argv[0], (char**) argv) == -1) {
            _exit(EXIT_FAILURE);
        }
    } else {
        // Parent process
        this->pid = child_pid;

        // Set process group ID for child to avoid race condition
        setpgid(child_pid, pgid);

        // Pipe dance (parent of writer)
        if (this->link == TYPE_PIPE) {
            close(pfd[1]);
            this->next->readfd = pfd[0];
        }

        // Pipe dance (parent of reader)
        if (this->readfd != -1) {
            close(this->readfd);
        }
    }

    return child_pid;
}


// run_pipeline(command *c)
//    Run the pipeline of commands starting with `c`, all with
//    the same process group ID; returns this pgid.

pid_t run_pipeline(command *c) {
    pid_t pgid = c->make_child(0);
    for (; c->next; c = c->next) {
        if (c->link != TYPE_PIPE) {
            break;
        }
        c->next->make_child(pgid);
    }
    return pgid;
}


// get_cond_type(c)
//    Returns conditional operator following the pipeline
//    `c` is in, or -1 if none.

int get_cond_type(command* c) {
    if (c->link == TYPE_PIPE) {
        return get_cond_type(c->next);
    } else if (c->link == TYPE_AND || c->link == TYPE_OR) {
        return c->link;
    } else {
        return -1;
    }
}


// run_conditional(c, bg)
//    Run the conditional chain of pipelines starting with `c`
//    in the background (if `bg` is true) or foreground (otherwise).

void run_conditional(command *c, bool bg) {
    pid_t pid = -1;
    if (bg) {
        // Create new shell for background process
        pid = fork();
        if (pid == -1) {
            fprintf(stderr, "%s\n", strerror(errno));
            return;
        } else if (pid == 0) {
            // Ignore SIGINT in the child shell
            set_signal_handler(SIGINT, SIG_IGN);
        }
    }

    if (!bg || pid == 0) {
        while (true) {
            // Run pipeline
            pid_t pgid = run_pipeline(c);
            // Seek to end of pipeline 
            while (c->link == TYPE_PIPE) {
                c = c->next;
            }

            // Wait for last command in pipeline to terminate
            // and claim foreground if necessary (for interruptions)
            !bg && claim_foreground(pgid);
            int wstatus;
            pid_t exited_pid = waitpid(c->pid, &wstatus, 0);
            assert(c->pid == exited_pid);
            !bg && claim_foreground(0);

            // Handle conditionals by skipping each command whose
            // exit status is irrelevant to the conditional
            if (WIFEXITED(wstatus)) {
                // Process exited (either success or failure)
                while ((WEXITSTATUS(wstatus) == 0 && get_cond_type(c) == TYPE_OR)
                       || (WEXITSTATUS(wstatus) != 0 && get_cond_type(c) == TYPE_AND)) {
                    do {
                        c = c->next;
                    } while (c->link == TYPE_PIPE);
                }
            } else if (WIFSIGNALED(wstatus) && WTERMSIG(wstatus) == SIGINT) {
                // Process was terminated by SIGINT (always failure)
                while (get_cond_type(c) == TYPE_AND) {
                    do {
                        c = c->next;
                    } while (c->link == TYPE_PIPE);
                }
                printf("\n");
            }

            // If next is within this conditional, run it in same shell
            if (c->link != TYPE_BACKGROUND && c->link != TYPE_SEQUENCE) {
                c = c->next;
            } else {
                break;
            }
        }
        
        if (pid == 0) {
            // If this is a child shell, terminate
            _exit(EXIT_SUCCESS);
        }
    }
}


// run(c)
//    Run the command *list* starting at `c`. Initially this just calls
//    `make_child` and `waitpid`; you’ll extend it to handle command lists,
//    conditionals, and pipelines.
//
//    PART 1: Start the single command `c` with `c->make_child(0)`,
//        and wait for it to finish using `waitpid`.
//    The remaining parts may require that you change `struct command`
//    (e.g., to track whether a command is in the background)
//    and write code in `run` (or in helper functions).
//    PART 2: Treat background commands differently.
//    PART 3: Introduce a loop to run all commands in the list.
//    PART 4: Change the loop to handle conditionals.
//    PART 5: Change the loop to handle pipelines. Start all processes in
//       the pipeline in parallel. The status of a pipeline is the status of
//       its LAST command.
//    PART 8: - Choose a process group for each pipeline and pass it to
//         `make_child`.
//       - Call `claim_foreground(pgid)` before waiting for the pipeline.
//       - Call `claim_foreground(0)` once the pipeline is complete.

void run(command* c) {
    command* front = c;
    // Seek to end of conditional
    while (c->link != TYPE_SEQUENCE && c->link != TYPE_BACKGROUND) {
        c = c->next;
    }
    run_conditional(front, c->link == TYPE_BACKGROUND);
    if (c->next) {
        run(c->next);
    }
}


// parse_line(s)
//    Parse the command list in `s` and return it. Returns `nullptr` if
//    `s` is empty (only spaces). You’ll extend it to handle more token
//    types.

command* parse_line(const char* s) {
    shell_parser parser(s);

    // Build the command
    command* front = nullptr;
    command* c = nullptr;
    for (shell_token_iterator it = parser.begin(); it != parser.end(); ++it) {
        // Create command in linked list
        if (!front) {
            front = new command;
            c = front;
        } else {
            c->next = new command;
            c = c->next;
        }

        while (it.type() == TYPE_NORMAL || it.type() == TYPE_REDIRECT_OP) {
            // Store arguments
            if (it.type() == TYPE_NORMAL) {
                c->args.push_back(it.str());
            }
            // Parse redirects
            if (it.type() == TYPE_REDIRECT_OP) {
                char redirect_type = it.str().at(0);
                ++it;
                assert(it.type() == TYPE_NORMAL);
                if (redirect_type == '<') {
                    c->in_filename = it.str();
                } else if (redirect_type == '>') {
                    c->out_filename = it.str();
                } else if (redirect_type == '2') {
                    c->err_filename = it.str();
                } else {
                    fprintf(stderr, "Unsupported redirect\n");
                    _exit(EXIT_FAILURE);
                }
            }
            
            ++it;
        }

        c->link = it.type();
    }
    return front;
}


int main(int argc, char* argv[]) {
    FILE* command_file = stdin;
    bool quiet = false;

    // Check for '-q' option: be quiet (print no prompts)
    if (argc > 1 && strcmp(argv[1], "-q") == 0) {
        quiet = true;
        --argc, ++argv;
    }

    // Check for filename option: read commands from file
    if (argc > 1) {
        command_file = fopen(argv[1], "rb");
        if (!command_file) {
            perror(argv[1]);
            exit(1);
        }
    }

    // - Put the shell into the foreground
    // - Ignore the SIGTTOU signal, which is sent when the shell is put back
    //   into the foreground
    claim_foreground(0);
    set_signal_handler(SIGTTOU, SIG_IGN);

    // Handle SIGINT by remprompting
    set_signal_handler(SIGINT, signal_handler);

    char buf[BUFSIZ];
    int bufpos = 0;
    bool needprompt = true;

    while (!feof(command_file)) {
        // Print the prompt at the beginning of the line
        if (needprompt && !quiet) {
            printf("sh61[%d]$ ", getpid());
            fflush(stdout);
            needprompt = false;
        }

        if (recd_signal) {
            recd_signal = 0;
            needprompt = true;
            printf("\n");
            continue;
        }

        // Read a string, checking for error or EOF
        if (fgets(&buf[bufpos], BUFSIZ - bufpos, command_file) == nullptr) {
            if (ferror(command_file) && errno == EINTR) {
                // ignore EINTR errors
                clearerr(command_file);
                buf[bufpos] = 0;
            } else {
                if (ferror(command_file)) {
                    perror("sh61");
                }
                break;
            }
        }

        // If a complete command line has been provided, run it
        bufpos = strlen(buf);
        if (bufpos == BUFSIZ - 1 || (bufpos > 0 && buf[bufpos - 1] == '\n')) {
            if (command* c = parse_line(buf)) {
                run(c);
                delete c;
            }
            bufpos = 0;
            needprompt = 1;
        }

        // Handle zombie processes and interrupt requests
        int wstatus;
        pid_t pid = -1;
        while (true) {
            pid = waitpid(-1, &wstatus, WNOHANG);
            if (pid == 0 || (pid == -1 && errno == ECHILD)) {
                break;
            } else if (pid == -1) {
                fprintf(stderr, "%s\n", strerror(errno));
                return -1;
            }
        }
    }

    return 0;
}
