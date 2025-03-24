---
title: "Lecture Notes: 23 Project One"
date: "2025-03-22"
---


# Strategies for Project 1

## Let's look at the starter code

Three programs:

 - ivec_main.c
 - list_main.c
 - frag_main.c

We're supposeded to write an allocator that makes the first two programs
go fast. The third program just checks for worst-case memory usage.

So let's inspect what these two programs we want to optimize are actually doing:

```C
// opt-malloc


#include "xmalloc.h"

#include <stdlib.h>
#include <stdio.h>

void*
xmalloc(size_t bytes)
{
    // How big are the allocations?
    printf("size = %ld\n", bytes);
    
    // Just delegate to sysmalloc for now.
    return malloc(bytes);
}

void
xfree(void* ptr)
{
    free(ptr);
}

void*
xrealloc(void* prev, size_t bytes)
{
    return realloc(prev, bytes);
}
```

Now let's run both programs and see what we get for sizes.

```bash
$ ./collatz-list-opt 100
$ ./collatz-ivec-opt 100
```

The list program only does one size of allocations, so let's try
optimizing for that.

The simplest possible allocator with an optimization for that one size:

```C

#include "xmalloc.h"

#include <sys/mman.h>
#include <string.h>

typedef struct small_block {
    size_t size;
    struct small_block* next;
    size_t _unused;
} small_block;

// https://gcc.gnu.org/onlinedocs/gcc/Thread-Local.html
static __thread small_block* smalls = 0;

void
small_free(void* ptr)
{
    small_block* block = ptr - 8;
    block->next = smalls;
    smalls = block;
}

void*
small_alloc()
{
    if (smalls == 0) {
        small_block* page = xmalloc(4088);
        for (int ii = 0; ii < 170; ++ii) {
            small_free(&(page[ii]));
        }
    }

    small_block* block = smalls;
    smalls = smalls->next;
    block->size = 24;
    return &(block->next);
}

void*
xmalloc(size_t bytes)
{
    // Space for header
    bytes += sizeof(size_t);

    // small allocations
    if (bytes <= 24) {
        return small_alloc();
    }

    // big allocations
    size_t* big = mmap(0, bytes, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
    *big = bytes;
    return (void*)(big + 1);
}

void
xfree(void* ptr)
{
    size_t* bytes = ((size_t*)ptr) - 1;
    size_t sz = *bytes;

    if (sz <= 24) {
        small_free(ptr);
    }
    else {
        munmap(bytes, sz);
    }
}

void*
xrealloc(void* prev, size_t bytes)
{
    void* next = xmalloc(bytes);
    memcpy(next, prev, bytes);
    xfree(prev);
    return next;
}
```

Now let's profile it.

To set up profiling:

 - Add -pg to CFLAGS
 - ./collatz-list-opt 100000
 - gprof ./collatz-list-opt 
 - Look at the flat profile; ignore the rest.

What other optimizations have people considered?
