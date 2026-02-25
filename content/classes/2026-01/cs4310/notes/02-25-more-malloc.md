---
title: "Lecture Notes: 02-24 More Simple Malloc"
date: "2026-02-22"
---

## Problems and Solutions

This leaves some problems:

Problem 1: Where do we store the size of a chunk?

- We're the memory allocator. We can just allocate a bigger chunk and
   store the size *in* the chunk.
- We want to put it at the beginning of the chunk so we can find it again.

So when someone requests a chunk of size B, we allocate B + 8 bytes
layed out as follows:

- Size (size_t = 8 bytes)
- That many bytes of memory for the user.

We return a pointer to the memory after the size.

When the memory is freed, we can find the size by subtracting 8 bytes
from the pointer we got.

Problem 2: Where do we store the free list?

- The free list is made up of chunks of free memory.
- We can store the list in the memory itself.
- Easy to lay out a singly or doubly linked list in the
   memory.
- This makes our minimum actual memory allocation be the
   size of a list cell.

Problem 3: Fragmentation

```
   for (1..200) {
     xs[ii] = malloc(800);
   }
   
   for (1..10) {
     free(xs[ii]);
   }
   
   y = malloc(5000);
```

- We'd like to reuse the memory rather than requesting more from the OS.
- When we free memory, we want to check the free list to see if we can
   combine the chunk we're freeing with other chunks already on the list.
- We may need to combine more than once (A,C on free list, free B).

Problem 4: Big Allocations

- What if a program requests 10 GB of RAM and then frees it?
- We'd like to return that to the OS, not put it on the free list.
- Solution: Send large allocations directly to mmap, and then do a
   munmap when that memory is freed.
- For allocations over some threshold size, the cost of the syscall
   is going to be irrelevent.
- In this case we always allocate some number of whole pages.

[Here are some slides I stole from Christo Wison](
 ../../slides/8_Free_Space_and_GC.pptx).
