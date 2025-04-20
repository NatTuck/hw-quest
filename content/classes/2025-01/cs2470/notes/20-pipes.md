---
title: "Lecture Notes: 20 Pipes"
date: "2025-04-17"
---

## Shell Operators

Demonstrate each of these in a shell:

 - Redirect input: sort < foo.txt
 - Redirect output: sort foo.txt > output.txt
 - Pipe: sort foo.txt | uniq
   - man 2 pipe
 - Background: sleep 10 &
 - And: true && echo one
   - Return value from main
   - Success (rv = 0) is true
   - Return val of last command in $?
 - Or: true || echo one
 - Semicolon: echo one; echo two

## Redirect Example

 - redir.c

## Pipe Examples

 - pipe0, pipe1
 - sort-pipe

## Shell Evaluation Plan

 - Base case: "command arg1 arg2"
   - fork
   - in child: exec(command, arg1, arg2)
   - in parent: wait on child
 - Semicolon: "command1; command2"
   - split token list on semicolon
   - execute command1 (recursively)
   - execute command2 (recursively)
 - And / Or: "command1 OP command2"
   - split token list on operator
   - execute command1 (recursively)
   - wait for exit code
   - if correct exit code: execute command2 (recursively)
 - Background
   - fork
   - in child: execute command (recursively)
   - in parent:
     - don't wait right away
     - if you wait in the future, keep in mind it may be the
       background job
     - you should wait at some point to avoid zombies.
 - Redirect: "command OP file" 
   - fork
   - in child: change the file descriptor table to accomplish the redirect
   - in child: execute command (recursively)
   - in parent: wait on child
 - Pipe: "command1 | command 2"
   - fork
   - in child:
     - pipe syscall
     - fork
     - in child/child: hook pipe to stdout, close other side
     - in child/child: execute command1 (r)
     - in child/parent: hook pipe to stdin, close other side
     - in child/parent: execute command2 (r)
     - in child/parent: wait on child/child
   - in parent: wait on child

Demo #1:

```C
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

void
check_rv(int rv)
{
    if (rv == -1) {
        perror("fail");
        exit(1);
    }
}

int
main(int _ac, char* _av[])
{
    int rv;
    char msg[] = "Hello, pipe.\n";
    
    int pipe_fds[2];
    rv = pipe(pipe_fds);
    check_rv(rv);
   
    int p_read  = pipe_fds[0];
    int p_write = pipe_fds[1];

    rv = write(p_write, msg, strlen(msg));
    check_rv(rv);

    char temp[100];
    rv = read(p_read, temp, 100);
    check_rv(rv);
    temp[rv] = 0;

    rv = write(1, temp, strlen(temp));
    check_rv(rv);

    return 0;
}
```

Demo #2:

```C
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

void
check_rv(int rv)
{
    if (rv == -1) {
        perror("fail");
        exit(1);
    }
}

int
main(int _ac, char* _av[])
{
    int rv;
    
    int pipe_fds[2];
    rv = pipe(pipe_fds);
    check_rv(rv);
  
    int p_read  = pipe_fds[0];
    int p_write = pipe_fds[1];
    int cpid;

    if ((cpid = fork())) {
        if (cpid == -1) {
            perror("fork");
            return -1;
        }

        // In the parent.
        close(p_read);
        printf("Parent pid = %d, child pid = %d\n", getpid(), cpid);

        char msg[] = "Hello, pipe.\n";

        rv = write(p_write, msg, strlen(msg));
        check_rv(rv);
    }
    else {
        // In the child
        close(p_write);
        printf("Child pid = %d, parent pid = %d\n", getpid(), getppid());

        char temp[100];
        rv = read(p_read, temp, 100);
        check_rv(rv);
        temp[rv] = 0;

        rv = write(1, temp, strlen(temp));
        check_rv(rv);
    }

    return 0;
}
```

Demo #3:

https://github.com/NatTuck/ntuck-neu/tree/master/content/2021-01/cs3650/notes/10-fork/sort-pipe
