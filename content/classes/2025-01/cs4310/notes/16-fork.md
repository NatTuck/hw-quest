---
title: "Lecture Notes: 16 Fork"
date: "2025-02-26"
---


Fork and Exec

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

Shared memory

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

Sum101

```C
#include <stdio.h>
#include <assert.h>

// A billion.
const long TOP = 1000000000;

int
main(int _ac, char* _av[])
{
    printf("Summing numbers divisible by 101 from 0 to %ld.\n", TOP - 1);

    long sum = 0;
    for (long ii = 0; ii < TOP; ++ii) {
        if (ii % 101 == 0) {
            sum += ii;
        }
    }

    printf("Sum = %ld\n", sum);
    return 0;
}
```

Parallel version

```C
#include <stdio.h>
#include <assert.h>

#include <sys/mman.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int
main(int _ac, char* _av[])
{
    // A billion.
    const long TOP = 1000000000;
    const long NPP = TOP / 10;

    printf("Summing numbers divisible by 101 from 0 to %ld.\n", TOP - 1);

    long* sum = mmap(0, sizeof(long), PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0);

    pid_t kids[10];

    for (int pp = 0; pp < 10; ++pp) {
        if ((kids[pp] = fork())) {
            // do nothing
        }
        else {
            int i0 = NPP*pp;
            int iN = NPP*pp + NPP;

            for (int ii = i0; ii < iN; ++ii) {
                if (ii % 101 == 0) {
                    *sum += ii;
                }
            }

            munmap(sum, sizeof(long));
            exit(0);
        }
    }

    for (long pp = 0; pp < 10; ++pp) {
        waitpid(kids[pp], 0, 0);
    }

    printf("Sum = %ld\n", *sum);

    munmap(sum, sizeof(long));
    return 0;
}
```

Add a lock:

```C
#include <stdio.h>
#include <assert.h>
#include <sys/mman.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#include <semaphore.h>

void*
malloc_shared(size_t size)
{
    return mmap(0, size, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0);
}

void
free_shared(void* ptr, size_t size)
{
    munmap(ptr, size);
}

int
main(int _ac, char* _av[])
{
    // A billion.
    const long TOP = 1000000000;
    const long NPP = TOP / 10;

    printf("Summing numbers divisible by 101 from 0 to %ld.\n", TOP - 1);

    long* sum = malloc_shared(sizeof(long));

    sem_t* lock = malloc_shared(sizeof(sem_t));
    sem_init(lock, 1, 1);
    // Semaphores?

    pid_t kids[10];

    for (int pp = 0; pp < 10; ++pp) {
        if ((kids[pp] = fork())) {
            // do nothing
        }
        else {
            int i0 = NPP*pp;
            int iN = NPP*pp + NPP;

            for (int ii = i0; ii < iN; ++ii) {
                // try wait here
                if (ii % 101 == 0) {
                    sem_wait(lock);
                    *sum += ii;
                    sem_post(lock);
                }
                // and post here
            }

            free_shared(sum, sizeof(long));
            free_shared(lock, sizeof(sem_t));
            exit(0);
        }
    }

    for (long pp = 0; pp < 10; ++pp) {
        waitpid(kids[pp], 0, 0);
    }

    printf("Sum = %ld\n", *sum);

    free_shared(sum, sizeof(long));
    free_shared(lock, sizeof(sem_t));
    return 0;
}
```

Real work

```C
#include <stdio.h>
#include <assert.h>
#include <sys/mman.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#include <semaphore.h>

void*
malloc_shared(size_t size)
{
    return mmap(0, size, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0);
}

void
free_shared(void* ptr, size_t size)
{
    munmap(ptr, size);
}

int
main(int _ac, char* _av[])
{
    sem_t* locks = malloc_shared(2 * sizeof(sem_t));
    sem_t* aa = &(locks[0]);
    sem_t* bb = &(locks[1]);

    sem_init(aa, 1, 1);
    sem_init(bb, 1, 1);

    int cpid;
    if ((cpid = fork())) {
        printf("In parent\n");

        sem_wait(aa);
        sleep(1);
        sem_wait(bb);

        printf("Doing real work in parent...");

        sem_post(bb);
        sem_post(aa);

        waitpid(cpid, 0, 0);
    }
    else {
        printf("In child\n");

        sem_wait(bb);
        sleep(1);
        sem_wait(aa);

        printf("Doing real work in child...\n");

        sem_post(bb);
        sem_post(aa);
    }

    free_shared(locks, sizeof(long));
    return 0;
}
```


