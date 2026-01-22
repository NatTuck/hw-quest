---
title: "Notes: 01-23 Basic Linux"
date: "2026-01-21"
---

- You shouldn't be turning in AI generated code unless explicitly
allowed by the HW assignment.
- You can use AI tools all you want to analyze code and answer questions
about it.

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

### Directories

- Directories, pwd, cd, mkdir, rmdir
- Demonstrate ;, ||, &&, >, >>, <, and &.
- That feeds into bg, fg, jobs, etc.
