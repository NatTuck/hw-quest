---
title: "Notes: 32 Deadlock, Cache, etc"
date: "2023-11-14"
---

## Schedule:

 - Next week is lab makeup.
 - The last two labs are after that.
 - If you want to request a partner for labs 13/14, email me
   before Thanksgiving.
 

## Deadlock

```java
public class App {
    static Account alice;
    static Account bob;

    public static void main(String[] args) throws Exception {
        alice = new Account("Alice", 10);
        bob = new Account("Bob", 10);

        var ta = new ThreadA();
        ta.start();

        var tb = new ThreadB();
        tb.start();

        ta.join();
        tb.join();

        System.out.println("All done");
    }
}

class Account {
    String name;
    int balance;

    Account(String name, int b0) {
        this.name = name;
        this.balance = b0;
    }

    synchronized void transferTo(Account that) throws Exception {
        if (balance <= 0) {
            return;
        }

        System.out.println("Transferring $1 from " + name + " to " + that.name);

        this.balance -= 1;

        Thread.sleep(1000);

        synchronized(that) {
            that.balance += 1;
        }
    }
}

class ThreadA extends Thread {
    @Override
    public void run() {
        try {
            App.alice.transferTo(App.bob);
        }
        catch (Exception ee) {
            // pass
        }
    }
}

class ThreadB extends Thread {
    @Override
    public void run() {
        try {
            Thread.sleep(500);
            App.bob.transferTo(App.alice);
        }
        catch (Exception ee) {
            // pass
        }
    }
}
```

The "sychronized" does two things:

 - Takes the exclusive lock for the object when the block / method is entered.
 - Releases the exclusive lock when the block / method is left.

Only one thread can have a lock at a time. If a second thread attempts to take
an already-taken lock, it will block until that lock is released.

In this case:

 - Thread A takes the Alice lock, then tries to take the Bob lock.
 - Thread B takes the Bob lock, then tries to take the Alice lock.
 - Because the second lock that each thread tries to to take is already held
   by the other thread, the program deadlocks - it's stuck until killed.

Conditions for deadlock:

 - More than one thread.
 - More than one lock.
 - Circular wait.
 
How to avoid:

 - Have only one thread.
 - Have no more than one lock (synchronize on no more than one object).
 - Never take more than one lock at a time.
 - Always take the locks in your program in some global order.
   - This requires every programmer on the project to actually follow the
     rule - good luck with that.


## Cache

On my laptop:

 - 4 cores
 - Each core has 64kB L1 cache + 256kB L2 cache
 - All cores share 8MB of L3 cache

Why am I mentioning this today?

 - Accessing data in cache is much faster than accessing data not in cache.
 - The cache stores the stuff that has been accessed most recently.
 - Smaller caches are faster than big ones.
 - A BitSet with one bit for every integer up to 100 million takes 12
   megs of RAM.
   
So let's consider two access patterns:

 - For each prime, mark each multiple.
   - This will scan all 12MB sequentially once for each prime.
   - This is just too big for the L3 cache, so no bits you're marking
     will ever be in cache.
 - For every block of a million integers, go through every prime
   and mark every integer in that block.
   - A million integers takes a million bits, or 125kB - that fits in
     L2 cache.
   - It's plausible for L2 cache to be 20 times faster than main
     memory.

More detail:

```
    Main Memory:
        Size: 16GB of DDR3 2133
        Latency: 60ns = 240 cycles
        Throughput: 20 GB/s
    L3 Cache:
        Size: 8 MB (shared)
        Latency: 11ns = 44 cycles
        Throughput: > 200 GB/s
    L2 Cache:
        Size: 256 KB (per core)
        Latency: 3ns = 12 cycles
        Throughput: > 400 GB/s
    L1 Data Cache:
        Size: 32k (per core)
        Latency: 1ns = 4 cycles
        Throughput: > 1000 GB/s
```
