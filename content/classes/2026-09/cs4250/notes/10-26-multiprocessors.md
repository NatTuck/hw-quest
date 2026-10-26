---
title: "cs4250 Notes: 10-26 Multiprocessors"
date: "2026-10-24"
---

Today we're going to talk about an architecture topic where the
sg2000 dev boards are a bad example: Multiprocessors.

**Moore's Law**

"As semiconductor fabs improve, the number of transistors on shipped chips every
18 months."

"18 months" might not be right, maybe it's two years. But the assertion that
this grows exponentially has been pretty accurate now for half a century.



- 1971, Intel 4004, 2.2K transistors @ 10um ; 740 kHz
- 1982, Intel 80286, 130K transistors @ 1.5um ; 4Mhz
- 1993, Intel Pentium, 3.1M transistors @ 800nm ; 60MHz
- 2004, Intel Pentium 4, 125M transistors @ 90nm ; 3GHz
- 2014, Intel Core i7 gen 6, 3.4B transistors @ 14nm ; 3GHz
- 2022, Intel Core i9 gen 13, 20B transistors @ 10nm ; 3GHz (partial boost to
5.8)

It looked like clock speeds would increase like transistor counts until about
2005, then those basically stopped at ~3 GHz. That's the power limit: Laptop
CPUs want to be around 10W and desktop CPUs want to be around 100W. Doubling
frequency quadruples power.

So:

- 1970-2005: Write software, single thread, don't bother optimizing, if you can
run it at all on your dev box it'll run great on the twice as fast PC the user
has.
- After 2005, clock speed gains stopped. Three paths forward:
  - Spend transistors for stuff that speed up single-thread performance on
  existing programs. This is stuff like adding cache, doing multiple levels of
  speculative execution to avoids stalls, add adding really big fast dividers
  - Double the area? Copy and paste the chip, now it's double the cores.
  - Add new instructions that use a bunch of area to do specific stuff
  efficiently: wide vector units, but also stuff like dedicated encryption
  or video decoding instructions.
- The Intel Core 2010's death spiral:
  - Users buy new hardware because it makes their existing programs go fast.
  - Developers write programs to run fast on existing hardware.
  - Server/workstation hardware is where more cores really win, and that's
  a premium market segment.
  - So Intel stuck to quad-core and trying to speed single/few threaded
  execution for a decade.

So let's build from an old single core CPU, to a dual CPU system, to a modern
multi-core and a modern multi-socket.


**AMD Athlon 64 (2003)**

- Single core, 2GHz, 64kB L1i + 64kB L1d, 512kB L2
- X2 variant: two cores, no shared cache (2005)
- Initially, a Single channel DDR (yes, DDR1) memory controller, 
probably 2GB of RAM.
- Latency to DRAM: 50ns
- Latency to L2: 6.5ns
- Problem: Inter-core communication actually goes out to DRAM.
- Only slightly better than the old dual Pentium Pro systems, although
the big difference there would really be the on-die memory controller.


**Athlon X2 7000 (2008)**

- Much like the older X2, but added a shared L3 cache.
- Latency to DRAM (DDR2): 60ns (worse *because* of the L3)
- Latency to shared L3: 20ns
- Latency to L2: 5ns


## How to program for multi-core

The problem: In 2005, your desktop program was definitely designed to run
fast on a single core, typically with a single-threaded event loop design to
simulate concurrency / event handling. Importantly, going to two real threads
with locks would make your program slower on the single core machines that
most users had, while not providing a significant speedup on dual core without
a data structure redesign.

Multi-core support required a rewrite, and how to structure the rewrite has only
gotten really clear recently. The problem is that real parallel designs are only
a clear win at something like 8+ cores. Even with 6 cores, it can be most
efficient to design specifically for 4/6 cores rather than writing a scalable
mani-core engine/algorithm.

Why? Locks serialize, so they tend to cause a slowdown if you use them a lot.
That means you want to have each thread working on either shared immutable data
or a mutable copy of the data. In either of those cases, you end up needing to
do extra copies.

That's also relevant for architecture. CPU designers spent a lot of time
optimizing for contended locks (or avoiding contended locks with things like
restricted HTM, or just fast inter-core communication/synchronization in
general), but regardless of the hardware design you tend to get faster software
if you just design to avoid contention almost entirely.

## Next complication: NUMA

- ssh into celedyr, show `lscpu` and `lstopo`
- Let's try to draw this out.
- These are an AMD Bulldozer family CPUs, released in 2011.
- The building block is a "module", with two linked CPU cores. The two cores
have independent L1 caches and integer execution units, but they share a vector
FPU (which makes this really bad at modern AI stuff) and L2 cache.
- Four of these modules were designed together into an 8-core die. One of those
dies was the standard desktop CPU, including a dual channel DDR3 memory
controller.
- This server has two processors, and each one of those processors has two of
the 8 core dies. But each 8 core die has two cores disabled.
- So the result is 24 cores (but only 12 FPUs) on two chips and four dies. Each
die has two separate memory controllers, each 64GB of RAM is directly accessible
by 6 cores (dual channel DDR3 is ~24 GB/s). Cross-die memory access needs to go
over the hyper transport bus. The on-package HT link is faster than the
inter-socket link (12 vs 6 GB/s).
- Run ./icb

Contrast with zoologist, a clear single-socket dual channel consumer CPU.

This sort of setup is called NUMA, or Non-Uniform Memory Access. It's been
pretty common on servers/workstations for a long time.  And it's not
just a wacky old processor feature:

- ssh into kraken
- AMD EPYC 7642 (2019)
- One socket, 8 channels of DDR4, one socket, 4 NUMA nodes
- Basically the same, just on one less socket and 8 years later

Intel tries for less NUMA nodes:

- ssh into typhon
- can we figure this one out?


## NUMA and consumer gear

- ssh into vampire
- This one's really weird, it's quad channel DDR5, but only for the
integrated graphics


## Let's figure out how GPUs work


