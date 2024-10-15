---
title: "cs2381 Notes: 22 Build a BST"
date: "2024-10-15"
---

**Building a Binary Search Tree**

```java
import java.util.function.Consumer;


// BST merge
    @Override
    public BinTree<T> merge(BinTree<T> that) {
        return that;
    }

// Foreach
    @Override
    public void each(Consumer<T> _op) {
       // do nothing 
    }
}

// Improved remove
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

// Foreach
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


Once we finish out the BST as a set, let's move on to looking at 

 - ALists
 - TreeMap

```java
public record AssocList<K, V>(ConsList<Pair<K, V>> data) {
    // methods
}

record Pair<K, V>(K key, V val) {
    // pass
}
```
