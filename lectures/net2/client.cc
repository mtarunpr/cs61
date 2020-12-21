#include "helpers.hh"

int main(int argc, char **argv) {
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
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;    // use TCP
    hints.ai_flags = AI_NUMERICSERV;
    int r = getaddrinfo(host, port, &hints, &ai);
    if (r != 0) {
        perror("getaddrinfo");
        exit(1);
    }

    int fd = socket(ai->ai_family, ai->ai_socktype, 0);
    if (fd < 0) {
        perror("socket");
        exit(1);
    }

    r = connect(fd, ai->ai_addr, ai->ai_addrlen);
    fprintf(stderr, "./client: Connect to server\n");
    if (r < 0) {
        perror("connect");
        exit(1);
    }

    //send messages
    char outbuf[1024] = "", inbuf[1024] = "";
    strcpy(outbuf, "Hello from client");
    write(fd, outbuf, strlen(outbuf));
    fprintf(stderr, "./client: Sends message: %s\n", outbuf);
    read(fd, inbuf, sizeof(inbuf));
    fprintf(stderr, "./client: Receives message: %s\n", inbuf);

    close(fd);
    return 0;
}
