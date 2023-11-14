---
title: "cs2381 Notes: 31 Primes"
date: "2023-11-07"
---

For tomorrow's lab, we're going to count the primes up to some limit.

App code:

```java
public class App {
    public static void main(String[] args) {
        int procs = Runtime.getRuntime().availableProcessors();
        System.out.println("We have " + procs + " hardware threads.");

        long t0 = System.nanoTime();
        long count = Primes.countPrimes(10000);
        long t1 = System.nanoTime();
        long ms = ((t1 - t0) / 1000000);

        System.out.printf("found %d primes in %d ms\n", count, ms);
    }
}
```

Base Primes code:

```java
import java.util.ArrayList;
import java.util.List;

public class Primes {
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
 - Build an ArrayList of primes
 - Do the Sieve of Eratosthenes with a BitSet

Can we count all primes up to a billion in less than 10 seconds?

What would it take to go to 10 billion?


## Sample Optimizations

Threads:

```java
        var workers = new WorkerC[P];
        
        for (int ii = 0; ii < P; ++ii) {
            long i0 = Math.max(2, ii*npp);
            long i1 = ii == (P - 1) ? nn : (ii+1) * npp;
            workers[ii] = new WorkerC(i0, i1);
            workers[ii].start();
        }

        long count = 1; // 2
        for (int ii = 0; ii < P; ++ii) {
            try {
                workers[ii].join();
                count += workers[ii].count;
            }
            catch (InterruptedException ee) {
                throw new Error("interrupted");
            }
        }

class WorkerC extends Thread {
    long i0;
    long i1;
    long count;

    WorkerC(long i0, long i1) {
        this.i0 = i0;
        this.i1 = i1;
        this.count = 0;
    }

    @Override
    public void run() {
        this.count = PrimesC.countPrimesRange(i0, i1);
    }
}
```

ArrayList:

```java
import java.util.ArrayList;
import java.util.List;

public class PrimesAL {
    static ArrayList<Long> primes;
    
    static long countPrimes(long nn) {
        primes = new ArrayList<Long>();
        primes.add(2L);
        primes.add(3L);
        primes.add(5L);

        for (long ii = 7; ii < nn; ii += 2) {
            if (isPrime(ii)) {
                primes.add(ii);
            }
        }
        
        return primes.size();
    }

    static boolean isPrime(long xx) {
        long top = 1 + (long) Math.ceil(Math.sqrt(xx));
        for (long yy : primes) {
            if (yy > top) {
                break;
            }
            if (xx % yy == 0) {
                return false;
            }
        }
        return true;
    }
}
```
