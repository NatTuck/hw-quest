---
title: "cs2010 Notes: 11-10 Cutting Trees"
date: "2025-11-08"
---

## Robot Control

We've got code that searches a square for a tree, then stops.

Next is chopping down the tree.

We'll start with the basic version:

- Call a chop_tree function with (px, py, pz).
- Chop the bottom log.
- Move forward.
- Chop up until we run out of tree.
- Return to (px, py, pz).
- Stop.

Now we'll make a variant:

- At each level of tree, scan around for neighboring
  logs.
- If we see one, recursively call chop_tree.
- After we return to start position, next step is to
  look and chop up.
- If we run out of tree up, go up and look around
  one more time.
