---
title: "cs2370 Notes: 16 Sorting Fast"
date: "2025-03-04"
---

Last time:

 - Insertion sort and in-place selection sort.


First, let's get a list of random numbers.

```python
from random import randint

def random_list(nn: int) -> list[int]:
    ys = []
    for ii in range(0, nn):
        ys.append(randint(0, 99))
    return ys
```


This time:

 - Merge sort, following the pattern.
 - In-place quicksort with swaps.

Note how both of these solutions are recursive.

