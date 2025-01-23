---
title: "Lecture Notes: 03 The C Language"
date: "2025-01-24"
---

## Introducing C


```
// A C program is a collection of functions.
// Here's a minimal program with one function
#include <stdio.h>

int
main(int argc, char* argv[])
{
  printf("Hello C program\n");
  return 0;
}

```

```
# Direct C => binary
$ gcc -o hello hello.c
$ ./hello
```


More stuff to show/say:

 - Command line args
 - A C program is a collection of functions
 - Manpages
 - Built-in types in C: char, short, int, long
 - Types have sizes: sizeof(...)
 - Strings are a trick.


## Basic Linux and Vim

 - Working on the Linux command line.
 - Command line basics: command, arguments
 - Directories, pwd, cd, mkdir, rmdir

vim editor

 - syntax highlighting and auto-indentation
 - editing modes
 - combining 
 - navigating with relative moves
 - cutting and copying lines and groups of lines
 - navigating with ? and /

