#include "sh61.hh"
#include <cstring>
#include <cerrno>
#include <vector>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unordered_map>

static volatile sig_atomic_t recd_signal;

// struct command
//    Data structure describing a command. Add your own stuff.

struct command {
    std::vector<std::string> args;   // vector of arguments
    pid_t pid;      // process ID running this command, -1 if none
    command* next;  // next command in linked list
    int link;       // control operator terminating this command
    int readfd;     // read-end fd if read end of pipe, -1 otherwise

    // Redirections
    // input files: key - fd, value - filename
    std::unordered_map<int, std::string> in_files;
    // output files: key - fd, value - pair of filename and mode (O_TRUNC or O_APPEND)
    std::unordered_map<int, std::pair<std::string, int>> out_files;

    // Subshells
    command* sub_front;  // pointer to first command of subshell, nullptr if none
    bool sub_bg;         // true iff this is being run inside a background subshell

    command();
    ~command();

    pid_t make_child(pid_t pgid);
};


// run(c)
//    Runs the given command and returns exit status.
//    See definition below for more.

int run(command*);


// command::command()
//    This constructor function initializes a `command` structure. You may
//    add stuff to it as you grow the command structure.

command::command() {
    this->pid = -1;
    this->next = nullptr;
    this->link = TYPE_SEQUENCE;
    this->readfd = -1;
    this->sub_front = nullptr;
    this->sub_bg = false;
}


// command::~command()
//    This destructor function is called to delete a command.

