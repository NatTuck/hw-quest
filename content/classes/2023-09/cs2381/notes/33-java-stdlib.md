---
title: "Notes: 32 Deadlock, Cache, etc"
date: "2023-11-14"
---


What have we seen so far in this class:

 - Lists:
   - Singly Linked List (ConsList)
   - ArrayList
 - Stack
 - Queue
 - Deque
 - Sets
   - List
   - TreeSet
   - HashSet
 - Key-Value Map
   - Association List
   - TreeMap
   - HashMap
 - Priority Queue 
 - Graph

What's the basic layout of structures in the Java Stdlib?

To get current Java docs, search for java17 + term. For example:
"java17 java.util"


## Basic data structures are in java.util

 - Java doesn't have ConsList
   - More typical for a functional language
   - The java stdlib mostly assumes mutable structures
 - Java does have LinkedList, which is a mutable doubly linked list
   - Draw it
   - Always O(1) to insert or remove from either end, so appropriate
     for situations where that's what you need from a linked list.
   - Would make a good stack or queue.
   - Show docs: addFirst, addLast, pollFirst, pollLast
 - Java has ArrayList
 - Show List interface
 - For stack, queue, and deque, java has ArrayDeque
   - Or LinkedList
   - Show Deque interface
 - For Sets
   - Show Set interface
   - TreeSet and HashSet are provided
 - For Maps
   - Map vs SortedMap
   - HashMap, TreeMap
 - Java has PriorityQueue, based on a heap.
 - Java doesn't provide a standard Graph structure.
   - Graphs tend to be application-specific; an app or library that
     does graph stuff will give you the graph structure it wants.


## Noteworthy stuff we haven't seen

**Algorithms**

Static methods in java.util.Collections:

 - sort
 - binarySearch
 - reverse
 - shuffle
 - min
 - max
 - rotate
 - swap

**Concurrent Structures**

 - ConcurrentHashMap
 - ConcurrentSkipListMap

Explain skip lists.


## Demos

...
