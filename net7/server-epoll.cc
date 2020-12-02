#include "helpers.hh"
#include <sys/epoll.h>

#define MAX_EVENTS 5
#define MAXFDS 16 * 1024

int main(int argc, char** argv) {
    int port = 6169;
    if (argc >= 2) {
        port = strtol(argv[1], nullptr, 0);
        assert(port > 0 && port <= 65535);
    }

    // Prepare listening socket
    int fd = open_listen_socket(port);
    fcntl(fd, F_SETFL, O_NONBLOCK);
    assert(fd >= 0);
    fprintf(stderr, "Listening on port %d...\n", port);

    int epoll_fd = epoll_create1(0);
    if (epoll_fd < 0) {
        perror("epoll");
        exit(1);
    }

    struct epoll_event event;
    event.events = EPOLLIN;
    event.data.fd = fd;
    if(epoll_ctl(epoll_fd, EPOLL_CTL_ADD, fd, &event)) {
        perror("epoll_ctl");
        close(epoll_fd);
        exit(1);
    }

    struct epoll_event* events = (epoll_event *)calloc(MAXFDS, sizeof(struct epoll_event));
  
    char buffer[BUFSIZ];
    int new_sd, rc;
    
    while (true) {
        int event_count = epoll_wait(epoll_fd, events, MAX_EVENTS, -1);

        for (int i=0; i < event_count; ++i) {
            if (events[i].data.fd == fd) { 
                new_sd = 0;
                while (new_sd != -1) {
                    new_sd = accept(fd, NULL, NULL);
                    if (new_sd < 0) {
                        if (errno != EWOULDBLOCK && errno != EAGAIN) perror("accept");
                        break;
                    }
                    if (new_sd >= MAXFDS)
                        break;
                    fcntl(new_sd, F_SETFL, O_NONBLOCK);
                    struct epoll_event e;
                    e.data.fd = new_sd;
                    e.events |= EPOLLIN;
                    if (epoll_ctl(epoll_fd, EPOLL_CTL_ADD, new_sd, &e) < 0) {
                        perror("epoll_ctl");
                        break;
                    }
                    fprintf(stderr, "Server: Accept a new connection %d\n", new_sd);
                }
            } else {
                do {
                    memset(buffer, 0, sizeof(buffer));
                    rc = recv(events[i].data.fd, buffer, sizeof(buffer), 0);
                    if (rc <= 0) {
                        if (errno != EWOULDBLOCK) {
                            perror("recv");
                            close(events[i].data.fd);
                            break;
                        }
                    } else {
                        fprintf(stderr, "Server: Receives message from %d of %d size: %s", i, rc, buffer);
                        }
                } while (rc > 0);
            }
        }        
    }
    
    close(epoll_fd);
}
