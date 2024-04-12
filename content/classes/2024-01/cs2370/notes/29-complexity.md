---
title: "cs2370 Notes: 29 Program Complexity"
date: "2024-04-11"
---

**Homework is Up**

 - The webserver assignment didn't come out good enough,
   so you get reading and image manipulation.
   

**The Next Few Weeks**

 - After today, there's 4 weeks in the seemster
   - Bonus Topic 1
   - Bonus Topic 2
   - Last week: Redo and Review
   - Then Final Exam; there will be a sample final


**Today: Computational Complexity**

Last time: recursive Fibonacci

```python
def fib(x):
    if x <= 1:
        return x
        
    return fib(x-1) + fib(x-2)
```

```python
def fibCalls(x):
    if x <= 1:
        return (x, 1)
    
    (y1, c1) = fib(x-1)
    (y2, c1) = fib(x-2)
    return (y1 + y2, c1 + c2 + 1)
```


Bounds:

 - ```1, log n, n, n^2, 2^n```
 - Compare bounds functions to fib

More strategies:

 - Iteration
 - Memoization
   - fib is "pure"
   - so memoFib can cheat

More tasks:

 - Enumrating prime numbers
   - memo with array?
 - Sorting
   - bogo-sort
   - insertion sort
   - merge sort