command::~command() {
    if (this->sub_front) {
        delete this->sub_front;
    }
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
    // Set up argument vector
    const char* argv[args.size() + 1];
    for (size_t i = 0; i < args.size(); ++i) {
        argv[i] = this->args[i].c_str();
    }
    argv[args.size()] = nullptr;

    // Check if command is `cd` for later
    bool is_cd = !this->sub_front && strcmp(argv[0], "cd") == 0;
    if (is_cd) {
        // If no argument to `cd`, remain in the same directory
        if (!argv[1]) {
            argv[1] = ".";
        }
    }
    
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

        // Set up input redirection
        for (auto file : this->in_files) {
            int fd = open(file.second.c_str(), O_RDONLY);
            if (fd == -1) {
                perror(file.second.c_str());
                _exit(EXIT_FAILURE);
            }
            dup2(fd, file.first);
            close(fd);
        }
        // Set up output redirection
        for (auto file : this->out_files) {
            int fd = open(file.second.first.c_str(),
                O_WRONLY | O_CREAT | file.second.second, 0666);
            if (fd == -1) {
                perror(file.second.first.c_str());
                _exit(EXIT_FAILURE);
            }
            dup2(fd, file.first);
            close(fd);
        }
        
        // Pipe dance (only pipe if input/output is not being redirected)
        if (this->readfd != -1 && this->in_files.find(STDIN_FILENO) == this->in_files.end()) {
            // Reader
            dup2(this->readfd, STDIN_FILENO);
            close(this->readfd);
        }
        if (this->link == TYPE_PIPE && this->out_files.find(STDOUT_FILENO) == this->out_files.end()) {
            // Writer
            close(pfd[0]);
            dup2(pfd[1], STDOUT_FILENO);
            close(pfd[1]);
        }

        // Execute process
        if (this->sub_front) {
            // Run subshell
            if(run(this->sub_front) == 0) {
                _exit(EXIT_SUCCESS);
            } else {
                _exit(EXIT_FAILURE);
            }
        } else if (is_cd) {
            // If `cd`, repeat in child to report success/failure
            if (args.size() > 2) {
                fprintf(stderr, "cd: too many arguments\n");
                _exit(EXIT_FAILURE);
            }
            if (chdir(argv[1]) == -1) {
                perror(argv[1]);
                _exit(EXIT_FAILURE);
            }
            _exit(EXIT_SUCCESS);
        } else if (execvp(argv[0], (char**) argv) == -1) {
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

        // Handle `cd` as a special case
        if (is_cd) {
            int r = chdir(argv[1]);
            // No need to check return value as this is done in the child
            (void) r;
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
//    Returns the exit status.

int run_conditional(command *c, bool bg) {
    // Mark all subshell commands to avoid claiming foreground
    if (bg || c->sub_bg) {
        for (command* it = c->sub_front; it; it = it->next) {
            it->sub_bg = true;
        }
    }
    int exit_status = -1;
    pid_t pid = -1;
    if (bg) {
        // Create new shell for background process
        pid = fork();
        if (pid == -1) {
            fprintf(stderr, "%s\n", strerror(errno));
            return exit_status;
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
            !bg && !c->sub_bg && claim_foreground(pgid);
            int wstatus;
            pid_t exited_pid = waitpid(c->pid, &wstatus, 0);
            assert(c->pid == exited_pid);
            !bg && !c->sub_bg && claim_foreground(0);

            // Handle conditionals by skipping each command whose
            // exit status is irrelevant to the conditional
            if (WIFEXITED(wstatus)) {
                // Process exited (either success or failure)
                exit_status = WEXITSTATUS(wstatus);
                while ((exit_status == 0 && get_cond_type(c) == TYPE_OR)
                       || (exit_status != 0 && get_cond_type(c) == TYPE_AND)) {
                    do {
                        c = c->next;
                    } while (c->link == TYPE_PIPE);
                }
            } else if (WIFSIGNALED(wstatus) && WTERMSIG(wstatus) == SIGINT) {
                // Process was terminated by SIGINT (always failure)
                exit_status = 1;
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
    return exit_status;
}


// run(c)
//    Run the command *list* starting at `c`.
//    Returns the exit status.
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

int run(command* c) {
    command* front = c;
    // Seek to end of conditional
    while (c->link != TYPE_SEQUENCE && c->link != TYPE_BACKGROUND) {
        c = c->next;
    }
    int exit_status = run_conditional(front, c->link == TYPE_BACKGROUND);
    if (c->next) {
        exit_status = run(c->next);
    }
    return exit_status;
}


// parse_list(it, end)
//    Parse the command list starting at `it` and ending with
//    a right parenthesis or until `end` is encountered.

command* parse_list(shell_token_iterator& it, shell_token_iterator end) {
    // Build the command
    command* front = nullptr;
    command* c = nullptr;
    for (; it != end; ++it) {
        // Create command in linked list
        if (!front) {
            front = new command;
            c = front;
        } else {
            c->next = new command;
            c = c->next;
        }

        // Parse subshell list
        if (it.type() == TYPE_LPAREN) {
            ++it;
            c->sub_front = parse_list(it, end);
            ++it;
        }
        
        while (it.type() == TYPE_NORMAL || it.type() == TYPE_REDIRECT_OP) {
            // Store arguments
            if (it.type() == TYPE_NORMAL) {
                c->args.push_back(it.str());
            }
            // Parse redirects
            if (it.type() == TYPE_REDIRECT_OP) {
                std::string op = it.str();
                ++it;
                assert(it.type() == TYPE_NORMAL);

                // Get fd (if present) and raw operator (without fd)
                int fd = -1;
                std::string op_raw;
                if (isdigit(op.at(0))) {
                    fd = std::stoi(op);
                    for (unsigned i = 0; i < op.length(); ++i) {
                        if (!isdigit(op.at(i))) {
                            op_raw += op.at(i);
                        }
                    }
                } else {
                    op_raw = op;
                }

                if (op_raw == "<") {
                    fd = fd == -1 ? STDIN_FILENO : fd;
                    c->in_files[fd] = it.str();
                } else if (op_raw == ">" || op_raw == ">>") {
                    fd = fd == -1 ? STDOUT_FILENO : fd;
                    int mode = O_TRUNC;
                    if (op_raw == ">>") {
                        mode = O_APPEND;
                    }
                    c->out_files[fd] = std::make_pair(it.str(), mode);
                }
            }
            ++it;
        }

        c->link = it.type();
        if (c->link == TYPE_RPAREN) {
            c->link = TYPE_SEQUENCE;
            return front;
        }
    }
    return front;
}


// parse_line(s)
//    Parse the command list in `s` and return it. Returns `nullptr` if
//    `s` is empty (only spaces).

command* parse_line(const char* s) {
    shell_parser parser(s);
    shell_token_iterator it = parser.begin();
    return parse_list(it, parser.end());
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
            // Add some color
            printf("\033[1;32msh61");
            printf("\033[1;34m[%d]", getpid());
            printf("\033[0m$ ");
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
        pid_t pid = -1;
        while (true) {
            pid = waitpid(-1, NULL, WNOHANG);
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
