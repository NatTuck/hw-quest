---
title: "cs2370 Notes: 07 More Lists"
date: "2024-02-04"
---

## Designing a function:

 - Purpose statement
 - Signature (e.g. int -> int)
 - Examples
 - Stub
 - Standard pattern
 - Write the body
 - Asserts

**extra stuff to cover**

 - Logic duplication
   - prompting twice
   - while True / break
 - Truthy and Falsey values


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

Using built-in insert

https://docs.python.org/3/library/stdtypes.html#sequence-types-list-tuple-range

```python
# [number] -> [number]
def sort2(xs):
    ys = []
  
    for xx in xs:
        insert2(ys, xx)
        
    return ys


# [number], number -> None
def insert2(xs, yy):
    ii = 0
    
    while ii < len(ys):
        if xx < ys[ii]:
            ii += 1
        else:
            break
            
    ys.insert(ii, xx)
```


More problems:

 - Given a list of integers and an integer, determine how many times
   the integer appears in the list.
 - Given a list of integers, produce a list showing the number of
   times the list in that position in the input appears in the input.
   Example: [4,4,4,1,1] -> [3,3,3,2,2]
 - Finding prime numbers.
