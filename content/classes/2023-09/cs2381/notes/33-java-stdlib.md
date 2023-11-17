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

Interfaces:

 - Java provides a heirarchy of interfaces, so you can, e.g.,
   differentiate between Map and Sorted Map.
 - All of the collections above implement the Collection interface
   - Pull up docs
   - Looks like it has a lot of methods, but the ones that do stuff are
     optional
   - Most significantly: Collections are iterable
   - Also neat: Streams


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

### Skip Lists

Start with a set stored as a Linked List - values in sorted order.

```
    A -> B -> C -> E -> J -> ∅
```

Operations:

 - Insert: O(n)
 - Contains: O(n)
 - Delete: O(n)

The idea of a skip list is that some of the list nodes have more than
one forward reference.

Show every other item being height 2.

``` 
    | ------> | ------> | -> ∅
    | -> | -> | -> | -> | -> ∅
    A    B    C    E    J
```

First we traverse the top list until we've gone too far, then we back
up and traverse the next list down.

If each level contains half as many items as the level below it, then, for
a set of 64 items:

 - The bottom layer has 64 items
 - Next 32
 - 16
 - 8
 - 4
 - 2

So 64 items requires 6 layers... log2(64) = 6

A traversal only requires looking at 2 items at each layer, which means that
our operations should be:

 - Insert: O(log n)
 - Contains: O(log n)
 - Delete: O(log n)

There's one problem: A bad pattern of inserts / deletes could leave
you without enough tall items, causing performance to degrade to O(n).

Generally, skip lists are implemented with probablistic heights rather
than folowing the pattern exactly. Each item has a 1 in 32 chance of
having a height of 5, etc. 

## LongBitSet

Problem: You want to find primes up to 10B, but BitSet only takes "int" args.

Solution: LongBitSet

 - http://home.apache.org/~rmuir/jacoco-core/org.apache.lucene.util/LongBitSet.java.html
 - https://mvnrepository.com/artifact/org.apache.lucene/lucene-core/9.8.0

## Demos

 - Show a queue example with LinkedList
 - Show map / filter from stream
