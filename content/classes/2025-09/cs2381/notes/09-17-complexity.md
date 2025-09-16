---
title: "cs2381 Notes: 09-17 Complexity"
date: "2025-09-15"
---

Growth of functions, classes.

- f(x) = 1
- f(x) = log2(x)
- f(x) = sqrt(x)
- f(x) = x
- f(x) = x*log2(x)
- f(x) = x^2
- f(x) = x^3
- f(x) = 2^x

Why do we throw away constants and lower-order terms? Which constants and terms?

Formally:

- Big O (bounded above)
- Big Omega (bounded below)
- Big Theta (both)



Counting operations.

Which operations?

- Machine instructions?
- We really want time. How does that relate to instructions?
- => Whichever thing happens the most, the rest is constants and lower order
terms.

Which N?

- Size of a collection.
- What if there are two collections with different sizes?
  - Assume the same size?
  - One is asymptotically bigger.
