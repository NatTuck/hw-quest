---
title: "Notes: 03-06 Graphs"
date: "2026-03-04"
---

## Definition

A graph is a set of pairs.

- That set of pairs is called the "edges" of the graph.
- We can also talk about the set of elements that appear in the pairs. That's
the "vertices" of the graph.
- If the pairs are unordered, it's an undirected graph.
- If the pairs are ordered, it's a directed graph.

We frequently draw graphs with circles and lines (or arrows) connecting them,
but that's just a graphical representation of the set of pairs.

## Graph Representations

- Adjacency list.
  - A list or array of the vertices in the graph, each with a (linked) list of their outgoing edges.
- Adjacency matrix.
  - A 2D array
- Object graph.

## Graph Traversal

Find all reachable nodes:

```
print_reachable(graph, seen, v0):
  todo = Set([v0])
  seen = Set()
  while not empty(todo):
    v = take one from todo
    if not seen.contains(v):
       print(v)
       seen.put(v)
       for each edge in graph.edges(v):
         todo.put(edge)
```

Presumptively items come out of a set unordered. But we can do something-first
searches by replacing the todo set with something else: stack, queue, priority
queue.

## Lots of things end up being graphs

- Trees are graphs that are connected and have at most one path between any two
vertices.
- Grids are graphs.

## Example Problem

A number maze is an n ⇥ n grid of positive integers. A token starts in the
upper left corner; your goal is to move the token to the lower-right corner. On
each turn, you are allowed to move the token up, down, left, or right; the
distance you may move the token is determined by the number on its current
square. For example, if the token is on a square labeled 3, then you may move
the token three steps up, three steps down, three steps left, or three steps
right. However, you are never allowed to move the token off the edge of the
board.

Describe and analyze an efficient algorithm that either returns the minimum
number of moves required to solve a given number maze, or correctly reports
that the maze has no solution.
