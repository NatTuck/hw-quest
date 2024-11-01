---
title: "cs2381 Notes: 29 Priority Queues"
date: "2024-10-31"
---

A queue is typically FIFO - first in first out.

But what if some items in the queue are more important
than other items?

We want a priority queue:

 - Insert (item, priority)
   - Or there's some function of item that gives priority.
 - Highest priority items come out first
 - Equal priority items are FIFO.

Applications:

 - Lines at Disney World
 - Network Routers
 - Dijkstra's / A*
 - OS Scheduling

# How to Make Priority Queue

**Operations**

 - Insert
 - Take next

**Structure Options**

 - List of (priority, item)
   - Insert: O(n), maintain sorted order
   - Next: O(1)
 - Binary tree ordered by priority.
   - Insert: O(log n)
   - Next: O(log n)
 - Heap
   - Complete binary tree
   - Min heap property: Parent is smaller than either child.
   - Insert: O(log n)
   - Next: O(log n)

Array mapped heap:

 - xs[0] is root
 - For index ii, children are (2\*ii+1) and (2\*ii+2)
 - Draw this out.

Insertion:

 - Insert at end.
 - Compare to parent, maybe swap, recurse.

Removal:

 - Remove from root.
 - Move in last item.
 - Compare to both children, swapping down until heap
   property maintained.

Expected time for insertion:

 - Expected O(1) for random insertions
 - Argument: Half of the items are leaves, these tend to the largest half.
 - So if we insert random items in random order, we need to do 1 swap 50% of the time.
 - Same argument, two swaps 25% of the time.
 - k swaps 1/(2^k) of the time.

Alternate heaps:

 - There are some more complex heap structures that offer worse case
   O(1) insertion.

