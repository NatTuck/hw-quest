---
title: "Lecture Notes: 11 Pointer Arithmetic"
date: "2025-02-20"
---

Last time we talked a bit about pointer arithmetic.

Let's review that some more.


```C
#include <stdio.h>

typedef struct pair {
    long aa;
    long bb;
} pair;

int
main(int argc, char* argv[])
{
    printf("sizeof(char)  = %ld\n", sizeof(char));
    printf("sizeof(short) = %ld\n", sizeof(short));
    printf("sizeof(int)   = %ld\n", sizeof(int));
    printf("sizeof(long)  = %ld\n", sizeof(long));
    printf("sizeof(int*)  = %ld\n", sizeof(int*));
    printf("sizeof(char*) = %ld\n", sizeof(char*));
    printf("sizeof(pair)  = %ld\n", sizeof(pair));
    printf("\n");
    
    char bytes[] = {1, 1, 1, 0, 0, 0};

    char* bs0 = &(bytes[0]);
    char* bs1 = &(bytes[1]);

    printf("bytes[0] @ %p\n", bs0);
    printf("bytes[1] @ %p\n", bs1);
    printf("[0] + 1  @ %p\n", bs0 + 1);
    printf("\n");

    short shorts[] = {1, 1, 1, 0, 0, 0};
    short* sh0 = &(shorts[0]);
    short* sh1 = &(shorts[1]);
    
    printf("shorts[0] @ %p\n", sh0);
    printf("shorts[1] @ %p\n", sh1);
    printf("[0] + 1   @ %p\n", sh0 + 1);
    printf("\n");


    char* sch = (char*) &(shorts[0]);

    printf("bytes of short 1:\n");
    printf("byte 0 = %d\n", sch[0]);
    printf("byte 1 = %d\n", sch[1]);
    printf("\n");
           
    int ione = 1;
    char* ich = (char*) &ione;

    printf("bytes of int 1:\n");
    printf("byte 0 = %d\n", ich[0]);
    printf("byte 1 = %d\n", ich[1]);
    printf("byte 2 = %d\n", ich[2]);
    printf("byte 3 = %d\n", ich[3]);

    int aa = 37;
    short *saa = (short*) &aa;
    char  *caa = (char*) saa;
    printf("\n");

    printf("Why little endian?\n");
    printf("int aa = 37\n");
    printf("\n");
    printf("Memory as an int: %d\n", aa);
    printf("Memory as a short: %d\n", *saa);
    printf("Memory as a char: %d\n", *caa);
    printf("\n");

    long longs[] = {1, 2, 3, 4};

    pair* pairs = (pair*) longs;

    pair yy = *(pairs + 1);
    printf("yy.bb = %ld\n", yy.bb);
    
    return 0;
}
```

Then we'll keep working on yesterday's example.
