---
title: "cs2381 Notes: 11-14 DFS, BFS"
date: "2025-11-12"
---

For Swing on Wayland: export _JAVA_AWT_WM_NONREPARENTING=1

- Start from lab 12 starter code.
- Build depth-first search.
- Build breadth-first search.
- Build iterated breadth-first search.

```
 1  procedure BFS(G, root) is
 2      let Q be a queue
 3      label root as explored
 4      Q.enqueue(root)
 5      while Q is not empty do
 6          v := Q.dequeue()
 7          if v is the goal then
 8              return v
 9          for all edges from v to w in G.adjacentEdges(v) do
10              if w is not labeled as explored then
11                  label w as explored
12                  w.parent := v
13                  Q.enqueue(w)
```
