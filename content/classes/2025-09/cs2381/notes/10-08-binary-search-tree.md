---
title: "cs2381 Notes: 10-06 Build a BST"
date: "2025-10-06"
---

## Binary Search Tree / TreeSet Concept

Draw out a BST on the board. Talk about height vs. N.

## Building a Binary Search Tree

```java
import java.util.function.Consumer;

interface TreeSet<T extends Comparable<T>> {
    public static <U extends Comparable<U>> TreeSet<U> makeEmpty() {
        return new TreeEmpty<U>();
    }

    boolean isEmpty();
    boolean contains(T item);
    TreeSet<T> insert(T item);
    TreeSet<T> remove(T item);
    TreeSet<T> merge(TreeSet<T> other);
    T data();
    TreeSet<T> left();
    TreeSet<T> right();
    void each(Consumer<T> op);
}

record TreeEmpty<T extends Comparable<T>>() implements TreeSet<T> {
    @Override
    public boolean isLeaf() {
        return true;
    }

    @Override
    public boolean contains(T _item) {
        return false;
    }

    @Override
    public TreeSet<T> insert(T item) {
        return new TreeNode<T>(item, this, this);
    }

    @Override
    public TreeSet<T> remove(T item) {
        return this;
    }

    @Override
    public TreeSet<T> merge(BinTree<T> that) {
        return that;
    }

    @Override
    public T data() {
        throw new RuntimeException("leaf");
    }

    @Override
    public TreeSet<T> left() {
        throw new RuntimeException("leaf");
    }

    @Override
    public TreeSet<T> right() {
        throw new RuntimeException("leaf");
    }

    @Override
    public String toString() {
        return ".";
    }
    
    @Override
    public void each(Consumer<T> _op) {
       // do nothing 
    }
}

record TreeNode<T extends Comparable<T>>(T data, TreeSet<T> left, TreeSet<T> right)
        implements TreeSet<T> {
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
    public TreeSet<T> insert(T item) {
        int cmp = item.compareTo(this.data);
        if (cmp == 0) {
            return this;
        }
        if (cmp < 0) {
            return new TreeNode<T>(this.data, this.left.insert(item), this.right);
        }
        else {
            return new TreeNode<T>(this.data, this.left, this.right.insert(item));
        }
    }

    @Override
    public TreeSet<T> remove(T item) {
        int cmp = item.compareTo(this.data);
        if (cmp == 0) {
            return this.left.merge(this.right);
        }
        if (cmp < 0) {
            return new TreeNode<T>(this.data, this.left.remove(item), this.right);
        }
        else {
            return new TreeNode<T>(this.data, this.left, this.right.remove(item));
        }
    }

    @Override
    public TreeSet<T> merge(BinTree<T> that) {
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
    
    @Override
    public void each(Consumer<T> op) {
        this.left().each(op);
        op.accept(this.data());
        this.right().each(op); 
    }
}
```

And try it:

```java
    public static void main(String[] args) {
        var xs = TreeSet.<Integer>makeEmpty();
        xs = xs.insert(5);
        xs = xs.insert(3);
        xs = xs.insert(1);
        xs = xs.insert(4);

        var ys = new ArrayList<Integer>();
        xs.each((xx) -> ys.add(xx));

        System.out.println("" + ys);
    }
```
