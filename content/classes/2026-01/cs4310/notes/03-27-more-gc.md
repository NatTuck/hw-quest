---
title: "Lecture Notes: 03-27 Exploring GC (2)"
date: "2026-03-25"
---

## Last time

- Reviewed basics for mark/sweep GC.
- Talked about stack scanning.

Getting stack pointer with inline asm to avoid pushing ra to stack:

```
void *sp;
__asm__ volatile ("movq %%rsp, %0" : "=r" (sp) : : );
```

Even better solution:

```
#include <pthread.h>
#include <stdio.h>   // for debugging only

void *get_stack_top(void)
{
    pthread_attr_t attr;
    void *stack_base;     // lowest address of the stack area
    size_t stack_size;

    pthread_getattr_np(pthread_self(), &attr);
    pthread_attr_getstack(&attr, &stack_base, &stack_size);
    pthread_attr_destroy(&attr);

    void *stack_top = (char *)stack_base + stack_size;   // highest address == top

    // Optional: round up to next page if you really want alignment
    // stack_top = (void *)(((uintptr_t)stack_top + 0xfff) & ~0xfff);

    return stack_top;
}
```

Another key piece: /proc/self/maps

- This gives us globals, main thread stack, heaps
- Remember that the gc heap doesn't contain roots, but if we mix malloc
with gc_malloc, then the malloc heap may be roots.

Roots:

- Stack (need get_stack from each thread when multi-threaded)
- Globals
- Registers (this is where we may need asm)

## Build a malloc wrapper and stack scanner

## Why can't we make a copying collector in C?

- Conservative collisions
- Interior pointers
