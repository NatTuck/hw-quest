---
title: "Notes: 01-30 Recursion Trees"
date: "2026-01-28"
---

## Complexity Classes Quick Review

- Write the number of operations as a numerical function of the input size.
- Take only the highest term, drop any coefficient.
- e.g. 35x^3 + (1/4)x + 351 becomes just x^3.

### Big-O and friends

- f is O(g) means that the function f is eventually bounded above by g.
  - f(x) <= k*g(x) given some constant k for all x > some x0.
- f is Omega(g) means the function f is eventually bounded below by g.
  - Same, but >=
- Theta is just O and Omega, so bounded above and below.

## Figuring out complexity classes

- Simplest: Counting loops to get n, n^2, etc.
- Recursion can be a bit trickier.

Idea: Recursion trees.

- We can think of a call to a recursive function as a tree.
- The initial call is the root.
- The recursive calls from the initial call are the children of the root.
- Etc.
- In each node we do some amount of work.
- Branches are likely to be different from leaves.
- We can determine the total number of operations by drawing out the tree
  and adding up all the operations in each call.

**Example: Merge Sort**

```
def mergesort(xs):
  ys = mergesort(first half of xs)
  zs = mergesort(second half of xs)
  return merge(ys, zs)

def merge(xs, ys):
  zs = []
  until both xs and ys empty:
    if either xs or ys empty:
       append the other to zs
    else:
       compare xs[0] to ys[0]
       remove the smaller one and append it to zs
  return zs
```

When we run mergesort on a list xs of length n:

- The initial call is on the whole list (size n).
- It does two recursive calls, each on a list of n/2 items.
- The recursive calls get us two lists each of size n/2.
- We call merge, feeding in both lists.
- Merge is O(n) if fed two lists totaling n items.
- Actually doing the recursive calls is O(1), we'll account for
  the work they do elsewhere.
- How many levels? log(n)
- At the top level we do n work.
- At the next level we do 2(n/2) work.
- At the next level we do 4(n/4) work.
- ...
- At the leaves  n(1) work.
- Total work: n log n
- So we're \Theta(n log n)

Fuzzy bits:

- What about constants?
- What if n isn't a power of two?

## More

- Merge Sort, but with Merge replaced by insertion_sort(left + right).
- Stooge Sort
