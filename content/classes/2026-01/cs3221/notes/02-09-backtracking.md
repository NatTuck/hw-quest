---
title: "Notes: 02-09 Backtracking"
date: "2026-02-07"
---

Last time: We looked at a problem called subset sum.

This time, a broad algorithm design strategy for that kind of problem:
backtracking.

## Search Problems

- We have a series of choices we need to make.
  - Whether or not to include a number in our subset.
  - Which road to take when finding a path on a map.
  - Which move to make in a game.
- Once we have a proposed sequence, we can validate it.
  - Correct / Wrong
  - Score (e.g. # of bins)

Basic plan:

- Make the first choice in the series.
  - Recurse find the rest of the choices in the series.
- At each level, if we know we have the best answer then
we're done.
- If we may not have the best answer, try another choice.

## How efficient was our subset sum algorithm?

- Not great.

## Example: Game Trees

Tic-Tac-Toe is too complicated. So let's do a simpler game.

- There's a 1D array of squares of some length.
- Players take turns placing X's in the squares.
- Whoever makes 3 in a row wins.

Who wins for each board size?

- n = 1, 2 - No winner
- n = 3?

Let's write a program to do the search in general.
