CS61 2020: Networking 5
============================

Today we will discuss synchronization problems and solutions in weensydb. 

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

- Check out `weensydb-02.cc`. Does it have data races? Can you think
  of a case that causes data races? Try it out and bring your case to
  the lecture.

- How to use the mutex locks we learnt last week to solve the data race?

WeensyDB variants
-----------------

1\. `weensydb-01` is the initial database. It can handle just one
client connection at a time.

2\. `weensydb-02` can support more than one client connection at a
time, using one thread per client connection. Unfortunately, it is not
well synchronized. The thread sanitizer will report these problems,
and multiple clients calling `./wdbclientloop` (for instance,
`./wdbclientloop set x 3` and `./wdbclientloop delete x`) can cause
the database to segmentation fault.

3\. `weensydb-03` is correctly synchronized. We add a global
`std::mutex hash_mutex`, and lock that mutex before accessing the
database. The code has no data races (no undefined behavior), which is
better! But it still has concurrency issues. If a user connects to the
database but does not complete a command, the thread will block in
`fread` *while holding the `hash_mutex`*. It can block forever! One
client can still exclude all other clients. For example:

```
$ telnet localhost 6169
set x 2
```

(with no value provided) will block `./wdbclient set y 2` forever.
This is called a **denial-of-service attack**, because the evil client
doesn’t crash the server or steal information, it just makes the
server unavailable to others. Server code executing on a client’s
behalf can obtain a mutex that locks out all other clients.

4\. `weensydb-04` is correctly synchronized, and it limits the scope
of denial-of-service attacks by implementing **fine-grained
synchronization**. Two threads accessing different hash buckets never
conflict! Therefore, it is possible to synchronize using `NBUCKETS`
mutexes, one per hash bucket, rather than using one “coarse-grained”
mutex for the whole hash table. This prevents the attack above and
increases concurrency, because now clients accessing different buckets
can proceed in parallel. Unfortunately, there is still a
denial-of-service attack *within* a bucket. A client stalled while
accessing bucket 1 will lock out all other clients accessing bucket 1.

5\. `weensydb-05` is correctly synchronized and has no
denial-of-service attacks. The attack is possible because WeensyDB
blocked (in `fread`) while holding a lock. It is generally a serious
mistake to block while holding a lock. This version, therefore, makes
sure to read a complete request *before* obtaining any lock. This
affects just the `set` operation.

WeensyDB
--------

The WeensyDB server is a [key-value store][] that maps string keys to string
values. To use WeensyDB, you connect to its port (6169 by default) and send
commands. The commands are modeled after the [memcached protocol][]; memcached
is probably the best-known modern-day key-value database.

## Set

The `set` command sets a key to a value. It takes a key, which is a
space-delimited string, and a number of bytes. Following a line break, the
server reads `<nbytes>` of binary data as the value.

    set <key> <nbytes>\r\n
    ...<nbytes> of binary data...\r\n

For example, to set key `x` to value `Hello`:

    set x 5
    Hello

The server’s response is the single word `STORED` followed by some debugging
information.

## Get

The `get` command returns the value of a given key.

    get <key>\r\n

If the key is present, the server responds with the value, followed by the
line `END\r\n`:

    VALUE <key> <nbytes> <debuginfo>\r\n
    ...<nbytes> of binary data...\r\n
    END\r\n

For example, to return the value `Hello`:

    VALUE x 5 0x7f8c89d00000
    Hello
    END

If the key is absent, the server responds `END\r\n`.

## Delete

The `delete` command removes a key. It takes a key argument.

    delete <key>\r\n

If the key is present, the server removes it and responds with the line
`DELETED <debuginfo>\r\n`. If the key is absent, the server responds with
`NOT_FOUND\r\n`.

## Other commands

Other requests are ignored; the server simply responds `ERROR\r\n`.

## Programs

Use the `./weensydb-*` programs to run a WeensyDB server. By default the
server listens on port 6169; you can change this with the `-p PORTNUMBER`
argument. If you try to run more than one WeensyDB on the same port, you’ll
see an error like this:

    bind: Address already in use
    Assertion failed: (fd >= 0), function main, file weensydb-01.c, line 112.

Use the `./wdbclient` program to send requests to WeensyDB based on command
line arguments. For instance, this:

    ./wdbclient set x 1 set y 2 get y get x delete y get y

might result in this output:

    STORED 0x7f8c89d00000
    STORED 0x7f8c89c026d0
    VALUE y 1 0x7f8c89c026d0
    2
    END
    VALUE x 1 0x7f8c89d00000
    1
    END
    DELETED 0x7f8c89c026d0
    END

Or use `telnet` to connect directly to the WeensyDB port!

[key-value store]: https://en.wikipedia.org/wiki/Key-value_database

[memcached protocol]: https://github.com/memcached/memcached/blob/master/doc/protocol.txt
