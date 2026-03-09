---
title: "Notes: 03-09 More Graphs"
date: "2026-03-07"
---

## Last Time

- We defined graphs, vertices, and edges; directed and undirected.
- We talked about graph representations: Adjacency Matrix, Adjacency List
- We talked about algorithms to do graph traversals.

### More Definitions

- Vertices are frequently called nodes.
- Simple graphs: No self loops or duplicate edges.
  - Multigraphs: Self loops and duplicate edges allowed.
- If there's an edge *u->v*, then v is adjacent to and a neighbour of u.
- The degree of a node is its number of neighbors (or out edges).
- A walk is a sequence of vertices where each adjacent pair of vertices in the
walk are adjacent in the graph.
- A path is a walk that doesn't visit any vertex multiple times.
- A closed walk starts and ends at the same vertex.
- A cycle is a closed path.
- An acyclic graph contains no cycles.
- A tree is a connected acyclic graph.
- A subgraph of a graph G is a graph has a subset of the edges and a subset of
the vertices in G.
- A spanning tree of an undirected graph G is a tree that contains every vertex
in G.

## Traversals

- Do a depth-first search.
- For a pre-order traversal, visit (e.g. print) the node before recursing.
- For a post-order traversal, visit (e.g. print) the node after recursing.
- This should be familiar from trees, although because we only recurse
once and keep a "todo " data structure.

## DFS

```
DFS(v):
  mark v
  PreVisit(v)
  for each edge (v, w):
    if w is unmarked:
      w.parent = v
      DFS(w)
  PostVisit(v)
```

After, parent pointers give us a spanning tree.

## Depth First Sequencing

```

Preprocess(G):
  clock 0
PreVisit(v):
  clock = clock + 1
  v.pre clock
PostVisit(v):
  clock = clock + 1
  v.post = clock

```

## Detecting Cycles

For any edge *u->v*, if u.post < v.post then there's a cycle.

Can we prove that?

## Edge Types

For a given DFS traversal, we end up with some different edge types:

- Tree edges are the spanning tree defined by parent pointers.
- Forward edges are edges that point down the tree.
- Cross edges point across the tree.
- Back edges point up the tree.

## Topoligical Sort

A topological ordering of a directed graph G is a total order  on the vertices
such that u < v for every edge u -> v . Less formally, a topological ordering
arranges the vertices along a horizontal line so that all edges point from left
to right. A topological ordering is clearly impossible if the graph G has a
directed cycle—the rightmost vertex of the cycle would have an edge pointing to
the left!

Just reverse a post-ordering.

## Dynamic Programming

This visits the dependency graph of the recurrence in topologically sorted order
explicitly.

## Memoization

Memoization does the same thing implicitly.
