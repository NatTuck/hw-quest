---
title: "cs2381 Notes: 10-24 Zoo of Maps"
date: "2025-10-22"
---

## Intro

There's lots of ways to build a map data structure, with a variety of trade-offs
in terms of functionality, performance (by various metrics), simplicity,
programming style, etc.

Today I'll focus on maps, but most of these plans would work fine for sets too.

Also mention: Bag/Multi-Set, Multi-map

### Classifying Map Structures

- Mutable vs. Immutable (and Persistent?)
- Ordered vs. Unordered Keys
- Asymptotic complexity of ops
- Cache friendliness; other hardware-specific considerations

### Options So Far

Major options:

- Association List (list of key, value pairs)
  - Typical operation: O(n)
  - Maybe O(log n) lookup for sorted list
  - Mutable or immutable (since operations are O(n), actually copying
    the list doesn't increase complexity, or you can share tails and be
    kind of efficiently persistent).
- Hash Table (most popular in procedural / OO-style code)
  - Typical operation: expected O(1)
  - Mutable; immutable version would be O(n) or a different structure
  - Maps well to concrete hardware
  - Downside: Hostile key sequence can degrade performance to O(n) unless
    hash function is defended (e.g. with random seed that's different each
    time the program runs.
- Balanced Binary Search Tree
  - Typical operation: O(log n)
  - Mutable or immutable; immutable version persistent with efficient shared
    structure
  - Downside: Pretty bad cache behavior and object overhead.

Two more we've seen:

- Skip List
  - Typical operation: O(log n)
  - Mutable only
  - Really neat, but kind of annoying to actually build.
  - Bad for caches, but can be good for some cases of multi-threaded concurrent
    mutation
- Trie
  - In the last lab, the final map to build was a Trie structure.
  - Instead of comparing keys for order to build a tree, a Trie breaks the key
  into pieces (e.g. a string into bytes) and uses the pieces as tree traversal
  instructions.
  - The asymptotic complexity of Trie operations doesn't depend on the size of the
  structure, but instead on the size of the key. In some cases that could be much
  smaller.
  - If each key is one English word, then O(key length) < O(log n) most of the
  time at N=64 and for almost all keys at N=64K or so.
  - Can be mutable, or immutable and efficiently persistent.

### Other options to know about

- B-Tree
  - Like a binary tree, but with each node having a larger, variable number of
  children (e.g. maybe up to 64).
  - This performs better on modern computers: Tree heights are shorter, so less
  pointers to follow. Also, scanning short arrays linearly is fast due to cache
  mechanics.
  - Frequently used in file systems, both for internal structures for things
  like directories and for the whole filesystem structure on modern CoW
  filesystems (where immutable, persistent is useful).
  - The default in-memory map structure for the Rust language (where it's a
  mutable structure).
- Hash Trie
  - It's a Trie.
  - But first you hash the key with a hash function.
  - This gives you a fixed key length and thus a maximum depth, so operations
  are O(1) unless you have a bunch of exact-same-hash collisions.
  - Can be immutable and efficiently persistent, so it's a popular way to build
  maps in functional languages.
- Patricia Tries
  - Label each edge in the trie not with a single letter, but with
  distinguishing substring.
  - E.g. ("ow" <- "c" -> "at")
  - Git uses these
  - Perfect for prefix-search like cellphone keyboard recommendations.
  - And again, like any tree structure, it can but doesn't need to be
  efficiently immutable and persistent.
