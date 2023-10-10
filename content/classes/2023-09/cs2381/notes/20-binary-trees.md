---
title: "cs2381 Notes: 20 Binary Trees"
date: "2023-10-10"
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
 - specifically, we're talking about log base 2, log_2(n).
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

## Binary Search Tree

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

