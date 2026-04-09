---
title: "Notes: 04-06 Exam 2 Review"
date: "2026-04-01"
---

## Exam 2 Date

Exam 2 will be Next Thursday, April 9th

## Tree Algos

Prove that if you have a tree and add an edge the resulting graph is not
a tree.

Prove that if you have a tree and remove an edge the resulting graph is not
a tree.

## DFS

Look at textbook figure 6.5.

This diagram shows one DFS tree rooted at s.

- In this graph, could a back edge in one traversal be a forward edge in another?
- A cross edge?
- How about in a different graph?
- Show examples or prove it's impossible.

## MST

Consider the following minimum spanning tree algorithm for an undirected graph
with minimum weight edges:

- Replace each edge with weight w in the graph with a string of w edges with
intermediate vertices.
- Do a breadth-first search.
- The first path connecting original vertices is an edge in the MST.

Prove that works, or not. If not, how can we fix it?

## Shortest Paths

The textbook says that it's possible for a graph to have every shortest path
tree use different edges from the MST. Can we show this?

## All Pairs Shortest Paths

Can we do better on all-pairs shortest paths than Floyd-Warshall
in an undirected, unweighted graph?

## Min Flow / Max Cut

Can we make negative edge weights meaningful here?

## Applications of Flow / Cut

We can identify connected subgraphs using an extra source vertex and graph
search.

Can we construct a flow graph to identify the number of connected components of
a possibly unconnected graph?
