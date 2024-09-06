---
title: "cs2010 Notes: 02 Algos"
date: "2024-09-05"
---

## ex 1

Here's some pseudocode:

```
input a
input b
if (a > b)
    larger = a
else
    larger = b
output larger
```


Let's make it a flowchart: https://app.code2flow.com/

Let's make it C code:

```
#include <stdio.h>

int
main(int argc, char* argv[]) {
  int a, b, c;

  puts("What's a?");
  scanf("%d", &a);
  puts("What's b?");
  scanf("%d", &b);

  if (a > b) {
    c = a;
  }
  else {
    c = b;
  }

  printf("The larger value is: %d\n", c);
  return 0;
}
```

Let's make it an IPO Table


inputs: a, b

process:

if (a > b)
    larger = a
else
    larger = b

output: larger


To show the variety of code, let's make it a web page.


## ex 2

Multiplication by repeated addition:

```
input a, b
set c = 0
while b > 0:
    set c = c + a
    set b = b - 1
output c
```

For code, let's write it in Python with intermediate prints.

Then let's write it in j


## more

 - Sum all odd positive integers less than x
 - Determine which name is longer
 - Determine if a number is prime
