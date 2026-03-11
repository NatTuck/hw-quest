---
title: "Lecture Notes: 03-11 Complex Malloc"
date: "2026-03-06"
---

## Crazy-optimized Malloc

Minimizing overhead:

- None of our existing allocation strategies can handle malloc(1) efficiently.
- Two problems:
  - We need to round up our allocation size to support our linked list structure
    (e.g. next pointer).
  - We need to store a size field outside of the allocation.
- Even one of those gives us a factor of 8 overhead. Let's look at how we can do
  better.

### Tightly Packed Buddy System

- Sizes are always a power of two, so we can store the exponent rather than the
  whole number.
- Using 6 bits for size gives us sizes from 1 to 2^64.
- We also need a bit for the "allocated" field. That can just go in bit 7 of the
  size byte.
- But we also need next / prev pointers to track free blocks and enable O(1)
  removal. That'd be 2x8 bytes, so we need to shrink that.
- How big is a heap? How many heaps do we have?
- At what size is direct mmap / munmap more efficient?
- Is it actually useful to have 1 byte allocations? Can we shrink stuff more?

If we limit direct allocations to cases where the overhead will be no more than
2%, then that gives us 200k rounds up to 256k heaps. Let's just run the numbers for multiple 256k heaps, optimizing as much as possible.

- 256k is 2^18
- Assume minimum allocation is 8 bytes.
- So we need 17 sizes: 2^3...2^18
- That means the size field can be 4 bits.
- That means we can store linked list pointers in 16 bits. How?
- Header is 4 bytes: size + allocated + 24 bits for heap ID.
- Pointers are 4 bytes.
- This allows for 2**24 bytes of small allocations, minimum 8 bytes.

### Dedicated pages for bins / buckets

That's not a small enough minimum allocation.

Let's try bins. We'll take some fixed bin sizes, maybe
1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48, 64, ...

There's no way to fit sizes and pointers in a 1 byte allocation. So we won't put
them in the allocation. Instead: All metadata goes at the start of the 4k page.

This works for allocations up to about 2000 bytes. After that, allocations
necessarily take a full page.

Let's work through the whole implications of this.

### Extra

- Build the tightly packed buddy system allocator.
