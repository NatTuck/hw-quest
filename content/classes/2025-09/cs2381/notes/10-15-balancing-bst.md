---
title: "cs2381 Notes: 10-12 Balancing a BST"
date: "2025-10-12"
---

**Balancing a Binary Search Tree**

Review:

- A tree of n items is balanced if its height is O(log n)
- Alt: For some constant k, the longest path from root to leaf will
  always be no more than k times as long as the shortest path.
- We can easily get an unbalanced tree by inserting items in order.
  Thats bad because operations on the tree will then be O(n).

AVL Tree:

- [MIT Slides](
   https://homework.quest/classes/2023-09/cs2381/files/mit-6.006-sp110-lec04.pdf)
- Viz: <https://www.cs.usfca.edu/~galles/visualization/AVLtree.html>

Red-Black Tree:

- Viz: <https://www.cs.usfca.edu/~galles/visualization/RedBlack.html>

**Scapegoat Tree**

- [Paper](http://people.csail.mit.edu/rivest/pubs/GR93.pdf)

Plan:

- We start with a simple unbalanced BST structure.
- At the root of the tree, we store two extra values: the size of the
  tree and the maximum size this tree has been since the last full
  rebalance.
- On insert and delete, we detect the tree becoming too unbalanced,
  and rebalance a portion of the tree to fix it.

How to detect unbalanced tree?

- For a tree of size n, it's perfectly balanced if no leaf has a depth
  greater than log2(n).
- Let's say it's close enough if no leaf has a depth greater than 2*log(n).
- The only time leaves get deeper is on insertion.
- So when we insert, we keep track of how deep the new node is, and if it's
  deeper than 2*log(n) we say it's too deep and fix it.

```java
double log2(xx) {
    return Math.log(xx) / Math.log(2.0);
}

int maxDepth(nn) {
    return (int)Math.ceil(2.0*log2(nn));
}
```

If a node is too deep, how do we fix it?

- We rebalance a portion of the tree containing that node.
- We can calculate how unbalanced the subtree rooted at a node is by
  comparing the size of its left and right subtrees.
- If ``size(child) / size(node) > 0.7 * maxSize`` or so then that's a good
  candidate for a subtree to rebalance. We call that node the
  scapegoat.

How do we rebalance?

- We rebuild the tree rooted at the scapegoat balanced optimally.
- First we get all the nodes in order.
- Then we take the middle one, that's the new root.
- The left and right subtrees are rooted at the middle of the left
  and right ranges.
- Recursively.

Let's do an example where we insert numbers in order.

- Max depth is ``ceil(2*log(n))``, so a rebalance isn't triggered
  until n = 7 (maxDepth = 6).
- The scapegoat is the node with three descendents on one side (3/4 > 0.7)
- The rebalanced tree is rotated by 1.
- The next rebalance is triggered at n = 9 (maxdepth = 7).
- Again, we rotate by 1.
- Then at n = 9, this time we rebuild back one further.

```
1
 \
  2
   \
    3
     \
      5
     / \
    4   7
       / \
      6   8
           \
            9
             \
              10
```

becomes

```
1
 \
  2
   \
    3
     \
       7
     /   \
    5      9
   / \    / \
  4   7  8  10
```
