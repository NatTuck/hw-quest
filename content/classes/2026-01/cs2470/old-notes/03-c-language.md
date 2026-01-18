---
title: "Lecture Notes: 03 The C Language"
date: "2025-01-24"
---

## More on C

 - A C program is a collection of functions
 - Types:
   - Integers: char, short, int, long
   - Floats: float, double
   - Do the sizeof program.
 - Pointers:
   - Two global ints (global data)
   - Two local ints (stack)
   - Two functions (text)
   - Two strings (ro data)
   - Array literal; array, elements.
 - Describe the memory layout.

## Quickly show the add1 program and ASM 

Another example:

```
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

```
# C => asm
$ gcc -S -o add1.s add1.c
# take a look at hello.s
```

 - Two functions: add1, main
   - each starts at label, ends at "ret"
 - In main, the value 5 is moved to "%rdi"
   - That must be where the function's first argument goes.
   - No, that's "%edi"
   - I said "%rdi", wait a second...
 - Then add1 is called
 - In add1, the value from %rdi goes to some places.
 - Eventually, "addq $1, ..." happens to it.
 - Back in main, %rax is moved to %rsi, and printf is called.


## Write average program

 - Read # of its with scanf.
 - Allocate stack array with dynamic array.
 - Read that # of ints in loop
 - Function to calculate average (pointer, size).
