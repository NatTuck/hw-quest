---
title: "Lecture Notes: 01-26 C to AMD64"
date: "2026-01-24"
---

Actually writing assembly in practice isn't super common, but it's useful to
have a clear idea of how C is translated to assembly and how the result is
structured.

So we're going to quickly go through one moderately long example which will
show many of the moving parts.

Here's sum-arg-lens.c:

```C
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void
swap(char* text, int ii, int jj)
{
    char tmp = text[ii];
    text[ii] = text[jj];
    text[jj] = tmp;
}

void
reverse(char* text, int ii, int jj)
{
    if (ii >= jj) {
        return;
    }

    swap(text, ii, jj);
    reverse(text, ii + 1, jj - 1);
}

char ltoa_buf[24];

char*
ltoa(long xx, int* nn)
{
    int ii = 0;
    while (xx > 0) {
        ltoa_buf[ii] = '0' + xx % 10;
        xx = xx / 10;
        ii = ii + 1;
    }

    ltoa_buf[ii] = 0;
    *nn = ii;

    reverse(ltoa_buf, 0, ii - 1);
    return ltoa_buf;
}

int
main(int argc, char* argv[])
{
    int sum = 0;
    for (int ii = 1; ii < argc; ++ii) {
        sum += strlen(argv[ii]);
    }

    int nn;
    char* buf = ltoa(sum, &nn);

    write(1, buf, nn);
    write(1, "\n", 1);

    return 0;
}
```

## Some notes

Registers: rax, rcx, rdx, rbx, rdi, rsi, rbp, rsp, r9, ..., r15

Size variants: rax, eax, ax, ah/al

Calling convention:

- arguments go in, in order: rdi, rsi, rdx, rcx, r8, r9, (stack)
- syscall args go in: rdi, rsi, rdx, r10, r8, r9
- return value comes out in rax
- (second return in rdx)
- To call a varargs, function, you must first zero %al
- Safe registers are: %rbx, %r12-%r15

## We'll do one function at a time

Here's our Makefile.

```Makefile
CFLAGS := -no-pie -Wl,-z,noexecstack

sal: sal.c sal.S
        gcc $(CFLAGS) -o sal sal.c sal.S

clean:
        rm sal
```

Here's the final assembly code.

