---
title: "Lecture Notes: 04-29 Semester Review"
date: "2026-04-27"
---

## Course Overview

**CS4310 Operating Systems** explores how programs run on concrete computers.

**The Core Story:**

- Programs need hardware resources.
- An OS manages shared resources between multiple programs.
- Programs request resources via **system calls**.
- This course: writing programs that use syscalls + implementing syscalls.

**Platforms covered:**

- AMD64 Linux (desktops, laptops, servers)
- RISC-V Linux (embedded systems, growing popularity)

---

## C to Assembly

Programs run as machine code. Assembly is the human-readable text form.

**Translation pipeline:**

```
C → Assembly → Machine Code (binary)
gcc -S -o hello.s hello.c   # C to asm
gcc -o hello hello.s        # asm to binary
```

Key insight: C functions and ASM functions are the same thing—you can mix them.

---

## AMD64 Assembly Basics

**Registers:** `rax`, `rcx`, `rdx`, `rbx`, `rdi`, `rsi`, `rbp`, `rsp`, `r8-r15`

**Size variants:** `rax` (64-bit), `eax` (32-bit), `ax` (16-bit), `ah/al` (8-bit)

**Calling Convention:**

- Arguments: `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9` (then stack)
- Return value: `rax`
- Safe registers: `rbx`, `r12-r15` (callee-saved)

**Syscall Convention:**

- Syscall number in `rax`
- Arguments: `rdi`, `rsi`, `rdx`, `r10`, `r8`, `r9`
- Execute `syscall` instruction

---

## Memory Allocation

**The Problem:** Programs need heap memory dynamically.

**Old approach: `sbrk`** — grows the heap by adjusting the "break" point. Still exists but rarely used.

**Modern approach: `mmap`**

- Allocates memory in 4K pages
- `MAP_PRIVATE | MAP_ANONYMOUS` for heap allocation
- Can also map files into memory (I/O)

**Memory Allocator Design:**

1. Use `mmap` to get pages from OS
2. Maintain a **free list** of available blocks
3. Store size metadata in the allocation header
4. Handle fragmentation by coalescing adjacent free blocks
5. Large allocations go directly to `mmap`/`munmap`

---

## Page Tables & Virtual Memory

**Each process has its own virtual address space.**

**32-bit page tables:**

- 4K pages → 1M possible pages
- 2-level tree: top-level (1024 entries) + second-level tables
- Sparse: unused regions don't allocate second-level tables

**64-bit page tables:**

- 4-level tree (9 bits each level)
- 48 bits of virtual address space

**TLB (Translation Lookaside Buffer):**

- Caches page table translations
- Avoids 4+ memory reads per address lookup
- Invalidated on context switch → performance cost

---

## Processes vs. Threads

**Processes (`fork`, `exec`):**

- Separate address spaces
- `fork()` copies address space (copy-on-write)
- `exec()` replaces program with new one
- Context switch: save registers, switch page tables, invalidate TLB

**Threads (`pthread_create`):**

- Shared address space
- Each thread has its own stack
- Context switch faster (no TLB invalidation)
- **Data races** possible on shared mutable data

---

## Synchronization Primitives

**Data Race Conditions**: Concurrent Execution, Shared Data, Somebody Writes

**Mutex:** Lock for mutual exclusion

**Condition Variable:** Wait for condition to become true (used with mutex)

**Semaphore:** Counter with wait (`sem_wait`) and signal (`sem_post`)

- Useful for producer-consumer patterns

**Deadlock conditions:**

- Hold and wait
- Circular dependency
- Mutual exclusion, no preemption

---

## RISC-V Architecture

**RISC (Reduced Instruction Set)** vs AMD64's CISC.

Key difference: **Load/Store Architecture**

- Math only on registers
- Must `ld` (load) from memory, `sd` (store) back

**Registers (ABI names):**

- `a0-a7`: arguments/return
- `t0-t6`: temporaries (caller-saved)
- `s0-s11`: saved registers (callee-saved)
- `sp`: stack pointer
- `ra`: return address

---

## Garbage Collection

**Mark-and-Sweep:**

1. Start from roots (stack, globals)
2. Mark all reachable objects
3. Sweep: free unmarked objects

**Root identification:**

- Entire stack is a root
- Globals need explicit registration
- Use `/proc/self/maps` to find memory regions

**Why not copying collector in C?**

- Conservative scanning (false positives)
- Interior pointers (pointers into middle of objects)

---

## OS Kernels

**Kernel capabilities (userspace can't do):**

- Use physical addresses
- Execute any CPU instruction
- Configure page tables
- Direct hardware access

**System call flow (xv6):**

1. User: `ecall` instruction → trap to kernel
2. Trampoline: save registers to trapframe
3. `usertrap()`: dispatch syscall by number
4. Syscall handler: extract args, execute
5. Return: restore registers, `sret` back to user

---

## File Systems

**FAT**:

- Simple
- Not great for modern systems
- Metadata in directories

**EXT**:

- Add inodes
- Future versions add enhancements:
- ext2: block groups
- ext3: journaling
- ext4: optimizations

**FUSE (Filesystem in Userspace):**

- Filesystem driver as userspace program
- Kernel calls callbacks for FS operations
- Operations: `getattr`, `read`, `write`, `readdir`, `create`, `unlink`

**ZFS / BTRFS features:**

- Copy-on-write: writes go to new blocks, old data preserved
- Snapshots: pin old roots for rollback
- Built-in multi-disk support (replaces RAID)
- Checksums for corruption detection

---

## Concurrency Patterns

**Avoiding data races:**

| Approach | Example | Mechanism |
|----------|---------|-----------|
| No parallelism | JavaScript | Event loop, single thread |
| Message passing | Go | Channels transfer ownership |
| Immutability | Rust | Compile-time ownership rules |
| Full immutability | Erlang | All data immutable, processes message-pass |
| Transactions | Clojure | Detect races, rollback/replay |

**GPU/Data Parallelism:**

- Same operation on many values simultaneously
- GPUs: hundreds of shader units, one program
- OpenCL, CUDA: array operations in parallel

---

## Final Takeaways

1. **System calls** are the interface between programs and OS
2. **Virtual memory** gives each process its own address space
3. **Page tables + TLB** make virtual memory practical
4. **Processes** isolate; **threads** share (but need synchronization)
5. **Memory allocators** manage free lists and fragmentation
6. **Kernels** run with full hardware access; user programs are restricted
7. **File systems** manage persistent storage; FUSE enables userspace FS
8. **Concurrency** requires careful design to avoid races and deadlocks

**Key skills from this course:**

- Writing and reading assembly (AMD64, RISC-V)
- Implementing memory allocators
- Working with processes, threads, and synchronization
- Understanding kernel internals (xv6)
- Building filesystems (FUSE)

