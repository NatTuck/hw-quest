---
title: "cs2381 Notes: 21 Trees, Iterators, and Comparables"
date: "2023-10-15"
---

**Binary Search Tree**

A Binary search tree is tree with the items in sorted order.
Specifically, in order such that an in-order traversal will visit the
items in sorted order.

That gives the following invariant:

 - All items in the left subtree are less than item.
 - All items in right subtree are more than item.

That's useful because it lets us find an item by value in O(h)
operations. We can start at the root, and at every step we know which
way to go to find our item.

We know that the minimum height of a tree is (log n) if it's close to
being a complete tree. A tree with height O(log n) is called a balanced tree.

Balanced binary search trees are really useful, because they
conceptually allow insert, lookup, and delete operations in O(log n).

**Iterators**

```java
    public static void main(String[] args) {
        int[] xs = {1, 2, 3, 4};

        for (var xx : xs) {
            System.out.println("" + 2*xx);
        }
        
        var ys = ConsList.list(3, 6, 9, 12);
        
        for (var yy : ys) {
            System.out.println("" + 2*yy);
        }
    }
```

```java
class ArrayWrap<T> implements Iterable<T> {
    T[] data;
    int length; 
    
    ArrayWrap() {
       this.data = (T[]) new Object[10];
       this.length = 0;
    }
    
    void push(T xx) {
       this.data[this.length] = xx;
       this.length += 1;
    }
    
    void get(int ii) {
       return this.data[ii]; 
    }
}

class AwIterator<T> implements Iterator<T> {
    ArrayWrap<T> xs;
    int ii; 
   
    AwIterator(ArrayWrap<T> xs) {
       this.xs = xs;
       this.ii = 0;
    }
    
    @Override
    public boolean hasNext() {
       return ii < xs.length();
    }
    
    @Override
    public T next() {
       return xs.get(ii++); 
    }
}
```

```java
class ConsList<T> implements Iterable<T> {
    ...
    
    @Override
    public Iterator<T> iterator() {
       return new ConsIterator(this); 
    }
}

class ConsIterator<T> implements Iterator<T> {
    ConsList<T> curr;

    ConsSetIterator(ConsSet<T> xs) {
        this.curr = xs;
    }

    @Override
    public boolean hasNext() {
        return !this.curr.isEmpty();
    }

    @Override
    public T next() {
        T item = this.curr.first();
        this.curr = this.curr.rest();
        return item;
    }
}
```

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

**Building a Binary Search Tree**

```java
interface BinTree<T extends Comparable<T>> {
    public static <U extends Comparable<U>> BinTree<U> makeEmpty() {
        return new BinLeaf<U>();
    }

    boolean isLeaf();
    boolean contains(T item);
    BinTree<T> insert(T item);
    BinTree<T> remove(T item);
    BinTree<T> merge(BinTree<T> other);
    T data();
    BinTree<T> left();
    BinTree<T> right();
}

record BinLeaf<T extends Comparable<T>>() implements BinTree<T> {
    @Override
    public boolean isLeaf() {
        return true;
    }

    @Override
    public boolean contains(T _item) {
        return false;
    }

    @Override
    public BinTree<T> insert(T item) {
        return new BinBranch<T>(item, this, this);
    }

    @Override
    public BinTree<T> remove(T item) {
        return this;
    }

    @Override
    public BinTree<T> merge(BinTree<T> that) {
        return that;
    }

    @Override
    public T data() {
        throw new RuntimeException("leaf");
    }

    @Override
    public BinTree<T> left() {
        throw new RuntimeException("leaf");
    }

    @Override
    public BinTree<T> right() {
        throw new RuntimeException("leaf");
    }

    @Override
    public String toString() {
        return ".";
    }
}

record BinBranch<T extends Comparable<T>>(T data, BinTree<T> left, BinTree<T> right)
        implements BinTree<T> {
    @Override
    public boolean isLeaf() {
        return false;
    }

    @Override
    public boolean contains(T item) {
        int cmp = item.compareTo(this.data);
        if (cmp == 0) {
            return true;
        }
        if (cmp < 0) {
            return this.left.contains(item);
        }
        else {
            return this.right.contains(item);
        }
    }

    @Override
    public BinTree<T> insert(T item) {
        int cmp = item.compareTo(this.data);
        if (cmp == 0) {
            return this;
        }
        if (cmp < 0) {
            return new BinBranch<T>(this.data, this.left.insert(item), this.right);
        }
        else {
            return new BinBranch<T>(this.data, this.left, this.right.insert(item));
        }
    }

    @Override
    public BinTree<T> remove(T item) {
        int cmp = item.compareTo(this.data);
        if (cmp == 0) {
            return this.left.merge(this.right);
        }
        if (cmp < 0) {
            return new BinBranch<T>(this.data, this.left.remove(item), this.right);
        }
        else {
            return new BinBranch<T>(this.data, this.left, this.right.remove(item));
        }
    }

    @Override
    public BinTree<T> merge(BinTree<T> that) {
        if (that.isLeaf()) {
            return this;
        }

        return this.insert(that.data())
            .merge(that.left())
            .merge(that.right());
    }

    @Override
    public String toString() {
        if (this.left.isLeaf() && this.right.isLeaf()) {
            return this.data.toString();
        }

        var sb = new StringBuilder();
        sb.append("(");
        sb.append(this.left.toString());
        sb.append(" ");
        sb.append(this.data.toString());
        sb.append(" ");
        sb.append(this.right.toString());
        sb.append(")");
        return sb.toString();
    }
}
```
