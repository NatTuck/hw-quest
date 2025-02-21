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
int
main(int argc, char* argv[])
{


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
