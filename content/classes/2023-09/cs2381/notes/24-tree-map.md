---
title: "cs2381 Notes: 24 Tree Map"
date: "2023-10-22"
---

Most modern high level programming languages provide two built-in data
structures to deal with collections of values: a way to store a
sequence of values, and the way to store values associated with keys.

In Python, you should remember these two things as Arrays and
Dictionaries.

We already saw the two most common sequence types: ArrayLists (like
Python Arrays) and singly linked lists, which are the standard
sequence type in most functional languages.

Today we'll get our first data structure for storing values by an
arbitrary key. Generically, these structures are called Maps. There
are two common implementations of maps: with Binary Search Trees -
which we'll look at this week, and with Hash Tables, which we'll look
at next. Python dictionaries are Hash Tables.


**Simplest Idea: Association List**

```java
// below class TreeMap

record Entry<K extends Comparable<K>, V>(K key, V val) {
    // empty
}
```

So then a map can just be ```ConsList<Entry<K, V>>```.

Only one problem: Just like with a ConsSet, every operation is O(n).
It'd be nice to do it in O(log n).


**Tree Set to Tree Map**

We almost just want to do ```BinTree<Entry<K, V>>```, except for two
main things:

 - The tree traversal logic needs to do comparisons only on key,
   and we don't want to add a fake compareTo to Entry.
 - We need a "get" method.

Update map class:

```java
public class TreeMap<K extends Comparable<K>, V> {
    BinNode<K, V> root;
    
    boolean hasKey(K key) {
        return root.hasKey(key);
    }
    
    void insert(K key, V val) {
        delete(key);
        ...     
        this.root = this.root.insert(key, val);
        this.size += 1;
        ...
    }
    
    V get(K key) {
        return root.get(key);
    }
    
    void eachEntry(Consumer<Entry<K, V>> op) {
        root.eachEntry(op);
    }
```

And Node interface:

```java
interface BinNode<K extends Comparable<K>, V> {
    boolean isLeaf();

    boolean hasKey(K key);

    BinNode<K, V> insert(K key, V val);

    BinNode<K, V> delete(K key);

    BinNode<K, V> merge(BinNode<K, V> other);

    Entry<K, V> data();

    BinNode<K, V> left();

    BinNode<K, V> right();

    int size();

    int height();

    void each(Consumer<Entry<K, V>> op);

    default ArrayList<Entry<K, V>> toList() {
        var ys = new ArrayList<Entry<K, V>>();
        this.each((xx) -> ys.add(xx));
        return ys;
    }
}
```

And leaf:

```java
record BinLeaf<K extends Comparable<K>, V>() implements BinNode<K, V> {
    ...
    @Override
    public boolean hasKey(K _key) {
        return false;
    }
    
    @Override
    public BinNode<K, V> insert(K key, V val) {
        return new BinBranch<K, V>(new Entry<K, V>(key, val), this, this);
    }
    
    @Override
    public void eachEntry(Consumer<Entry<K, V> op) {
        // do nothing
    }
```

And branch:

```java
record BinBranch<K extends Comparable<T>, V>(
            Entry<K, V> data, BinNode<K, V> left, BinNode<K, V> right)
        implements BinNode<K, V> {

    @Override
    public boolean hasKey(K key) {
        int cmp = key.compareTo(this.data.key());
        if (cmp == 0) {
            return true;
        }
        if (cmp < 0) {
            return this.left.contains(key);
        }
        else {
            return this.right.contains(key);
        }
    }
    
    @Override
    public BinNode<T> insert(K key, V val) {
        int cmp = key.compareTo(this.data.key());
        if (cmp == 0) {
            var ent = new Entry<K, V>(key, val);
            return new BinBranch<K, V>(ent, this.left, this.right);
        }
        if (cmp < 0) {
            return new BinBranch<K, V>(this.data,
                                       this.left.insert(item), this.right);
        }
        else {
            return new BinBranch<K, V>(this.data,
                                       this.left, this.right.insert(item));
        }
    }
    
    @Override
    public V get(K key) {
        int cmp = key.compareTo(this.data.key());
        if (cmp == 0) {
            return this.data.value();
        }
        if (cmp < 0) {
            return this.left.get(key);
        }
        else {
            return this.right.get(key);
        }
    }

    @Override
    public BinNode<K, V> delete(K key) {
        int cmp = item.compareTo(this.data.key());
        ...
    }
   
    @Override
    public String toString() {
   
        ...
        sb.append(" [");
        sb.append(this.data.key());
        sb.append(" => ");
        sb.append(this.data.val());
        ... 
```

