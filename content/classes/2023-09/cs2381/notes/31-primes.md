---
title: "cs2381 Notes: 31 Primes"
date: "2023-11-07"
---

For tomorrow's lab, we're going to count the primes up to some limit.

Base code:

```java
import java.util.ArrayList;
import java.util.List;

public class PrimesA {
    static long countPrimes(long nn) {
        var xs = findPrimes(nn);
        return xs.size();
    }

    static List<Long> findPrimes(long nn) {
        var ys = new ArrayList<Long>();
        for (long ii = 2; ii < nn; ++ii) {
            if (isPrime(ii)) {
                ys.add(ii);
            }
        }
        return ys;
    }

    static boolean isPrime(long xx) {
        for (long ii = 2; ii < xx; ++ii) {
            if (xx % ii == 0) {
                return false;
            }
        }
        return true;
    }
}
```

Optimizations:

 - Threads
 - Limit isPrime search to sqrt(xx)
 - Limit isPrime search to 2 and then odd numbers 
 - Build an array of primes
 - Do the Sieve of Eratosthenes with a BitSet

Can we count all primes up to a billion in less than 10 seconds?

What would it take to go to 10 billion?
