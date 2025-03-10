---
title: "Lecture Notes: 12 Slice Demo"
date: "2025-03-09"
---

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
scons(slice item, scell* next)
{
    scell* xs = malloc(sizeof(scell));
    xs->item = item;
    xs->next = next;
    return xs;
}

void
sfree(scell* xs)
{
    if (xs) {
        sfree(xs->next);
        free(xs);
    }
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

long
file_size(const char* path)
{
    struct stat sb; // stack allocated
    int rv = stat(path, &sb); // out parameter
    assert(rv != -1);
    
    // man stat
    // man 3type stat
    return sb.st_size; // dot field access
}

scell*
split_lines(const char* data, long size)
{
    scell* ys = 0;

    long start = 0;
    for (long ii = 0; ii < size; ++ii) {
        if (data[ii] == '\n') {
            slice sl;
            sl.ptr = data + start;
            sl.len = (int) ii - start;
            ys = scons(sl, ys);
            start = ii + 1;
        }
    }

    return reverse(ys);
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
    if (argc != 2) {
        fprintf(stderr, "expected input file.\n");
        return 1;
    }

    const char* path = argv[1];
    long sz = file_size(path);

    char* data = malloc(sz);

    FILE* fh = fopen(path, "r");
    assert(fh != 0);
    
    int count = 0;
    while (count < sz) {
        int rv = fread(data + count, 1, sz - count, fh);
        assert(fh != 0);
        count += rv;
    }

    fclose(fh);


    scell* lines = split_lines(data, sz);
    print_words(lines);

    delete_str(&lines, "exhumed");
    delete_str(&lines, "Romanov");
    delete_str(&lines, "teapot's"); // first item

    printf("\n\n");
    print_words(lines);

    sfree(lines);

    free(data);
    return 0;
}
```
