---
title: "cs2381 Notes: 22 BST Code"
date: "2023-10-15"
---

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

Balancing the tree:

**AVL Tree**

 - balanceFactor = Height(rightSubtree) - Height(leftSubtree)
 - balanceFactor <= 1
 - Each node stores balanceFactor
 - Recalculate BF for changed node and parents
 - Rotate to fix
 
**Red-Black Tree**

 - Each node is red or black
 - Leaves are black
 - Every path from node to leaves has the same number of black nodes
 - The height of the tree is no more than 2*log(n).
 - For any node with one child, that child must be red.
 - Rotations  to fix
 
