---
title: "Notes: 01-21 Welcome"
date: "2026-01-20"
---

## Welcome to 4310

- Instructor: Nat Tuck
- Course: CS4310 Operating Systems

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
- Add a dedicated program to talk the hardware: the OS. Other
programs ask the OS to access shared resources for them.
- To ask the OS to do stuff for you, you make a system call.
- This class is about;
  - Writing programs that use system calls.
  - Implementing system calls.
- System calls are different on different operating systems,
so we need to pick a specific one to use.
- We're using Linux. More specifically, a modern Debian-family Linux.
- Even with an OS, programs are still written to target a specific
hardware architecture.
- Compiled programs are binary data - machine code - and different
kinds of processors have different machine codes.
- We'll looking at two different processor architectures:
  - AMD64, common for non-mac desktops, laptops, and servers.
  - RISCV, an open source architecture primarily used in embedded systems but
  slowly getting more popular.
- A platform is the combination of processor architecture and OS. We'll look at
AMD64 Linux and RISCV Linux.

## Course Resources

- My site: <http://homework.quest/>
- Course Site / Syllabus
- Inkfish
- Office Hours start Monday.

## Syllabus

- There's a schedule. It may resemble what happens.
- Grades: Homeworks, Final Exam
- Homework: These are difficult programming assignments.
  - Some may be extra hard and worth double points.
  - Some may be in-class exercises.
- Exam: On paper. Paper (including printed) notes allowed.

Cheating

- Don't submit other people's code as your own.
- Don't share solutions with other students.

AI

- You shouldn't be turning in AI generated code unless explicitly
allowed by the HW assignment.
- You can use AI tools all you want to analyze code and answer questions
about it.

## Inkfish

- Show Inkfish
- Show hw01a / hw01b

## HW01a: Local Linux VM

- The easiest way to do programming work is to have the development
environment installed locally on your personal computer.
- For Linux systems programming, Linux *is* our development environment.
- Having it installed as your main OS is probably best.
- But, for consistent ency, the assignment is for everyone to install
exactly Mint 22.3 AMD64 in a virtual machine.
- If you aren't developing on the VM and you run into weird problems later in
the semester, use this VM to rule out configuration issues.

## HW01b: Dev Setup

Programming homework:

- Download starter code.
- Write some simple C and ASM code.
- Really write them by hand. Don't have AI do it. Don't use the compiler
to generate the assembly.
- Make sure it compiles and runs.
- Pack it back up and submit.

This assignment is mostly about structure, process, and getting annoyed
at the autograder.

Keep in mind:

- A C (or asm) program is a collection of functions.
- These functions can be in one source file or in a bunch of different files.
- C functions and ASM functions are the same thing. You can mix them together
in the same program.
- It's easiest if each file is all-C or all-ASM.

Object file example:

- add1.c
- add2.c
- main.c

```
gcc -c -o add1.o add1.c
gcc -c -o add2.c add2.c
...
gcc -o example add1.o add2.o main.o
```

## C -> ASM

- "Programming" means "writing C code".
- On Linux-like (UNIX, *nix, POSIX) systems, the operating system
API is primarily exposed to C programs through the system C library.
- The hardware doesn't run C though - it runs amd64 machine code (on your
laptop) or ARM machine code (on your phone) or maybe some other machine
code.
- Machine code is for machines, not humans, so it's hard to read.
- Machine code is a series of instructions. If you write the instructions
down as text, you get assembly language.
- To run a C program, you need to translate to machine code (or "binary").
- Conceptually, and historically, you first translate C -> ASM, then
ASM -> binary.
- You can still do this if you explicitly ask for it.

Note: For the first few homeworks you will be writing ASM programs. You
should *not* have a compiler do this for you. Submitting compiler output
for an assembly assignment is worth zero points.

Example:

```
// A C program is a collection of functions.
// Here's a minimal program with one function
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

# C => asm
$ gcc -S -o hello.s hello.c
# take a look at hello.s

# asm => binary
$ gcc -o hello hello.s
$ ./hello
```

Interesting stuff in hello.s:

- The string is there, but no newline.
- The main function exists
  - Starts at label "main"
  - Ends at "ret".
  - Declared ".globl"
- In the main function another function is called - not printf, but puts.
