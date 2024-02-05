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

