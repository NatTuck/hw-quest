---
title: "Lecture Notes: 09 GDB Basics"
date: "2025-02-20"
---

https://cs.brown.edu/courses/cs033/docs/guides/gdb.pdf

```bash
$ man gdb
$ gdb
(gdb) help info
(gdb) help info frame
```


```C
typedef struct cell {
    int head;
    struct cell* tail;
} cell;

cell*
cons(int hd, cell* tl)
{
    cell* xs = malloc(sizeof(cell));
    xs->head = hd;
    xs->tail = tl;
    return xs;
}

int
sum(cell* xs)
{
    if (xs) {
       return xs->head + sum(xs->tail);
    }
    else {
        return 0;
    }
}

int
main(int argc, char* argv[])
{
    cell* xs = cons(10, cons(20, cons(30, cons(40, cons(50, 60)))));
    printf("%d\n", sum(xs));
    return 0;
}
```


 - Running a program with GDB.
 - Passing in command line arguments.
   - Interactive (run [args])
   - The ```--args``` flag.
 - Set breakpoint with 'break'
   - Continue with 'c'
 - Print backtrace with 'bt'
   - Pick a frame with 'frame'
 - Print a value with 'print expr'
 - 'next' (don't enter fucntion calls)
 - 'step' (step into any function calls)
 - 'list' (see where we are in context)


Next meeting: A lab assignment.
