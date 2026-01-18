---
title: "Lecture Notes: 25 Asm Lab"
date: "2025-04-27"
---

# Hello, stdlib

```C
#include <stdio.h>
#include <string.h>

void
hello(const char* name)
{
  printf("Hello, %s", name);
}

int
main(int argc, char* argv[])
{
  hello(argv[1]);
  return 0;
}
```

```
amd64$ gcc -S -O0 -masm=intel -fverbose-asm example.c -o example.s
riscv$ gcc -S -fverbose-asm hello.c -o hello.s
```

## Hello, syscall

```C
#include <unistd.h>

void
hello(const char* name)
{
  write("Hello, ");
  write(name);
}

int
main(int argc, char* argv[])
{
  hello(argv[1]);
  return 0;
}
```

## Factorial

```C
#include <stdio.h>
#include <string.h>

long
fact(long nn)
{
  if (nn == 1) {
    return 1;
  }
  return n*fact(n-1);
}

int
main(int argc, char* argv[])
{
  hello(argv[1]);
  return 0;
}

```
