Assembly solution
=================
(a) The functions compute Fibonacci numbers! In other words, the functions compute the `n`th term of the sequence `0, 1, 1, 2, 3, 5, 8, 13, ...`, where each term in the sequence is the sum of the previous two. Here, `n` is the first argument passed to the function.

(b) `func_eddie` takes 1 argument, and `func_minlan` takes 3 arguments.

(c) Here is the original source code for the two functions:
```c++
int func_eddie(int n) {
    if (n == 0) {
        return 0;
    }
    if (n == 1) {
        return 1;
    }
    return func_eddie(n - 1) + func_eddie(n - 2);
}
```

```c++
int func_minlan(int n, int first=0, int second=1) {
    if (n == 0) {
        return first;
    }
    if (n == 1) {
        return second;
    }
    return func_minlan(n - 1, second, first + second); 
}
```

(d) Minlan's implementation is better. This is because `func_minlan` is tail-recursive: it ends with a tail call to itself. Because of this, the compiler is able to optimize the code by using simple jump instructions instead of an explicit `call` when it encounters the recursive call. As a result, a new stack frame need not be added to the call stack each time the recursion occurs. `func_eddie`, in contrast, has two explicit recursive function calls in the assembly code, which cannot be optimized away by the compiler. As a result, `func_eddie` uses O(n) space on the stack, whereas `func_minlan` does not use the stack at all for its computation.
