#include "helpers.hh"

int main() {
    const char* args[] = {
        "./myecho", // argv[0] is the string used to execute the program
        "Hello, world",
        nullptr
    };
    fprintf(stderr, "About to exec myecho from pid %d\n", getpid());
    for (int i = 0; args[i]; ++i) {
        fprintf(stderr, "Arg %d @%p: \"%s\"\n", i, args[i], args[i]);
    }

    int r = execv("./myecho", (char**) args);

    fprintf(stderr, "Finished execing myecho from pid %d; status %d\n",
            getpid(), r);
}
