---
title: "Notes: 01-21 Intro"
date: "2026-01-20"
---

## Welcome to 2470

- Instructor: Nat Tuck
- Course: CS2470 Systems Programming in C/C++

Where does this course fit in?

- You're a CS major
- You can write computer programs.
- In this course, we explore some of the details of how
   actual programs run on concrete computers.

The plot:

- To do things, programs need to use hardware resources.
- 1980 personal computer: one program at a time.
- Two programs at a time means conflicts (who gets input from
   keyboard? don't want to mix output to line printer!)
- Add a dedicated program to talk the the hardware: the OS. Other
   programs ask the OS to access shared resources for them.
- To ask the OS to do stuff for you, you make a system call.
- This class is about writing programs that use system calls.
- System calls are different on different operating systems,
   so we need to pick a specific one to use.
- We're using Linux. More specifically, a modern Debian-family Linux.
- Even with an OS, programs are still written to target a specific
   hardware archetecture.
- Compiled programs are binary data - machine code - and different
   kinds of processors have different machine codes.
- We'll be using a common archetecture for desktop / laptop
   computers, the AMD64 archetecture.
- A platform is the combination of processor archetecture and OS,
   for us that's AMD64 Linux.

## Course Resources

- My site: <http://homework.quest/>
- Course Site / Syllabus
- Inkfish
- Office Hours start Monday.

## Inkfish

- Show Inkfish
- Show hw01

## Syllabus

- There's a schedule. It may resemble what happens.
- Grades: Homeworks, Labs, Project
- Homework: These are difficult programming assignments.
- Labs: These are in-class programming assignments.
- Project: This is a large, difficult programming assignment.
  
Cheating

- Don't submit other people's code as your own.
- Don't share solutions with other students.

AI

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
