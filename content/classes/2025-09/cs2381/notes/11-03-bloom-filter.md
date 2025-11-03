---
title: "cs2381 Notes: 11-03 Bloom Filter"
date: "2025-11-01"
---

## Bloom Filters

- Idea: More than 1 hash function.
- I'm bad at math, so let's do some testing.
- Specifically, how do collissions scale with more hash functions.

## Overflow: Threads

**Concept**

Normally a program starts at the beginning, runs statements in some order,
and then finishes. Basically top of App#main to bottom, plus method calls.

But what if we want to do two things at the same time ("concurrently")?

Why?

- We're a network server, and we want to handle a second request
   before we're done with the first one.
- We're a GUI app, and we want to do some computationally intensive
   work while keeping our UI responsive.
- We want to run code in parallel on multiple cores to make our program
   finish running sooner.

There are a bunch of answers to that, and clearly defining concurrency
can be tricky, but one answer is adding threads.

A thread is what a processor core can run - the thing where we run a
part of the program in order. When a program starts, it's got one
thread - the main thread.

We can add extra threads (in Java: t = new Thread(); t.start()) , and
the'll run a different part of the program concurrently with any other
running threads.

There's a big complication though: Our basic model of how computer
programs run - starting at the beginning, running code in order, etc -
assumes only one thread. And both compilers for programming languages
and computer hardware have that assumption built in to their
structure.

But modern computers have multiple cores, and each one can run a
seprate thread concurrently... as long as those threads don't
interact. Once the threads start interacting, like by touching the
same object in memory, things get tricky.

**Sum101 Demos**

Here's a demo app. Do four variants:

- Sequential
- Threads, no lock.
- Threads, with lock.
- Local sums.

```java
public class App {
    static long sum;
    static long npp;

    static Object mutex;

    public static void main(String[] args) throws Exception {
        sum = 0;
        npp = 1000000000 / 10; // 100 million

        mutex = new Object();

        var workers = new Thread[10];
        for (int ww = 0; ww < 10; ++ww) {
            workers[ww] = new Thread(new Worker(ww));
            workers[ww].start();
        }

        for (int ww = 0; ww < 10; ++ww) {
            workers[ww].join();
        }

        System.out.println("sum = " + sum);
    }
}

class Worker implements Runnable {
    int wnum;

    Worker(int wnum) {
        this.wnum = wnum;
    }

    public void run() {
        long i0 = wnum * App.npp;
        long i1 = i0 + App.npp;

        for (long ii = i0; ii < i1; ++ii) {
            if (ii % 101 == 0) {
                synchronized (App.mutex) {
                    App.sum += ii;
                }
            }
        }
    }
}
```
