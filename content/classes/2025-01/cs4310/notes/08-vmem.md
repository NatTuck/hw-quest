---
title: "Lecture Notes: 08 Brk"
date: "2025-02-06"
---

ref: https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/

## Sample Program

 - Find the top 10 words with the most A's from
   /usr/share/dict/words
 - Keep an array of the top 10 so far, replace as needed.
 - Do it with malloc, show sys_brk, then move to sbrk
   and start worrying about free.
   

## Malloc and Brk

 - malloc
 - sbrk

The brk syscall:

 - Returns current brk on 0 argument.
 - Lets you set a higher brk.
 