```asm
/*
void
swap(char* text, int ii, int jj)
{
    char tmp = text[ii];
    text[ii] = text[jj];
    text[jj] = tmp;
}
Vars:
 - text, ii, jj are %rdi, %rsi, %rdx
 - tmp is %al
 - implicit temporary is %cl
 - leaf function, so we're fine just using temp regs
*/
    .text
    .global swap
swap:
    // leaf function, can skip stack stuff

    mov (%rdi,%rsi,1), %al  // t1 = text[ii]
    mov (%rdi,%rdx,1), %cl  // t2 = text[jj]
    mov %cl, (%rdi,%rsi,1)  // text[ii] = t2
    mov %al, (%rdi,%rdx,1)  // text[jj] = t1

    ret

/*
void
reverse(char* text, int ii, int jj)
{
    if (ii >= jj) {
        return;
    }

    swap(text, ii, jj);
    reverse(text, ii + 1, jj - 1);
}
Vars:
 - We do function calls, so we need to do stack management
   register preservation.
 - But our function calls basically just have the same args
   in the same place.
 - So we'll do the caller-save pattern to preserve temp
   registers across function calls.
 - text, ii, jj are %rdi, %rsi, %rdx
 - enter sets up stack and allocates stack space
   we don't need extra stack space
*/
    .global reverse
reverse:
    enter $0, $0

    // if ii >= jj: return
    cmp %rdx, %rsi  // swap args for AT&T asm
    jge swap_done

    // prepare to call swap
    // save temp registers on stack
    push %rdi
    push %rsi
    push %rdx
    // align stack to multiple of 16 before call
    sub $8, %rsp
    call swap
    // reverse align, restore temps
    add $8, %rsp
    pop %rdx
    pop %rsi
    pop %rdi

    // prepare to call reverse
    // variables aren't used again after call,
    // so we don't need to save them
    // and we can modify ii and jj in place
    inc %rsi
    dec %rdx
    call reverse
    // we can do TCO here if we want
    
swap_done:
    leave
    ret


/*
char ltoa_buf[24];
*/

    .data
    // .global ltoa_buf
ltoa_buf:
    .zero 24

/*
char*
ltoa(long xx, int* nn)
{
    if (xx == 0) {
        ltoa_buf[0] = '0';
        ltoa_buf[1] = 0;
        *nn = 1;
        return ltoa_buf;
    }

    int ii = 0;
    while (xx > 0) {
        ltoa_buf[ii] = '0' + xx % 10;
        xx = xx / 10;
        ii = ii + 1;
    }

    ltoa_buf[ii] = 0;
    *nn = ii;

    reverse(ltoa_buf, 0, ii - 1);
    return ltoa_buf;
}
Vars:
 - No function calls until reverse.
 - So we can almost leave args and assign locals to temp regs.
 - The div instruction uses %rax and %rdx
 - xx, nn, ii are %rdi, %rsi, %rcx
 - temps are %r10 and %r11
*/

    .text
    .global ltoa
ltoa:
    enter $0, $0   

    cmp $0, %rdi
    jne ltoa_nonzero

    mov $ltoa_buf, %r10
    movb $'0', (%r10)
    inc %r10
    movb $0, (%r10)
    movl $1, (%rsi)
    jmp ltoa_done

ltoa_nonzero:

    mov $0, %rcx
ltoa_while_cond:
    cmp $0, %rdi
    jng ltoa_while_done

    //call print_long

    mov $0, %rdx
    mov %rdi, %rax
    mov $10, %r11
    div %r11
    // %rax = xx / 10
    // %rdx = xx % 10
    add $'0', %rdx
    mov $ltoa_buf, %r10
    mov %dl, (%r10, %rcx, 1)
    mov %rax, %rdi

    inc %rcx
    jmp ltoa_while_cond

ltoa_while_done:
    mov $ltoa_buf, %r10
    movb $0, (%r10, %rcx, 1)

    mov %ecx, (%rsi)

    mov $ltoa_buf, %rdi
    mov $0, %rsi
    dec %rcx
    mov %rcx, %rdx
    call reverse

ltoa_done:
    mov $ltoa_buf, %rax
    leave
    ret

/*
int
main(int argc, char* argv[])
{
    int sum = 0;
    for (int ii = 1; ii < argc; ++ii) {
        sum += strlen(argv[ii]);
    }

    int nn;
    char* buf = ltoa(sum, &nn);

    write(1, buf, nn);
    write(1, "\n", 1);

    return 0;
}
Vars:
 - argc, argv, ii, sum need to survive strlen call
 - we'll put them in safe regisers
 - argc, argv, ii, sum are %r12, %r13, %r14, %r15
 - nn gets its address taken, it goes on stack
 - nn is 0(%rsp)
 - buf just goes straight from %rax to %rsi
*/

    .data
newline: .string "\n"

    .text
    .global main
main:
    push %r12
    push %r13
    push %r14
    push %r15
    // 4 registers are divisible by 16
    // nn is 14 bytes, but we allocate 16 to keep aligned
    enter $16, $0

    mov %rdi, %r12
    mov %rsi, %r13
    mov $0, %r15

    mov $1, %r14
main_for_cond:
    cmp %r12, %r14
    jnl main_for_done

    mov (%r13, %r14, 8), %rdi
    call strlen
    add %rax, %r15

    inc %r14
    jmp main_for_cond

main_for_done:
    mov %r15, %rdi
    lea 0(%rsp), %rsi
    call ltoa

debug1:

    // first three syscall arguments are the same
    mov $1, %rdi
    mov %rax, %rsi
    mov 0(%rsp), %rdx
    // write is syscall #1
    mov $1, %rax
    syscall

    mov $1, %rdi
    mov $newline, %rsi
    mov $1, %rdx
    mov $1, %rax
    syscall

    leave
    pop %r15
    pop %r14
    pop %r13
    pop %r12
    ret

// This debug function does't follow
// the standard calling convention.

    .data
lfmt: .string "long = %ld\n"

    .text
    .global print_long
print_long:
    push %rax
    push %rcx
    push %rdx
    push %rsi
    push %rdi
    push %r8
    push %r9
    push %r10
    push %r11
    enter $0, $0

    mov %rdi, %rsi
    mov $lfmt, %rdi
    mov $0, %al
    call printf

    leave
    pop %r11
    pop %r10
    pop %r9
    pop %r8
    pop %rdi
    pop %rsi
    pop %rdx
    pop %rcx
    pop %rax
    ret
```
