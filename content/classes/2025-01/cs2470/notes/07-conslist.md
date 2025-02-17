---
title: "Lecture Notes: 07 Linked Lists"
date: "2025-02-16"
---


```C

#include <stdio.h>
#include <stdlib.h>

typedef struct cons_cell {
  int head;
  struct cons_cell* tail;
} cons_cell;

cons_cell* empty = (cons_cell*) 0;

cons_cell*
cons(int xx, cons_cell* ys)
{
  cons_cell* cell = malloc(sizeof(cons_cell));
  cell->head = xx;
  cell->tail = ys;
  return cell;
}

void
list_free(cons_cell* xs)
{
  if (xs) {
    list_free(xs->tail);
    free(xs);
  }
}

int
main(int argc, char* argv[])
{
  cons_cell* xs = empty;
  for (int ii = 0; ii < 10; ++ii) {
    xs = cons(ii, xs);
  }

  cons_cell* ys = xs;
  for (int ii = 0; ii < 5; ++ii) {
    ys = ys->tail;
  }

  ys = cons(35, ys);

  printf("\nfirst list:\n");
  for (cons_cell* it = xs; it; it = it->tail) {
    printf("%d\n", it->head);
  }

  printf("\n2nd list:\n");
  for (cons_cell* it = ys; it; it = it->tail) {
    printf("%d\n", it->head);
  }

  list_free(xs);
  free(ys);

  return 0;
}
```


More to do:

 - Recursive vs. iterative sum
 - Print out local variable addresses during recursion
