---
title: "Lecture Notes: 02-20 Debugging Slices"
date: "2026-02-18"
---

```bash
$ man gdb
$ gdb
(gdb) help info
(gdb) help info frame
(gdb) help break
(gdb) help step # step into function
(gdb) help next # don't step into function
```

```C
#include <stdio.h>
#include <sys/stat.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>


typedef struct slice {
    const char* ptr;
    int len;
} slice;

typedef struct scell {
    slice item;
    struct scell* next;
} scell;

slice
to_slice(const char* text)
{
    slice yy;
    yy.ptr = text;
    yy.len = strlen(text);
    return yy;
}

int
sleq(slice aa, slice bb)
{
    if (aa.len != bb.len) {
        return 0;
    }

    for (int ii = 0; ii < aa.len; ++ii) {
        if (aa.ptr[ii] != bb.ptr[ii]) {
            return 0;
        }
    }

    return 1;
}

scell*
reverse1(scell* xs, scell* ys)
{
    if (xs == 0) {
        return ys;
    }

    scell* tmp = xs->next;
    xs->next = ys;
    return reverse1(tmp, xs);
}

scell*
reverse(scell* xs)
{
    return reverse1(xs, 0);
}

void
delete_slice(scell** xsp, slice word)
{
    scell* xs = *xsp;

    if (xs == 0) {
        return;
    }

    if (sleq(xs->item, word)) {
        *xsp = xs->next;
        xs->next = 0;
        sfree(xs);
    }

    delete_slice(&(xs->next), word);
}

void
delete_str(scell** xsp, const char* word)
{
    delete_slice(xsp, to_slice(word));
}

void
print_words(scell* xs)
{
    for (; xs; xs = xs->next) {
        printf("%.*s\n", xs->item.len, xs->item.ptr);
    }
}

int
main(int argc, char* argv[])
{
    // ...
    delete_str(&lines, "exhumed");
    delete_str(&lines, "Romanov");
    delete_str(&lines, "teapot's"); // first item
    // ...

    return 0;
}
```
