---
title: "cs2381 Notes: 18 Queues"
date: "2023-10-09"
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




 - Basic concept
   - Complete tree
   - Balanced (log n height) vs degenerate (O(n) height)
 - Binary heap (min heap)
 - Binary search tree

Sets first?


