---
title: "cs2370 Notes: 06 Design With Lists"
date: "2024-02-01"
---

## Designing a function:

 - Purpose statement
 - Signature (e.g. int -> int)
 - Examples
 - Stub
 - Standard pattern
 - Write the body
 - Asserts


**Designing a None function**

Print a square of a given size with "+-|" characters.

Signature: int -> None

```python
# Print a square with interior size as provided
def print_square(size):
    print "+" + (size * "-") + "+"
    for ii in range(0, size):
        print "|" + (size * " ") + "|"
    print "+" + (size * "-") + "+"
```


**Lists**

A list in Python is the standard way of handling a sequence of 0 or
more items.

Basic operations:

 - for / in loop
 - Indexing
 - Slicing
 - .append
 - concat with +


**max_val**

Design a function that finds the maximum value in a list.

Standard pattern:

```python
# [number] -> number
def max_val(xs):
    y = 0
    
    for x in xs:
        pass
        
    return y
```

Problem: Negative numbers, solution: xs[0]

Problem: Empty list, solutions:

 - None
 - Throw


**contains**

Design a function that determines if an integer appears in a list.

Standard pattern:

```python
# [int], int -> bool
def contains(xs, y):
    for x in xs:
        ... something with y... 
    return True # or False
```


**add1\_to_all**

```python
# [number] -> [number]
def add1_to_all(xs):
    ys = []
    for x in xs:
        ys.append(x + 1)
    return ys
```


```python
# [number] -> None
def add1_to_each(xs):
    for ii in range(0, len(xs)):
        xs[ii] = 
```


**insertion sort**

Pattern gives us:

```python
# [number] -> [number]
def sort(xs):
    ys = []
    
    for x in xs:
        ys = insert(ys, x)

    return ys

# We need a helper

# [number], number -> [number]
def insert(xs, y):
    lt = []
    gt = []
   
    for x in xs:
        if x <= y:
            lt.append(x)
        elif x > y:
            gt.append(x)
    
    return lt + [y] + gt
```
