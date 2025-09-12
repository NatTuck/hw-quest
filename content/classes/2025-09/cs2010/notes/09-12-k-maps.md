---
title: "cs2010 Notes: 09-12 K-Maps"
date: "2025-09-10"
---

## Simplifying Circuits

Here's a truth table:

| A | B | Out |
|---|---|-----|
| 0 | 0 | 0   |
| 0 | 1 | 1   |
| 1 | 0 | 0   |
| 1 | 1 | 1   |

If we take the 1 terms and write this in SoP form:

  AB + A'B

We can apply boolean algebra:

- AB + A'B
- = A(B+B')
- = A(1)
- = A

There's a trick to speed that up with visual pattern matching,
called a K-map (Karnaugh Map).


|    |  A' |  A  |
|----|-----|-----|
| B' |  0  |  1  |
| B  |  0  |  1  |

Look for even-size rectangles of 1's and circle them.

And the rectangle is in the A column, so our simplified expression is just A.


| A | B | C | Out |
|---|---|---|-----|
| 0 | 0 | 0 |  0  |
| 0 | 0 | 1 |  0  |
| 0 | 1 | 0 |  1  |
| 0 | 1 | 1 |  0  |
| 1 | 0 | 0 |  1  |
| 1 | 0 | 1 |  0  |
| 1 | 1 | 0 |  1  |
| 1 | 1 | 1 |  0  |

Grey code - each adjacent cell differs by one bit.

|    | A'B' | A'B | AB | AB' |
|----|------|-----|----|-----|
| C  | 0    |  0  | 0  | 0   |
| C' | 0    |  1  | 1  | 1   |


-> AC' + BC'

Let's consider a k-map of ABC that will resolve to just A.

|    | A'B' | A'B | AB | AB' |
|----|------|-----|----|-----|
| C  | 0    |  0  | 1  | 1   |
| C' | 0    |  0  | 1  | 1   |

Let's consider a k-map of ABC that will resolve to just B'.


|    | A'B' | A'B | AB | AB' |
|----|------|-----|----|-----|
| C  | 1    |  0  | 0  | 1   |
| C' | 1    |  0  | 0  | 1   |

This gives us a two-by-two square of 1's that wraps around the edge.

We can go to 4 variables with a 4x4 table. More still works, but it gets
annoying.

