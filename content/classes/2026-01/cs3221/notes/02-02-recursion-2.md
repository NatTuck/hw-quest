---
title: "Notes: 02-02 Stooge Sort"
date: "2026-02-02"
---

## Stooge Sort

```
 function stoogesort(array L, i = 0, j = length(L)-1){
     if L[i] > L[j] then       // If the leftmost element is larger than the rightmost element
         swap(L[i],L[j])       // Then swap them
     if (j - i + 1) > 2 then   // If there are at least 3 elements in the array
         t = floor((j - i + 1) / 3)
         stoogesort(L, i, j-t) // Sort the first 2/3 of the array
         stoogesort(L, i+t, j) // Sort the last 2/3 of the array
         stoogesort(L, i, j-t) // Sort the first 2/3 of the array again
     return L
 }
```

We can build a recurrence relation here:

```
T(n) = 3T(2n/3) + \Theta(1)
```

- 3T because 3 recursions.
- 2n/3 because each recursion is 2/3 as big.

## Recursion Tree

- Level 0 (Root): 1 node, non-recursive O(1) work
- Level 1: 3 nodes, each working on 2/3n iput, non-recursive O(1) work = 3
- Level 2: 3^2 nodes, each working on (2/3)^2 items. 9 work
- Level i: 3^i nodes, each working on (2/3)^i items. 3^i work

To get height, take n = (3/2)^h and solve for h:

- log(3/2) both sides
- So height is log_{3/2}(n).

So we end up with: \sum_{i=1}^{log_{3/2}(i)} of 3^{i} as the total
amount of work.

The last level ends up dominating:

- Draw the tree.
- Show how we can line up all the other levels next to the last
  level and the sum is shorter.

So total work is \Theta(3^h).

- = 3^{log(3/2)}
- We've got a log identity: a^{log_{b}(c)} = c^{log_{b}(a)}.
- That gets us n^{log_{3/2}(3)}.
- Python: `math.log(3, 1.5)`
- So \Theta(n^{2.71})

So we end up with 3^{log_{3/2}(n)} ~ \Theta(n^2.71)

## New Topic: Subset Sum

Given a number K and list of integers xs, find a subset of xs that sums to K.

Simple solution:

- First, assume `xs[0]` is in the solution.
- Recursively try to find a subset of `xs[1..]` that adds up to `K - xs[0]`.
- If not, `xs[0]` isn't in the solution, recurse on `xs[1..]` and K.

What's the runtime?
