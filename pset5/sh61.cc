#include "sh61.hh"
#include <cstring>
#include <cerrno>
#include <vector>
#include <sys/stat.h>
#include <sys/wait.h>


// struct command
//    Data structure describing a command. Add your own stuff.

struct command {
    std::vector<std::string> args;   // vector of arguments
    pid_t pid;      // process ID running this command, -1 if none
    command* next;  // next command in linked list
    int link;       // control operator terminating this command
    int readfd;     // read-end fd if read end of pipe, -1 otherwise

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
    (void) pgid; // You won’t need `pgid` until part 8.

    // Set up argument vector
    const char* argv[args.size() + 1];
    for (size_t i = 0; i < args.size(); ++i) {
        argv[i] = this->args[i].c_str();
    }
    argv[args.size()] = nullptr;

    // Set up pipeline if necessary
    int pfd[2];
    if (this->link == TYPE_PIPE && pipe(pfd) == -1) {
        fprintf(stderr, "Pipe failed.");
        return -1;
    }

    pid_t child_pid = fork();
    if (child_pid == -1) {
        fprintf(stderr, "Unable to fork\n");
        return -1;
    } else if (child_pid == 0) {
        // Child process
        // Pipe dance (writer)
        if (this->link == TYPE_PIPE) {
            close(pfd[0]);
            dup2(pfd[1], 1);
            close(pfd[1]);
        }
        // Pipe dance (reader)
        if (this->readfd != -1) {
            dup2(this->readfd, 0);
            close(this->readfd);
        }
        // Execute process
        if (execvp(argv[0], (char**) argv) == -1) {
            _exit(EXIT_FAILURE);
        }
    } else {
        // Parent process
        this->pid = child_pid;
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

    return this->pid;
}


// run_pipeline(command *c)
//    Run the pipeline of commands starting with `c`

void run_pipeline(command *c) {
    c->make_child(0);
    if (c->link != TYPE_PIPE) {
        return;
    }
    if (c->next) {
        run_pipeline(c->next);
    }
}


// get_cond_type(c)
//    Returns conditional operator following the pipeline
//    `c` is in, or -1 if none

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
            fprintf(stderr, "Unable to fork\n");
            return;
        }
    }

    if (!bg || pid == 0) {
        while (true) {
            // Run pipeline
            run_pipeline(c);
            // Seek to end of pipeline 
            while (c->link == TYPE_PIPE) {
                c = c->next;
            }
            
            // Wait for last command in pipeline to terminate
            int wstatus;
            pid_t exited_pid = waitpid(c->pid, &wstatus, 0);
            assert(c->pid == exited_pid);

            // Handle conditionals
            if (WIFEXITED(wstatus)) {
                // Skip each command whose exit status is irrelevant to conditional
                while ((WEXITSTATUS(wstatus) == 0 && get_cond_type(c) == TYPE_OR)
                       || (WEXITSTATUS(wstatus) != 0 && get_cond_type(c) == TYPE_AND)) {
                    c = c->next;
                    while (c->link == TYPE_PIPE) {
                        c = c->next;
                    }
                }
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
    // Your code here!

    // Build the command
    // The handout code treats every token as a normal command word.
    // You'll add code to handle operators.
    command* front = nullptr;
    command* c = nullptr;
    for (shell_token_iterator it = parser.begin(); it != parser.end(); ++it) {
        if (!front) {
            front = new command;
            c = front;
        } else {
            c->next = new command;
            c = c->next;
        }

        while (it.type() == TYPE_NORMAL) {
            c->args.push_back(it.str());
            ++it;
            if (it == parser.end()) {
                c->link = TYPE_SEQUENCE;
                return front;
            }
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

        // Handle zombie processes and/or interrupt requests
        // Your code here!
    }

    return 0;
}
