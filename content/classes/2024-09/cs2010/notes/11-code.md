---
title: "cs2010 Notes: 11 Code"
date: "2024-10-01"
---

# Overhead

 - Exam next Friday
 - The details of today's lecture won't be on the exam
 - Broad concepts may be


# How Code Works

 - Python is a scripting language.
 - The "python" command *interprets* the source code.
 - The program is data, and that would be true even on a Harvard archetecture
   machine.
   

```python
def add1(x):
    return x + 1

print(add1(5))
```

 - C is a simple AOT compiled language.
 - The "gcc" command *compiles* the source code to machine code.
 - Conceptually, through assembly code.
 - get distracted by printing sizeof(long)
 
```c
// add1.c
long
add1(long x)
{
    return x + 1;
}

int
main(int _ac, char* _av[])
  // initial _ marks args as not used
{
    long x = add1(5);
    printf("%ld\n", x);
    return 0;
}
```

```bash
gcc -S -o add1.s add1.c
```


 - Assembly is just a text format for machine code.

```asm
; add2.s
; note, maybe want # for comments

  .global main
  
  .text
; long add2(long x)
;   - the argument comes in in %rdi
;   - we return the result by putting it in %rax
add2:
  enter $0, $0
 
  # long y = x;
  mov %rdi, %rax
  
  # y = y + 2;
  add $2, %rax

  # return y;
  leave
  ret

main:
  enter $0, $0

  ; long x = 5;
  mov $5, %rdi
  
  ; y = add1(x)
  call add2
  ; result in %rax

; printf("%ld\n", y)
;  - first arg goes in %rdi
;  - second arg goes in %rsi
;  - for a variable arg function, we need to zero %al
;    - %al is the bottom 8 bits of %ax/%eax/%rax
  mov $long_fmt, %rdi
  mov %rax, %rsi
  mov $0, %al
  call printf

  leave
  ret
  
  .data
long_fmt: .string "%ld\n"
```

```
gcc -no-pie -o add2 add2.s
objdump add2
```


