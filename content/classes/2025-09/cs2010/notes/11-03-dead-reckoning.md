---
title: "cs2010 Notes: 11-03 Dead Reckoning"
date: "2025-11-01"
---

## Robot Control

- Last time we started to vibe code a program to cut down trees.
- Today I want to think a bit more and finish that program
  manually.

Key idea: Levels of abstraction.

- High level: We're going to find and cut down trees.
- Low level: Move forward.

What goes in the middle?

To find out, we need to take the high level description and break it down
into pieces:

Search area for trees and cut them down.

- Search area for a tree.
- Then cut it down.
- Then return to the search.
- Continue until whole area has been searched.

To search for a tree.

- We need to follow some pattern that covers the area.
  - Foward and back, alternating columns.
  - Spiral
  - Hilbert Curve
  - etc
- Stop when we run into a log.

To cut down a tree.

- Chop the log.
- Move to where the log was.
- Chop up until we run out of logs.
- Find any more tree.

Return to the search.

- Problem: Not all trees are the same size / shape.
- Problem: After chopping down a tree we don't know how to get back.
- Solution: Track what moves we made.
  - Three dimensions x is east, z is south, y is up.
  - If x is forward, z is right, y is up.
  - Every time we move, update variables tracking our position and direction.
  - Instead of calling turtle.forward() or other movement functions, make a
    function that "wraps" that function and also updates position.
  - Now we know why we needed dx and dy last time; those are *direction*.
- To return to the starting point, just make the moves needed to zero out
  the difference from our starting point. That may even be a more direct
  path than how we went chopping down the tree.

Continue

- One of the neat things about structuring our programs as functions is that
  when we return from a function we naturally just keep doing whatever
  we were doing before.
