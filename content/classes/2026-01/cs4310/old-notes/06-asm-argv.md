---
title: "Lecture Notes: 06 Command Line Args"
date: "2025-02-01"
---

args.S

```asm
   .global main
    .text

main:
    push %r12 // argv
    push %r13 // argc
    enter $0, $0

    mov %rdi, %r13
    mov %rsi, %r12
aa:
    mov (%r12), %rdi
    cmp $0, %rdi
    je bb

    call puts
   
    add $8, %r12
    jmp aa

bb:
    leave
    pop %r13
    pop %r12
    ret
```




