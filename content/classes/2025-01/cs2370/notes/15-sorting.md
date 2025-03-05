---
title: "cs2370 Notes: 15 Sorting"
date: "2025-02-25"
---

Topics:

 - Asymptotic complexity
 - List indexing
 - Sorting
 - In-place vs. pure sorts


First, let's get a list of random numbers.

```python
from random import randint

def random_list(nn: int) -> list[int]:
    ys = []
    for ii in range(0, nn):
        ys.append(randint(0, 99))
    return ys
```

Insertion sort.

```python
def isort(xs):
    ys = []
    for x in xs:
        ys = insert(ys, x)
    return ys

def insert(xs, y):
    ys = 
```


Selection sort with swaps.

 - Invariant: First part is sorted.
 - Find higest in second part, swap with first.


Merge sort.



Quicksort with swaps.


