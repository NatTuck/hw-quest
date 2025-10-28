---
title: "cs2381 Notes: 10-27 More Bits"
date: "2025-10-27"
---

## Part 1: Finish BitVec

- Until it works.

## Part 2: Performance of Hash Trie

- Draw out
- Discuss asymptotic complexity.
  - Assuming N < 2B and no collisions.
  - Allowing N > 2B and collisons.
- Discuss practical performance, and why this is a good example of how
  asymptotic complexity can be a silly measure. This is a tree with
  a constant H = 8. Compare BST, binary search, b-tree, regular trie.
- Discuss compressed version.

## Part 3: Bit Set

- For any fixed set of N possible items, we can represent subsets
  with a bitvec of N booleans.
- Four available pizza topics, 4 bits.
- 35 specific courses listed in our CS degree, you could
  store a set of which ones you've taken in 5 bytes

Set operations:

- Union
- Intersection
- Difference
