---
title: "Lecture Notes: 02-04 Dynamic Mem"
date: "2026-02-02"
---

## Top 5 longest words

- Plan:
  - Read /usr/share/dict/words into an array.
  - Make an array of lengths.
  - Split things into functions.
  - index of longest
  - We'll use malloc for everything
- Why malloc?
  - We don't know the size of the array / string before the program runs,
    so we can't use a fixed size allocation.
  - We want to return an object of unknown size from a function, so we
    can't do a variable length array.
  - This does mean that the caller must free. That's part of the
    function interface.
- Review
  - Makefile first
    - gcc command
    - clean rule
    - tabs
  - Standard library functions and headers:
    - stdio.h: printf, fscanf, fgets
    - stdlib.h: atol
    - math.h: ceil, sqrt -- show manpage, talk about libm
  - Casts. For numbers, these convert.

## Introduce Memory Layout

- Data
- Text
- Heap
- Stack
