---
title: "Lecture Notes: 03-27 Prime Sieve"
date: "2026-03-25"
---

## Prime Sieve with Processes and Pipes

Goal: Build a pipeline of processes where each filters out multiples of a prime.

v0: Pipe demo - send numbers through a pipe.

```C
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int
main(int _ac, char* av[])
{
    int n = atoi(av[1]);

    int pp[2];
    pipe(pp);

    if (fork()) {
        close(pp[0]);
        for (int i = 2; i <= n; ++i) {
            write(pp[1], &i, sizeof(i));
        }
        close(pp[1]);
        wait(0);
    }
    else {
        close(pp[1]);
        int num;
        while (read(pp[0], &num, sizeof(num)) > 0) {
            printf("%d\n", num);
        }
    }

    return 0;
}
```

v1: First filter - filter out even numbers.

```C
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

void
filter(int prime, int in_fd)
{
    int num;
    while (read(in_fd, &num, sizeof(num)) > 0) {
        if (num % prime != 0) {
            printf("%d\n", num);
        }
    }
}

int
main(int _ac, char* av[])
{
    int n = atoi(av[1]);

    int pp[2];
    pipe(pp);

    if (fork()) {
        close(pp[0]);
        printf("2\n");
        for (int i = 3; i <= n; ++i) {
            write(pp[1], &i, sizeof(i));
        }
        close(pp[1]);
        wait(0);
    }
    else {
        close(pp[1]);
        filter(2, pp[0]);
    }

    return 0;
}
```

v2: Dynamic pipeline - each filter spawns the next on first survivor.

```C
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

void
filter(int prime, int in_fd)
{
    int num;
    int out_fd = -1;
    int pp[2];

    while (read(in_fd, &num, sizeof(num)) > 0) {
        if (num % prime == 0) continue;

        if (out_fd == -1) {
            printf("%d\n", num);
            pipe(pp);

            if (fork()) {
                close(pp[0]);
                out_fd = pp[1];
            }
            else {
                close(pp[1]);
                filter(num, pp[0]);
                return;
            }
        }
        else {
            write(out_fd, &num, sizeof(num));
        }
    }

    close(in_fd);
    if (out_fd != -1) {
        close(out_fd);
        wait(0);
    }
}

int
main(int _ac, char* av[])
{
    int n = atoi(av[1]);

    int pp[2];
    pipe(pp);

    if (fork()) {
        close(pp[0]);
        printf("2\n");
        for (int i = 3; i <= n; ++i) {
            write(pp[1], &i, sizeof(i));
        }
        close(pp[1]);
        wait(0);
    }
    else {
        close(pp[1]);
        filter(2, pp[0]);
    }

    return 0;
}
```

Notes:

- Draw process diagram as pipeline forms
- Trace through with n=10
- Why close unused pipe ends?
  - Reader needs to get EOF when all writers done
  - Prevents file descriptor leaks
- Why wait in each filter?
  - Prevents zombie processes
  - Pipeline terminates from end back to start
- Compare to sequential sieve - same algorithm, parallel execution
