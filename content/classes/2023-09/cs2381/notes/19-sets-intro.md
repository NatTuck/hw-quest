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

 - contains?
 - union
 - intersection
 - subset?
 - superset?

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
