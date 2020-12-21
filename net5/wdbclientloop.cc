#include "helpers.hh"
#include <netdb.h>

void usage(int exit_status) {
    fprintf(stderr, "Usage: wdbclientloop [get KEY | set KEY VALUE | delete KEY]...\n");
    exit(exit_status);
}


int main(int argc, char** argv) {
    const char* host = "localhost";
    const char* port = "6169";

    // parse arguments
    int opt;
    while ((opt = getopt(argc, argv, "h:p:")) >= 0) {
        if (opt == 'h') {
            host = optarg;
        } else if (opt == 'p') {
            port = optarg;
        }
    }

    // look up host and port
    struct addrinfo hints, *ai;
    memset(&hints, 0, sizeof(hints));
    hints.ai_family = AF_UNSPEC;        // use IPv4 or IPv6
    hints.ai_socktype = SOCK_STREAM;    // use TCP
    hints.ai_flags = AI_NUMERICSERV;
    int r = getaddrinfo(host, port, &hints, &ai);
    if (r != 0) {
        fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(r));
        exit(1);
    }

    // connect to server
    int fd = socket(ai->ai_family, ai->ai_socktype, 0);
    if (fd < 0) {
        perror("socket");
        exit(1);
    }

    r = connect(fd, ai->ai_addr, ai->ai_addrlen);
    if (r < 0) {
        perror("connect");
        exit(1);
    }

    if (optind == argc) {
        usage(0);
    }

    // write arguments
    FILE* f = fdopen(fd, "w");
    FILE* fin = fdopen(fd, "r");
    int first_arg = optind;
    size_t ncommands = 0;
    double start_time = tstamp();

    while (true) {
        for (int i = 0; i != 10000; ++i, ++ncommands) {
            if (optind == argc) {
                optind = first_arg;
            }
            if (strcmp(argv[optind], "get") == 0
                && optind + 1 < argc
                && is_valid_key(argv[optind + 1])) {
                fprintf(f, "get %s\r\n", argv[optind + 1]);
                optind += 2;

            } else if (strcmp(argv[optind], "set") == 0
                       && optind + 2 < argc
                       && is_valid_key(argv[optind + 1])) {
                size_t value_len = strlen(argv[optind + 2]);
                fprintf(f, "set %s %zu\r\n",
                        argv[optind + 1], value_len);
                fwrite(argv[optind + 2], 1, value_len, f);
                fprintf(f, "\r\n");
                optind += 3;

            } else if (strcmp(argv[optind], "delete") == 0
                       && optind + 1 < argc
                       && is_valid_key(argv[optind + 1])) {
                fprintf(f, "delete %s\r\n", argv[optind + 1]);
                optind += 2;

            } else if (strcmp(argv[optind], "exch") == 0
                       && optind + 2 < argc
                       && is_valid_key(argv[optind + 1])
                       && is_valid_key(argv[optind + 2])) {
                fprintf(f, "exch %s %s\r\n",
                        argv[optind + 1], argv[optind + 2]);
                optind += 3;

            } else if (strcmp(argv[optind], "cas") == 0
                       && optind + 3 < argc
                       && is_valid_key(argv[optind + 1])) {
                size_t old_len = strlen(argv[optind + 2]);
                size_t new_len = strlen(argv[optind + 3]);
                fprintf(f, "cas %s %zu %zu\r\n",
                        argv[optind + 1], old_len, new_len);
                fwrite(argv[optind + 2], 1, old_len, f);
                fwrite(argv[optind + 3], 1, new_len, f);
                fprintf(f, "\r\n");
                optind += 4;

            } else {
                usage(1);
            }
        }

        // send data to client
        fprintf(f, "error\r\n");
        fflush(f);

        // read results
        char buf[BUFSIZ];
        while (true) {
            if (!fgets(buf, BUFSIZ, fin)) {
                exit(1);
            } else if (strcmp(buf, "ERROR\r\n") == 0) {
                break;
            }
        }

        fprintf(stderr, "%zu commands in %.06f sec...\n",
                ncommands, tstamp() - start_time);
    }

    // done
    fclose(f); // This also closes `fd`.
    (void) fclose(fin);
}
