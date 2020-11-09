#include "io61.hh"
#include <sys/types.h>
#include <sys/stat.h>
#include <climits>
#include <cerrno>

#define BUFSIZE 16384

// io61.c
//    YOUR CODE HERE!


// io61_file
//    Data structure for io61 file wrappers. Add your own stuff.

struct io61_file {
    int fd;
    unsigned char buf[BUFSIZE];
    off_t tag;
    off_t end_tag;
    off_t pos_tag;
    off_t seek_idx;
    int mode;
};


// io61_fdopen(fd, mode)
//    Return a new io61_file for file descriptor `fd`. `mode` is
//    either O_RDONLY for a read-only file or O_WRONLY for a
//    write-only file. You need not support read/write files.

io61_file* io61_fdopen(int fd, int mode) {
    assert(fd >= 0);
    io61_file* f = new io61_file;
    f->fd = fd;
    f->tag = 0;
    f->end_tag = 0;
    f->pos_tag = 0;
    f->seek_idx = 0;
    f->mode = mode;
    return f;
}


// io61_close(f)
//    Close the io61_file `f` and release all its resources.

int io61_close(io61_file* f) {
    io61_flush(f);
    int r = close(f->fd);
    delete f;
    return r;
}


// io61_readc(f)
//    Read a single (unsigned) character from `f` and return it. Returns EOF
//    (which is -1) on error or end-of-file.

int io61_readc(io61_file* f) {
    if (f->mode == O_WRONLY) {
        return -1;
    }

    if (f->pos_tag + 1 <= f->end_tag) {
        // Within cache
        f->pos_tag += 1;
        return *(f->buf + f->pos_tag - f->tag - 1);
    } else {
        // Read and refill cache
        f->tag = f->pos_tag = f->end_tag;
        ssize_t total_read = read(f->fd, f->buf, BUFSIZE);
        if (total_read == 0) {
            return EOF;
        }
        f->end_tag += total_read;
        f->pos_tag += 1;
        unsigned char c = f->buf[f->seek_idx];
        f->seek_idx = 0;
        return c;
    }
}


// io61_read(f, buf, sz)
//    Read up to `sz` characters from `f` into `buf`. Returns the number of
//    characters read on success; normally this is `sz`. Returns a short
//    count, which might be zero, if the file ended before `sz` characters
//    could be read. Returns -1 if an error occurred before any characters
//    were read.

ssize_t io61_read(io61_file* f, char* buf, size_t sz) {
    if (f->mode == O_WRONLY) {
        return -1;
    }

    ssize_t sz_read = 0;
    
    // Check invariants
    assert(f->tag <= f->pos_tag && f->pos_tag <= f->end_tag);
    assert(f->end_tag - f->pos_tag <= BUFSIZE);

    if (sz <= BUFSIZE && (ssize_t) (f->pos_tag + sz) <= f->end_tag) {
        // Wholly within cache
        memcpy(buf, f->buf + f->pos_tag - f->tag, sz);
        f->pos_tag += sz;
        sz_read = sz;
    } else if ((ssize_t) sz <= BUFSIZE - f->seek_idx) {
        ssize_t sz_to_copy = sz;
        if (f->end_tag > f->pos_tag) {
            // Dump rest of cache
            sz_read = f->end_tag - f->pos_tag;
            memcpy(buf, f->buf + f->pos_tag - f->tag, sz_read);
            sz_to_copy -= sz_read;
        }
        // Cache empty/full; refill
        f->tag = f->pos_tag = f->end_tag;
        ssize_t total_read = read(f->fd, f->buf, BUFSIZE);
        if (total_read < 0) {
            return -1;
        }
        f->end_tag += total_read;
        sz_to_copy = total_read >= sz_to_copy ? sz_to_copy : total_read;
        memcpy(buf + sz_read, f->buf + f->seek_idx, sz_to_copy);
        sz_read += sz_to_copy;
        f->pos_tag += sz_to_copy;
        f->seek_idx = 0;
    } else {
        // Too large for cache
        if (f->end_tag > f->pos_tag) {
            // Dump rest of cache
            sz_read = f->end_tag - f->pos_tag;
            memcpy(buf, f->buf + f->pos_tag - f->tag, sz_read);
        }
        // Read the remaining directly
        ssize_t r = read(f->fd, buf + sz_read, sz - sz_read);
        if (r < 0) {
            return sz_read == 0 ? -1 : sz_read;
        }
        sz_read += r;
        f->tag = f->pos_tag = f->end_tag = f->end_tag + r + f->seek_idx;
        f->seek_idx = 0;
    }

    return sz_read;
}


// io61_writec(f)
//    Write a single character `ch` to `f`. Returns 0 on success or
//    -1 on error.

int io61_writec(io61_file* f, int ch) {
    if (f->mode == O_RDONLY) {
        return -1;
    }

    const ssize_t filled_sz = f->pos_tag - f->tag;

    if (filled_sz + 1 <= BUFSIZE) {
        f->buf[filled_sz] = ch;
    } else {
        if (io61_flush(f) < 0) {
            return -1;
        }
        f->buf[0] = ch;
    }

    f->pos_tag += 1;
    f->end_tag += 1;

    return 0;
}


