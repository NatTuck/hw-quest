---
title: "Notes: 04-03 Applications of Flows, Cuts"
date: "2026-03-31"
---

## Exam 2 Date

Exam 2 will be Next Thursday, April 9th

## What Good is Min Flow / Max Cut?

### Edge-Disjoint Paths

Problem: Find the number of distinct paths (no shared edges) from s to t.

Solution:

- Make this a weighted graph with every edge having weight 1.
- Now max flow = # of distinct paths.

### Vertex-Disjoint Paths

Problem: How about no shared intermediate vertices?

Solution:

- Replace each vertex with two with a weight 1 edge between them.
- Now max flow = # of distinct paths.

### Bipartite Matching

Example:

- We've got a set of doctors and a set of hospitals.
- Doctors have hospitals they will work for, and hospitals have doctors they
will hire.
- We want to maximize number of hires.

Solution:

- Construct a graph:
  - Doctors are vertices.
  - Hospitals are vertices.
  - There's an edge from each doctor to each hospital where both doctor and
  hospital accept the other. Each wt = 1.
  - Add vertex s with edge to each doctor, wt = 1.
  - Add vertex t with edge from each hospital, wt = |V|.
- Calculate max flow.

Each hospital only wants one doctor? h -> t weight is 1.

### Tuple Selection

Finding assignments of several "resources".

Let's give concrete example:

#### Exam Selection

Flow network:

- s -> classes -> rooms -> times -> proctors -> t

Specifically:

- An edge s 0  c i with capacity 1 for each class i . (“Each class can hold at most
one final exam.”)
- An edge c i  r j with capacity 1 for each class i and room j where the class
will fit in the room capacity.
- An edge r j  t k with capacity 1 for each room j and time slot k . (“At most
one exam can be held in room j at time k.”)
- An edge t k  p with capacity 1 for time slot k and proctor such that
`A[, k] = T` . (“A proctor can oversee at most one exam at any time, and
only during times that they are available.”)
- An edge p -> t 0 with capacity 5 for each proctor (“Each proctor can oversee
at most 5 exams.”)

### Example Problems

- Question 11.4
- Question 11.11



