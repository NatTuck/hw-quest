---
title: "Lecture Notes: 02 Linux Basics"
date: "2025-01-24"
---

### Simple C Program

(do this in in a terminal window with a file manager
open to the same directory so we can watch stuff appear)

```C
#include <stdio.h>

int
main(int argc, char* argv[])
{
    printf("Hello, C\n");
    return 0;
}
```

Compile that program:

```bash
$ gcc -o hello hello.c
```

Running commands on linux:

 - First word is the name of the program executable file.
 - Found by searching $PATH
 - The rest of the words are command line arguments.

Run it:

```bash
$ ./hello
```

 - Current directory isn't in $PATH
 - So we need to tell the shell where to find the program
   with ./

Handling arguments:

```C
#include <stdio.h>

int
main(int argc, char* argv[])
{
    printf("argv has %d items:\n", argc);
    for (int ii = 0; ii < argc; ++ii) {
       printf(" - %d: %s\n", ii, argv[ii]); 
    }
    return 0;
}
```

### Directories

 - Directories, pwd, cd, mkdir, rmdir

### vim editor

 - syntax highlighting and auto-indentation
 - editing modes
 - combining 
 - navigating with relative moves
 - cutting and copying lines and groups of lines
 - navigating with ? and /


### More complicated Linux commands

 - Demonstrate ;, ||, &&, >, >>, <, and &.
