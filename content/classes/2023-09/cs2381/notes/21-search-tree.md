---
title: "cs2381 Notes: 21 Binary Search Trees"
date: "2023-10-10"
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

