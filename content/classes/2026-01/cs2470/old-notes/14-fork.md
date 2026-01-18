---
title: "Lecture Notes: 14 Introducing Fork"
date: "2025-03-22"
---

Fork:

```C
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>

int
main(int _ac, char* _av[])
{
    int opid = getpid();
    int opar = getppid();
    int cpid;

    printf("Hi, I'm %d, child of %d\n", opid, opar);

    if ((cpid = fork())) {
        int pid1 = getpid();
        int par1 = getppid();
        printf("Hallo, I'm %d, child of %d\n", pid1, par1);

        int st;
        wait(&st);
        printf("I found the number %d\n", st);
    }
    else {
        int pid2 = getpid();
        int par2 = getppid();
        printf("Ahoy! I'm %d, child of %d\n", pid2, par2);
    }

    return 0;
}
```

Notes:

 - Draw the memory diagram
 - Write down the file table
 - Talk about fork/exec vs. CreateProcess on Windows

Exec:

```C
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>

int
main(int _ac, char* _av[])
{
    int opid = getpid();
    int opar = getppid();
    int cpid;

    printf("Before\n");

    if ((cpid = fork())) {
        printf("During\n");

        int st;
        waitpid(cpid, &st, 0);

        printf("After\n");
    }
    else {
        execlp("echo", "echo", "In", "subprocess", NULL);
        printf("Never get here.\n");
    }

    return 0;
}
```

Redirect stdout

```C
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>

int
main(int _ac, char* _av[])
{
    int cpid;
    if ((cpid = fork())) {
        waitpid(cpid, 0, 0);
        printf("%d: Child done.\n", getpid());
    }
    else {
        int fd = open("/tmp/stdout.txt", O_CREAT | O_APPEND | O_WRONLY, 0644);
        close(1);
        dup(fd);
        close(fd);

        if ((cpid = fork())) {
            waitpid(cpid, 0, 0);
            printf("%d: After exec.\n", getpid());
        }
        else {
            execlp("echo", "echo", "exec'd", "echo", NULL);
        }
    }
    return 0;
}
```

Overflow: mmap

```C
#include <pthread.h>
#include <semaphore.h>
#include <stdatomic.h>
#include <assert.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/mman.h>

int
main(int _ac, char* _av[])
{
    int* shared = mmap(0, 4096, PROT_READ | PROT_WRITE,
                       MAP_SHARED | MAP_ANONYMOUS, -1, 0);

    for (int ii = 0; ii < 10; ++ii) {
        shared[ii] = ii;
    }


    int cpid;
    if ((cpid = fork())) {
        printf("parent: sleep 1\n");
        sleep(1);

        printf("parent: mutating array\n");
        for (int ii = 0; ii < 10; ++ii) {
            shared[ii] = ii * 100;
        }

        waitpid(cpid, 0, 0);
    }
    else {
        printf("child: array content:\n");
        for (int ii = 0; ii < 10; ++ii) {
            printf("%d ", shared[ii]);
        }
        printf("\nchild: sleep 2\n");

        sleep(2);

        printf("child: array content:\n");
        for (int ii = 0; ii < 10; ++ii) {
            printf("%d ", shared[ii]);
        }
        printf("\n");
    }

    munmap(shared, 4096);

    return 0;
}
```