// io61_write(f, buf, sz)
//    Write `sz` characters from `buf` to `f`. Returns the number of
//    characters written on success; normally this is `sz`. Returns -1 if
//    an error occurred before any characters were written.

ssize_t io61_write(io61_file* f, const char* buf, size_t sz) {
    if (f->mode == O_RDONLY) {
        return -1;
    }

    ssize_t sz_wrtn = sz;

    // Check invariants
    assert(f->tag <= f->pos_tag && f->pos_tag <= f->end_tag);
    assert(f->end_tag - f->pos_tag <= BUFSIZE);
    assert(f->pos_tag == f->end_tag);

    const ssize_t filled_sz = f->pos_tag - f->tag;
    const ssize_t empty_sz = BUFSIZE - filled_sz;

    if (sz <= BUFSIZE && (ssize_t) sz <= empty_sz) {
        // Wholly within cache
        memcpy(f->buf + filled_sz, buf, sz);
        f->pos_tag += sz;
        f->end_tag += sz;
    } else if (sz <= BUFSIZE) {
        // Fill up rest of cache, flush, and refill
        memcpy(f->buf + filled_sz, buf, empty_sz);
        f->pos_tag += empty_sz;
        f->end_tag += empty_sz;
        if (io61_flush(f) < 0) {
            return -1;
        };
        memcpy(f->buf, buf + empty_sz, sz - empty_sz);
        f->pos_tag += sz - empty_sz;
        f->end_tag += sz - empty_sz;
    } else {
        // Too large for cache
        if (io61_flush(f) < 0) {
            return -1;
        };
        sz_wrtn = write(f->fd, buf, sz);
        if (sz_wrtn < 0) {
            return -1;
        }
        f->tag = f->pos_tag = f->end_tag = f->end_tag + sz_wrtn;
    }

    return sz_wrtn;
}


// io61_flush(f)
//    Forces a write of all buffered data written to `f`.
//    If `f` was opened read-only, io61_flush(f) may either drop all
//    data buffered for reading, or do nothing.

int io61_flush(io61_file* f) {
    if (f->mode == O_RDONLY) {
        return 0;
    }

    // Check invariants
    assert(f->tag <= f->pos_tag && f->pos_tag <= f->end_tag);
    assert(f->end_tag - f->pos_tag <= BUFSIZE);
    assert(f->pos_tag == f->end_tag);

    if (f->pos_tag - f->tag) {
        ssize_t sz = write(f->fd, f->buf, f->pos_tag - f->tag);
        if (sz < 0) {
            return -1;
        }
        assert(sz == f->pos_tag - f->tag);
        f->tag += sz;
        return sz;
    }
    return 0;
}


// io61_seek(f, pos)
//    Change the file pointer for file `f` to `pos` bytes into the file.
//    Returns 0 on success and -1 on failure.

int io61_seek(io61_file* f, off_t pos) {
    if (f->mode == O_RDONLY) {
        if (pos >= f->tag && pos < f->end_tag) {
            f->pos_tag = pos;
            return 0;
        } else {
            off_t aligned = pos - pos % BUFSIZE;
            if (lseek(f->fd, aligned, SEEK_SET) != aligned) {
                return -1;
            }
            f->tag = f->pos_tag = f->end_tag = aligned;
            f->seek_idx = pos - aligned;
        }
    } else {
        io61_flush(f);
        if (lseek(f->fd, pos, SEEK_SET) != pos) {
            return -1;
        }
        f->tag = f->pos_tag = f->end_tag = pos;
    }
    return 0;
}


// You shouldn't need to change these functions.

// io61_open_check(filename, mode)
//    Open the file corresponding to `filename` and return its io61_file.
//    If `!filename`, returns either the standard input or the
//    standard output, depending on `mode`. Exits with an error message if
//    `filename != nullptr` and the named file cannot be opened.

io61_file* io61_open_check(const char* filename, int mode) {
    int fd;
    if (filename) {
        fd = open(filename, mode, 0666);
    } else if ((mode & O_ACCMODE) == O_RDONLY) {
        fd = STDIN_FILENO;
    } else {
        fd = STDOUT_FILENO;
    }
    if (fd < 0) {
        fprintf(stderr, "%s: %s\n", filename, strerror(errno));
        exit(1);
    }
    return io61_fdopen(fd, mode & O_ACCMODE);
}


// io61_filesize(f)
//    Return the size of `f` in bytes. Returns -1 if `f` does not have a
//    well-defined size (for instance, if it is a pipe).

off_t io61_filesize(io61_file* f) {
    struct stat s;
    int r = fstat(f->fd, &s);
    if (r >= 0 && S_ISREG(s.st_mode)) {
        return s.st_size;
    } else {
        return -1;
    }
}
