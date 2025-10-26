---
title: "cs2381 Notes: 10-27 Bit Vec"
date: "2025-10-25"
---

## Problem: ArrayList of Booleans

Plan A: `var xs = new ArrayList<Boolean>();`

```txt
xs -> ArrayList(Boolean data[], int size)

data -> Array[d0, d1, d2, ...]

dX -> Boolean(bool val)
```

So each boolean is in an object with:

- 16 byte object header, 1 byte for the value
  - That'll probably align to 24 bytes.
- A reference to it that's another 8 bytes
- So likely 32 bytes = 256 bits per boolean.
- We should be able to store a boolean in one bit. How?

Plan B: Numbers are made out of bits.

- e.g. A byte is 8 bits.
- So instead of a Boolean[], or even a bool[], we use a byte[].
- We're kind of doing the opposite of a generic structure.
- We're *specializing* ArrayList for bits.

Operations to implement: get, set, add, size.
