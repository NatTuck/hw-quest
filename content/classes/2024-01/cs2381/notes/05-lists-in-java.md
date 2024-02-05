---
title: "cs2381 Notes: 05 Lists in Java"
date: "2024-02-04"
---

In Python, if you want a sequence of items you usually use a list.

In Java, the same thing is true. But there are multiple usefully
different ways to build a list, so in Java "List" is an interface
that can be implemented by many different classes.

Unlike Python, Java doesn't have simple syntax for List literals. The
List interface itself does have a helper method that constructs an
unmodifiable list if that's what your code needs:


```java
import java.util.List;

    var xs = List.of(1, 2, 3, 4);
    
    // Some read-only methods:
    xs.isEmpty(); // => false
    xs.get(1); // => 2
    xs.size(); // => 4
   
    // Standard pattern for a list:
    for (var xx : xs) {
       // do something with xx 
    }
```

The typical implementation of list is called ArrayList, and the
details of how it works are very similar to Python lists.

```java
import java.util.ArrayList;

    // Standard way to construct an ArrayList.
    var xs = new ArrayList<Integer>();
    
    // Add modifies the list by sticking a new item on the end.
    xs.add(1);
    xs.add(2);
    xs.add(3);
    xs.add(4);
    
    // The other essential method to modify a list:
    xs.set(2, 6);
    
    // Standard pattern for a list:
    for (var xx : xs) {
       // do something with xx 
    }
```

Backfill some concepts:

 - Generics
   - The type checker in Java; things have types, and types propagate in a certain way.
 - Casts
   - Upcast (e.g. ArrayList to List)
   - Downcast (e.g. List to ArrayList)
 - Class variants of primitive types.

Design with lists:

**add1\_to_all**

Write these two in Java:

```python
def add1_to_all(xs):
    ys = []
    for x in xs:
        ys.append(x + 1)
    return ys
```


```python
def add1_to_each(xs):
    for ii in range(0, len(xs)):
        xs[ii] += 1
```


**Introduce Asymtotic Complexity and O notation**

How does the number of operations we need to do in a chunk of code
(e.g. a method) vary with some the size of the input?

We say a method is (or is in) O(f) if the number of operations is
bounded above by a function f of the size of the input times some
constant factor.

Examples:

 - A function that takes a list of size n and completes in no more
   than 23*n operations is O(n).
 - A function that takes a list of size n and completes in no more
   than 85 operations reguardless of the size of the list is O(1).

Figuring this out:

 - We can start by trying to count all the operations.
 - Then throw away any constant factors.
 - O() is trying to find an upper bound, so we don't want to underestimate.
 - Generally we're looking for a tight bound, so while technically correct an
   overestimate isn't the answer we want in this class.
 - We should end up with a simple expression (e.g. O(1), O(n), etc)


**Designing a quadratic function**

Design a static method that takes a list of integers as input and
returns a list where each integer is replaced by the number of times
that integer appers in the list.

Example: [1, 1, 1, 2, 4, 2] => [3, 3, 3, 2, 1, 2]

What is the asymtotic complexity (as O notation) for this method?




**Second Biggest**

Find the second largest integer in a list. How about the k'th.
