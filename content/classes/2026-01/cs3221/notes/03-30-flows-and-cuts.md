---
title: "Notes: 03-30 Max Flow, Min Cut"
date: "2026-03-28"
---

## Exam 2 Date

Exam 2 will be Next Thursday, April 9th

## Today: Max Flow, Min Cut

### Flow

We've got:

- A weighted, directed graph.
- A source vertex *s* and target vertex *t*.

The weights represent capacity, frequently to transport stuff. Maybe tons of
goods per day in the Soviet rail network, maybe gallons per minute in water
pipes.

So how much stuff can we get from *s* to *t* through the graph?

- If we use one path, our limit is the minimum weight on that path.
- But what if we use *all* the paths simultaneously. The total usage of an edge
can't exceed its capacity, but we might be able to use more of the capacity than
any single path through an edge allows, and we can certainly add up the
capacities of any independent paths.
- A flow f is an assignment of a real number (capacity used) (0 <= x) to every
edge in the graph. A flow is feasible if the capacity <= weight for each edge.
- The value of a flow (|*f*|) is the total net flow out of the source (which
equals the total net flow into the target).
- Each intermediate vertex has the same flow in and out.
- We say a flow avoids an edge if the used capacity of that edge is 0.
- We say a flow saturates an edge if the whole capacity is used.

The maximum (s,t)-flow is the flow from s to t with the maximum value.

### Cut

We've got:

- A weighted, directed graph.
- A source vertex *s* and target vertex *t*.

We want to partition the graph into two disjoint sets of vertices S (including
s) and T (including T). Any flow from *s* to *t* must go from S to T over the
edges from S to T. This is called a cut, because if we cut all the edges from S
to T then the flow is 0.

The capacity of a cut S, T is the sum of the weights of the edges from S to T.

The minimum (s,t) cut is the cut S, T with the minimum capacity.

### Max Flow = Min Cut

To prove this:

- First, we work with reduced graphs, where there is at most one edge between
any two vertices. We can construct reduced equivalents to non-reduced graphs.
- Let f be a feasible flow in G. We can define a residual capacity graph as:
  - The same vertices.
  - An edge for any remaining capacity.
  - A reverse edge for the capacity used in f.
- Now we can look for augmenting paths in the residual graph: any path from s ->
t with a positive minimum weight. We can add that to increase flow. Repeat until
we have a max flow
- If there is no augmenting path, then the vertices reachable from s in G can be
S in an S-T cut, and the capacity of that cut equals the max flow we just found
(or there would be another augmenting path).

This also gives us an algorithm for max flow and for min cut. This is the
Ford-Fulkerson algorithm.

### Integers

- If all the weights are integers, then there's a max flow and min cut where all
  the capacities used are integers. Why?
- For irrational weights, this algorithm may not terminate or even give useful
outputs.

With integer capacities, FF runs in O(|E||f*|) time, where f* is the actual max
flow, which is kind of slow since it depends on the value of edge weights.

With non-integers, it could take exponential time or never terminate.

### How to chose augmenting paths?

Edmonds and Karp say:

- Take the path with the largest bottleneck edge. This is faster, but still
depends on edge weight values.
- Take the path with the fewest edges. This can run in O(|V||E|^2) time.

### Can we go faster

Yes. Apparently the fastest general solution is O(|V||E|).
