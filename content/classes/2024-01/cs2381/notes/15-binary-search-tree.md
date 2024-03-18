---
title: "cs2381 Notes: 15 Binary Search Trees"
date: "2024-03-18"
---

**Binary Trees**

We've looked at singly linked lists (ConsList). Each cell in a
ConsList has a reference to one other cell. This produces a sequence
of nodes.

What if we have nodes with more than one reference to other nodes?

The general case of this is a structure called a graph.

(Draw some graphs.)

Arbitrary graphs can be useful, but they take some effort to deal
with. Minimally, graphs can have cycles, which means that just trying
to do a simple traverasal can lead to an infinite loop.

A ConsList is the simplest example of a class of useful structures:
trees. 

Trees are:

 - graphs
 - with a single root
 - with no cycles

A simple, commonly used tree is the Binary Tree, where each node has
(up to) two references to other nodes.

## Binary Trees

Without getting more specific, there are some things we can say about binary trees:

 - There's one root.
 - Each node has two references to other nodes, those nodes are its "children".
 - That means every non-root node has one parent.
 - Nodes with children are branches.
 - Nodes without children are leaves.
 - The height of a tree is the maximum length of a path from the root to a leaf.

The maximum height of a tree with n items is n.

The minimum height of a tree with n items is log(n).

What's a log?

 - Inverse of exponent
 - specifically, we're talking about log base 2, log\_2(n).
 - How many digits do we need to represent the number (base 2, so binary digits).
 - This grows very slowly. O(log(n)) is much more efficient than O(n).

One kind of minimum height tree is called a complete tree:
 
 - All of the levels are full.
 - Except maybe the last level, which is only missing items on the right.
 
In CS, trees grow down.

At each level, numbering from zero, there's space for 2^x items.

So a full tree of height h has 2^h items on the bottom level, 2^(h-1) on the
previous level, etc for a total of 2^(h+1) - 1 items.

## Tree Traversals

Commonly, we store values in trees by having each node have an
associated value.

That gives us some questions on how to traverse the tree and visit the
values.

 - Pre-order: Visit node before children.
 - Post-order: Visit node after children.
 - In-order: Visit node between left and right trees.


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


**Building a Binary Search Tree**

```java
import java.util.function.Consumer;

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
    void each(Consumer<T> op);
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
    
    @Override
    public void each(Consumer<T> _op) {
       // do nothing 
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
        var xs = BinTree.<Integer>makeEmpty();
        xs = xs.insert(5);
        xs = xs.insert(3);
        xs = xs.insert(1);
        xs = xs.insert(4);

        var ys = new ArrayList<Integer>();
        xs.each((xx) -> ys.add(xx));

        System.out.println("" + ys);
    }
```

