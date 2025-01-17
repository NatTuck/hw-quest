---
title: "Notes: 38 Cache, Sieve"
date: "2024-11-24"
---

## Cache

On my old laptop:

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

For example, my old laptop had these cache specs:

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


## Sieve of Eratosthenes

https://docs.oracle.com/javase/7/docs/api/java/util/BitSet.html

Let's build this as a sequential program.

 - BitSet means one bit per integer.
 - Sieve means marking every composite number.
 - This requires marking multiples of every prime up to sqrt(n)
