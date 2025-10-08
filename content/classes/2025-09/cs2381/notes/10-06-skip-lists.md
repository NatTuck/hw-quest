---
title: "cs2381 Notes: 25-06 LogN and Skip Lists"
date: "2025-10-04"
---


## First, Look at the Lab07 starter code

- ConsSet is naturally an immutable Set.
- ArraySet is naturally a MutableSet.

## New Idea: Skip Lists

Material:

- Binary search on ArrayList
- Skip lists

Core idea:

- Searching through a list takes O(n) time.
- Searching through a *sorted* list only needs to take O(log n) time,
  as long as you have some way to quickly jump to the middle of the
  unsearched part of the list.

Strategy:

- Start with a doubly linked list.
- Some cells have more than one prev / next link.
- Optimal:

  - Cell 0 and N each have log2(N) links.
  - The 1/2 point cell has log2(N) - 1 links.
  - The 1/4 point cells have one less.
  - The 1/8 point cells have one less.
  - etc.

- Probabilistic:

  - When inserting a new cell, it'll have a 50/50 chance of
    having two links, a 0.25 chance of 3, etc.

- This is tricky, so we're not actually going to build it, but it
  ends up having expected log2(n) behavior for most simple operations.
