---
title: "cs2381 Notes: 10-31 Bit Set"
date: "2025-10-27"
---

## Part 1: Bit Set

- For any fixed set of N possible items, we can represent subsets
  with a bitvec of N booleans.
- Four available pizza topics, 4 bits.
- 35 specific courses listed in our CS degree, you could
  store a set of which ones you've taken in 5 bytes

Set operations:

- Union
- Intersection
- Difference

Discuss how set operations are the same as boolean operations, and how
that straight up applies here.

## Part 2: Approximate Sets

Problem:

- Mozilla Firefox wanted to add a feature to block access to phishing sites.
- Firefox users cared at least slightly about privacy, so this feature couldn't
work just by sending every domain to Mozilla before visiting it.
- The list of phishing sites is too large and too frequency updated to just
send the whole list to every user. Call it 100,000 domains averaging 15
characters each, so like 1.5MB. Back in 2012 or whenever this was too big
to just send to every user every day.
- Idea: Hash the domain and give the user the list of 32-bit hashes.
- Problem: False positives from collisions.
- Solution: If there's a collision, *then* contact the Mozilla server and check;
  this will almost never happen with 100k items and 2^32 possible integers.
- Problem: That's still 4 * 100k = 400k, too big.
- Solution: Use a smaller hash.
- Problem: Even a 16 bit hash - 64k possible values - would be half collisions.
- Idea: Use the hash to index into a hash table of bits.
- To have only a 5% chance of false positives, you'd need to have 20 times
  as many bits as items in the set - so 1.6 million bits is 200k bytes.

## Part 3: Bloom Filters

- Idea: More than 1 hash function.
- I'm bad at math, so let's do some testing.
