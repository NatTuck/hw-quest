---
title: "cs2370 Notes: 07 Lists"
date: "2025-02-10"
---

```
def process(xs: list[int]):
    for xx in xs:
       ... xx ...
```

If we have a list of things, we want to loop through the list and do something with each thing.

```
def mutate_list(xs: list[int]):
    """Change the elements of the list in place."""
    for ii in range(0, len(xs))
        xx = xs[ii]
        xs[ii] = ... xx ...
```

If you need to alter the elements an existing list, this pattern gives you the list indices which are nesisary to do that.

Standard pattern for returning a list

```
def produce() -> list[int]:
    ys = []
    return ys
```

To return a list, we want to first build a list and then return it.

```
def rabbit(xx: int) -> list[int]:
    ys = []
    ys.append(xx)
    return ys
```

Stuff to do:

 - Sum
 - Smallest
 - Differences (list of tuple -> list of int)
 

Register count:

 - (pennies, nickles, dimes, quarters)
