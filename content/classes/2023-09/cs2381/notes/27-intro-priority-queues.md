---
title: "cs2381 Notes: 27 Introducing Priority Queues"
date: "2023-10-31"
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
 
Plan to make one:

 - List of (priority, item)
 - Binary tree ordered by priority.
 - 
