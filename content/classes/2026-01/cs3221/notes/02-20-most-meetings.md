---
title: "Notes: 02-20 Most Meetings
date: "2026-02-16"
---

## Grouping Problems

We've been looking at a couple similar problem families:

**General Search Problems (Backtracking)**

- We need to make a series of choices.
- We can't be sure if we got the first choice right until
  we've got a whole choice sequence.
- That means we need to try every sequence.
- Typically, this takes exponential time.

**Optimal Substructure (Dynamic Programming / Memoization)**

- We need to make a series of choices.
- We have overlapping subproblems; we can't just split it in half and
independently solve the halves.
- We can make an optimal choice for one more step based entirely on the series
of choices made so far and/or the previous optimal answers.
- Typically, this takes polynomial (e.g. O(n), O(n^2)) time and frequently also
polynomial space for our table of subproblem solutions.

**Locally-optimal Substructure (Greedy Algorithms)**

- We need to make a series of choices.
- We can structure the problem such that at each step the immediate optimal
choice is also the globally optimal choice.
- This means we can solve the program in polynomial time without needing to
build and manage a supplemental data structure.
- Many problems have tempting greedy heuristics that don't actually give optimal
solutions. We can't be sure a greedy algorithm is optimal without an actual
proof.

## Scheduling Meetings

Imagine for a moment that you're an administrator at a university. Nobody's
quite sure what you do, but everyone knows your important.

To make sure everyone remembers how important you are, you want to attend as
many of the zoom meetings that you've been invited to as possible. You need to
convince the other attendees that you really care and are a valuable resource,
so if you join a meeting you've got to attend the whole thing.

At this university there's no real consistency about when meetings start or how
long they last, so you've just got a big table of meetings all over the place
during the day.

You give this problem to a helpful undergraduate CS student, and they formalize
it as follows:

Input: Two lists of length N, where for each meeting ii, `S[ii]` has the start
time and `E[ii]` has the end time.

Output: The longest possible list of meetings (or indices) such that no two
meetings in the lists overlap.

Step 1: Draw an example on the board.

Step 2: Recursive search solution

- For each meeting ii, either you attend or you don't
- Assume meeting ii is in the optimal schedule. That means we can find the
optimal schedule for meetings before ii, the optimal schedule for the meetings
after ii, and then combine the 3.

Step 3: Dynamic programming

- Two tables: Optimum before meeting ii, optimum after meeting ii
- Which order should we fill them in?

Step 4: Greedy programming

- Sort in *finish* order.
- Greedily take the legal meeting that finishes soonest.

Step 5: Prove correctness

(First meeting)

- Let MS be the full set of meetings.
- Let F be the meeting that finishes first in MS.
- Assume we have an optimal schedule XS for MS that doesn't include F.
- Let G be the meeting that finishes first from XS.
- Because F is the meeting that finishes first, G can't finish
  any sooner.
- That means that no meeting that doesn't conflict with G can conflict
  with F, and therefore swapping out G for F is still an optimal
  schedule.

(The rest of them)

- Consider the subset of meetings MS' that don't conflict with F. Because F
finishes first, those are the ones start after F finishes.
- Let F' be the meeting that finishes first.
- Assume we have an optimal schedule XS' taht doesn't include F'.
- ...
- Now, because we know that F is in an optimal schedule, the rest of
that optimal schedule must be an optimal schedule for the meetings
that don't conflict with F.

## Let's try to do one that doesn't work

Redraw an instance of smallest-path-sum problem.

- We have two choices.
- We'll take the one with the smaller value.

This is correct. Proof:

- Let S be the smaller value.
- Assume we have an optimal path that doesn't include S.
- That would have some start value B that's bigger than S.
- So we can just keep the rest of the path and start at S instead
  of B.
- Because S is smaller than B, this is a better path.
- And by induction, the same thing is true for the rest of the path.
  
