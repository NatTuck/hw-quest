---
title: "Lecture Notes: 04-22 Locks and Deadlock"
date: "2026-04-20"
---

## Virtual Memory and Threads

- With threads, all memory is shared by default.
- No need for mmap or special shared memory allocation.
- Advantage: Allocating shared memory post-spawn is trivial.
- Disadvantage: 100% data races on shared writable data.

## Threads vs. Processes

- We can spawn multiple processes with fork()
- We can execute multiple threads within a single process.

Key difference: With threads, all memory is shared by default.

- Advantage: Allocating shared memory post-spawn.
- Disadvantage: 100% data races

### History

#### Early days

- Before multi-processor systems parallelism didn't matter.
- Concurrency was still useful though:
  - Running multiple programs at once.
  - Having multiple logical tasks happening within one program.
- On Unix style systems, processes were commonly used for concurrency.
- On early Windows / Mac systems, concurrency within a program was represented
   by cooperative threading:
  - One thread could run at a time.
  - To let other threads run, explicitly call yield()
  - Some systems had an implicit yield when a thread blocked on I/O.
- By the 90's, systems had some sort of pre-emptive threading. This still didn't
   work in parallel, but it would automatically schedule work between threads
   without explicit yield() calls.

#### Multiprocessors

- Multiprocessor servers became widely available in the mid 90's.
- Windows and Solaris had decent parallel thread support.
- Linux didn't get fully functional threads until like 2002, so fork() was
   heavily optimized instead.
- Result: Threads are much more efficient than processes on Windows.
- Threads under Linux evolved from fork(), so the performance difference
   is small.
- Multi-core desktop processors showed up around 2005, and suddenly
   parallelism became nessisary for performance.
