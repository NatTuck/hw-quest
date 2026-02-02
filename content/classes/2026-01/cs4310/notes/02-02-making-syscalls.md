---
title: "Lecture Notes: 02-02 Making Syscalls"
date: "2026-01-31"
---

We've still got one function to hand-compile.

This one does system calls.

A system call is just like a function call, except:

- You put the syscall number in %rax
- The argument registers are slightly different after the third arg.
- You do "syscall" instead of "call function".

<https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/>

## Overflow

Show a couple other syscalls.
