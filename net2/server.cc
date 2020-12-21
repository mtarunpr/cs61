#include "helpers.hh"
#include <netdb.h>

int main() {
    int port = 6169;

    // Create socket
    int fd = socket(AF_INET, SOCK_STREAM, 0);
    if (fd < 0) {
        perror("socket");
	exit(1);
    }

    int yes = 1;
    int r = setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(int));
    if (r < 0) {
        perror("setsockopt");
        close(fd);
	exit(1);
    }

    // Bind to port
    struct sockaddr_in address;
    memset(&address, 0, sizeof(address));
    address.sin_family = AF_INET;
    address.sin_port = htons(port);
    address.sin_addr.s_addr = INADDR_ANY;
    r = bind(fd, (struct sockaddr*) &address, sizeof(address));
    if (r < 0) {
        perror("bind");
        close(fd);
	exit(1);
    }

    // Actually start listening
    r = listen(fd, 100);
    fprintf(stderr, "./server: Start listening on port %d\n", port);
    if (r < 0) {
        perror("listen");
        close(fd);
	exit(1);
    }

    //accept a client
    struct sockaddr_in client_addr;
    socklen_t len = sizeof(client_addr);
    int cfd = accept(fd, (struct sockaddr*)&client_addr, &len);
    if (cfd < 0) {
        perror("accept");
        exit(1);
    }

    //convert
    char client_ipstr[1024];
    inet_ntop(AF_INET, &client_addr.sin_addr, client_ipstr, sizeof(client_ipstr));

    char inbuf[1024] = "", outbuf[1024] = "";
    read(cfd, inbuf, sizeof(inbuf));
    fprintf(stderr, "./server: Receives message from %s: %s\n", client_ipstr, inbuf);
    strcpy(outbuf, "hello from server");
    write(cfd, outbuf, strlen(outbuf));
    fprintf(stderr, "./server: Sends message to %s: %s\n", client_ipstr, outbuf);

    close(cfd);
    close(fd);

}
