CS61 2020: Networking 6
============================

Today we will discuss more improvements on weensydb on condition variables and deadlocks.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

- Modify WeensyDB to add a bound on #threads: It should create at most 100 threads and thus support at most 100 clients. But when a client closes, we should be able to accept new clients. [Tip: we will need to use condition variables we learnt in the previous lecture]

More WeensyDB variants
-----------------

1\. `weensydb-05` is correctly synchronized and has no
denial-of-service attacks. The attack is possible because WeensyDB
blocked (in `fread`) while holding a lock. It is generally a serious
mistake to block while holding a lock. This version, therefore, makes
sure to read a complete request *before* obtaining any lock. This
affects just the `set` operation.

More to add after the lecture. 

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
