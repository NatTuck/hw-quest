---
title: "Notes: 02-13 Dynamic Programming"
date: "2026-02-11"
---

Backtracking / search problems tend to be O(2^n). That's slow.

But many of them have shared subproblems. If we can exploit that,
we can go much faster.

## Robber Problem (or Fib)

Robber problem:

- There's a street with houses along one side.
- You have a list of the value of the stuff you could
  steal from the houses, in order.
- You'd get caught if you rob two houses next to each other
- Maximize the value of the houses that you rob.

Basic strategy:

- Either include a house or don't.
- If we do include a house, the next legal house is i + 2.
- Problem: Best set of houses to rob up to some index i.

Steps:

- Recursive
- Memoize
- Table
- prev0, prev1

## Longest Increasing Subsequence

- We've got a list of numbers.
- We want to find the longest increasing subsequence.
- Recursive problem:
  - Best subsequence that ends with the number at index ii.
  - Then we can expand by one by scanning through for the
    best compatible previous subsequence, so O(n^2) total.

## Work through some variants

- Recursive
- Memoize
- Table
- Must retain table
