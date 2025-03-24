---
title: "Lecture Notes: 13 Syscall I/O"
date: "2025-03-22"
---

First, with line-based I/O.

```C
#include <stdio.h>

int
main(int argc, char* argv[])
{
    FILE* fh;
    if (argc == 2) {
        fh = fopen(argv[1], "r");
    }
    else {
        fh = stdin;
    }

    int xcount = 0;
    int lcount = 0;

    char line[100];
    line[99] = 0;

    while (fgets(line, 99, fh)) {
        lcount += 1;
        for (int ii = 0; line[ii]; ++ii) {
            if (line[ii] == 'x') {
                count += 1;
            }
        }
    }

    if (argc == 2) {
        fclose(fh);
    }
    
    printf("Found %d x in %d lines\n", xcount, lcount);

    return 0;
}
```

Lines are nice for text and a human-centric data model, but that's
got a secret scan for newlines in it, which requires buffering and
stuff. Let's read blocks instead.


```C
#include <stdio.h>

int
main(int argc, char* argv[])
{
    FILE* fh;
    if (argc == 2) {
        fh = fopen(argv[1], "r");
    }
    else {
        fh = stdin;
    }

    int xcount = 0;
    int lcount = 0;

    char block[100];

    size_t rv;
    while ((rv = fread(block, 1, 100, fh))) {
        for (int ii = 0; ii < rv; ++ii) {
            if (block[ii] == 'x') {
                xcount += 1;
            }
            if (block[ii] == '\n') {
                lcount += 1;
            }
        }
    }

    if (argc == 2) {
        fclose(fh);
    }
    
    printf("Found %d x's in %d lines\n", xcount, lcount);

    return 0;
}
```

Now let's use system calls.

 - A computer program running on a modern OS can access its own
   memory - reading, writing, and even executing code.
 - But it can't directly do anything else. Nothing that would effect
   other programs or have an externally visible effect.
 - So if a program wants to do stuff, the only way to do that is to
   ask the OS to do it. This happens through a mechanism called
   system calls.
 - Functions like "printf" and "fread" are from the C standard
   library. That's just code that gets linked into your program and
   runs like any other user code. It does stuff by making system
   calls.
 - A system call can really only be done from assembly code (the
   "syscall" instruction), but the C syscall API is intended to
   be called from C, so very simple wrappers are provided.
 - Manpages: 
   - man 3 fread (section 3: C std lib)
   - man 2 read (section 2: syscall wrapper)
 
 
 
```C
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

int
main(int argc, char* argv[])
{
    int fd;
    if (argc == 2) {
        fd = open(argv[1], 0);
    }
    else {
        fd = 0; // stdin
    }

    printf("reading from file, fd = %d\n", fd);

    int xcount = 0;
    int lcount = 0;

    char block[100];

    size_t rv;
    while ((rv = read(fd, block, 100))) {
        for (int ii = 0; ii < rv; ++ii) {
            if (block[ii] == 'x') {
                xcount += 1;
            }
            if (block[ii] == '\n') {
                lcount += 1;
            }
        }
    }

    if (argc == 2) {
        close(fd);
    }
    
    printf("Found %d x's in %d lines\n", xcount, lcount);

    return 0;
}
```

Overflow:

 - Build fgets (rdln) with a buffer that handles subsequent block reads.
