CS61 2020: Process control 5
============================

Today’s meeting is about blocking and polling.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

Read the `waitpid` manual page, with special attention to the
`WNOHANG` flag and the `WIFEXITED` macro.

1\. Complete the following function, which should check whether a
child process with PID `p` has terminated. If the child has exited,
the function should store the exit status in `*status` and return
`true`; if the child terminated due to a signal, the function should
store -1 in `*status` and return `true`; if the child has not yet
terminated or there is an error, the function should return `false`.

```c++
bool poll_child(pid_t p, int* status) {
    ...
```

2\. Complete the following function, which should **wait** for a child
process with PID `p` to terminate. The return values for `block_child`
are the same as for `poll_child`, except that if `p` has not yet
terminated, `block_child` should wait for `p` to terminate rather than
returning `false`.

```c++
bool block_child(pid_t p, int* status) {
    ...
```

3\. `poll_child` waits for a child for at most 0 seconds, and
`block_child` waits for at most ∞ seconds. How would you implement a
function that waits for a child for, say, at most 3 seconds?
