Storage solution
================
(a) Here's one solution:

```c++
#include <unordered_map>

int fibonacci(unsigned int n) { 
    static std::unordered_map<int, int> cache;
    
    if (cache.find(n) != cache.end()) {
        return cache[n];
    }
    
    int fib;
    if (n <= 2) {
        fib = 1; 
    } else {
        fib = fibonacci(n - 1) + fibonacci(n - 2);
    }
    cache[n] = fib;
    return fib;
} 
```

(b) The miss rate is 7/8 = 87.5%. The only value that is already in the cache when the function is called on it is the last 4 (which is computed and stored in the cache when the previous 6 is computed).

(c) Unlike in an stdio cache, the values in the reference strings in the context of memoization are not independent of each other. For example, computing the 10th Fibonacci number when the 9th and the 8th are stored in the cache is much faster than when the cache is empty. However, both will be treated as misses and will be given equal weight under the usual definitions.

(d) The memo misses corresponding to each input are given below:

```
With caching:
1 2 4 1 2 3 6 4
0 0 2 0 0 1 3 0
Total memo miss = 6

Without caching:
1 2 4 1 2 3 6 4
0 0 2 0 0 1 7 2
Total memo miss = 12
```

Therefore, the memo miss rate is 50%. This gives a clearer picture of how the cache makes the computation faster.
