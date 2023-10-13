---
title: "cs2381 Notes: 19 Intro to Sets"
date: "2023-10-09"
---

**Sets**

A set is an unordered collection of unique items.

Mathematically, sets can contain any appropriate mathematical objects.

Programmatically, sets are a generic type - we could have a set of
Strings or a set of Animals. Logically, the items should be immutable
values with well defined equality.

```
A = {1, 2, 3}
B = {"apple", "pear", "grape"}
```

Mathemtically, sets have the following operations:

 - contains?(item) - Does the set contain this item?
 - union(set) - All items in either set.
 - intersection(set) - All items occurring in both sets.
 - subset?(setB) - Does this set contain all items in setB?
 - superset?(setB) - Does setB contain all items in this?

(examples)

Programatically, sets generally have these operations:

 - add
 - remove
 - size

And then we have the question of whether a set is an immutable value
or a mutable object. 

If you want to sensibly have a set of sets, then immutable values make
more sense.

```java
interface Set<T> {
    Set<T> add(T item);
    Set<T> remove(T item);
    
    Set<T> union(Set<T> other);
    Set<T> intersection(Set<T> other);
    
    boolean contains(T item);
    boolean subset(Set<T> other);
    boolean superset(Set<T> other);
    
    int size();
}
```

Everything is O(n).

Now let's consider implementing this interface with a sorted ArrayList.

 - Add is O(n)
 - Remove is O(n)
 - Union and intersection can both be done in O(n)
 - Contains is O(n)... unless we do binary search, then it's O(log n)
 - Superset and subset are O(n)
 - Size is O(1)


**Mutable sets?**

```java
interface MutableSet<T> {
    void add(T item);
    void remove(T item);
    
    Set<T> union(Set<T> other);
    Set<T> intersection(Set<T> other);
    
    boolean contains(T item);
    boolean subset(Set<T> other);
    boolean superset(Set<T> other);
    
    int size();
}
```

 - Lists are immutable, so there's no benefit.
 - Arrays are mutable... but for a sorted array there's no benefit
   either.
 - So we'll ignore this for now, but this may end up being useful
   at some point in the future.
