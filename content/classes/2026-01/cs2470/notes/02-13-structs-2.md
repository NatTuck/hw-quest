---
title: "Lecture Notes: 02-13 More Structs"
date: "2026-02-11"
---

## More Goats

- Talk about stars and arrows.
- Array of goats.
- Herd struct.
  - Fixed size herd.
  - Variable sized herd.
- Can't pass an array to a function.
- Can pass a herd to a function, either fixed or variable sized.

## Linked Lists

If we just had structs and no arrays we could
still program.

Linked lists are sometimes simpler since we can
add an item in actual O(1) time.

Stuff to cover:

- Handling a linked list with a for loop.
- Header files, include guards, modules.
- Include quotes vs angle brackets.
- The concept of "ownership", explicitly.
- Passing a value by reference vs. by value.
- Arrow vs dot in structs.
- The "java" pattern (all refs).
- Memory layouts of different structures.

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

Games example.

```C
typedef struct game {
    char* team1_name;
    int team1_score;
    char* team2_name;
    int team2_score;
} game;

typedef struct season {
    game games[3];
} season;
```

- Plymouth Panthers
- Fitchburg Falcons
- Massachusetts Maritime Buccaneers
- Castleton Spartans
