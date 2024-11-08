---
title: "cs2381 Notes: 32 Threads"
date: "2024-11-06"
---

**Sum101 Demos**

Here's a demo app. Do four variants:

 - Sequential (done)
 - Threads, no lock. (done)
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
