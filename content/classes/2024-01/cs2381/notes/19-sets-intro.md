---
title: "cs2381 Notes: 19 Intro to Sets"
date: "2024-03-14"
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

With an ConsList or unsorted ArrayList, everything is O(n).

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
   
 **Comparable**

```java
import java.util.Arrays;

    public static void main(String[] args) {
        int[] xs = {3, 2, 5, 4};
        
        for (var xx : xs) {
            System.out.println("" + xx);
        }
        
        Arrays.sort(xs);
        
        for (var xx : xs) {
            System.out.println("" + xx);
        }

        Dog[] ys = {new Dog("Bb"), new Dog("Aa"), new Dog("Cc")};
        
        ...
}

record Dog(String name) implements Comparable<Dog> {
    @Override
    public int compareTo(Dog that) {
        return this.name.compareTo(that.name);
    }
}
```

Now let's actually build the sorted ArraySet.

Let's review adding an iterator (```implements Iterable<T>```).


**Dictionaries / Maps**

Frequently we want to store values associated with keys.

Simple examples:

 - Phone book maps Name to Phone #.
 - DNS servers map domain names to IP addresses 

Interface:


```java
interface Map<K, V> {
    void set(K key, V val);
    V get(K key);
    void del(K key);
    int size();
    
    boolean containsKey(K key);
    Set<K> keySet();
}
```

Implementations:


```java
record Entry<K, V>(K key, V val) {
    // pass
}
    
// An assocation list:
// Immutable, so doesn't match our interface above.
ConsList<Entry<K, V>> alist;

class ConsMap<K, V> implements Map<K, V>{
    ConsList<Entry<K, V>> data;
    
    // Operations create a new ConsList, but we hide that
    // as an implementation detail
}

// Just like set, this could be sorted or unsorted.
ArrayList<Entry<K, V>> array_map;
```
