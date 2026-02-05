---
title: "Notes: 02-06 Subset Sum"
date: "2026-02-04"
---

## Proof by Induction: Sum a List

```python
def sum1(xs):
  if len(xs) == 0:
    return 0
  else:
    return xs[0] + sum1(xs[1:])
```

To prove: This correctly sums the list.

Base case: The sum of an empty list is zero. The code does that.

Inductive case:

- This passes the rest of the list to the recursive call. We can assume the
  rest of the list is summed correctly.
- Once we have the sum of the rest of the list, it's sufficient to add the
  first item to the sum.
- We do that.
- Proof done.

Wait, how's that a proof?

Let's look at an example: 1, 2, 3, 4

- Recurse, Recurse, Recurse, Recurse, Base case = 0, Return
- Now we're looking at 4 + sum([]) = 4.
- We can see that sum works correctly, and we know that adding one item into
  a sum works because of the properties of addition.
- The rest of it must work.

## Proof by Induction: Reverse a list

```python
def reverse(xs):
  if len(xs) == 0:
    return []
  else:
    # Reverse the rest, then put the first item at the end
    return reverse(xs[1:]) + [xs[0]]
```

To prove: This correctly returns a list with the elements in reverse order.

Base case: The reverse of an empty list is an empty list. The code returns `[]`, which is correct.

Inductive case:

- The code passes the rest of the list (`xs[1:]`) to the recursive call.
- We assume the recursive call correctly reverses that part of the list.
- We need to place the first item (`xs[0]`) at the very end of the result.
- The code does exactly that: it takes the correctly reversed tail and appends the first item to it.
- Since the first item of the original list becomes the last item of the reversed list, the result is correct.
- Proof done.
- Again, let's look at what's happening.

## Today's problem

- We've got an integer `x` and a list of integers `ys`.
- Can we pick some of the numbers from `ys` such that they
  add up exactly to `x`?
- Answer: null or the list

Example:

- 100, (10, 20, 27, 30, 50, 18) -> (20, 30, 50)
- 100, (23, 34, 45, 76) -> null

Let's prove we can write a function `subsum(x, ys)` to solve this
recursively.

- Base case: We can always sum an empty list to zero.
- Base case: We can never sum an empty list to a number other than zero.

Given an integer `x` and a non-empty list `ys` we can find a subsequence of
`ys` that sums to `x` two ways:

- The subsequence does not include `ys[0]`. That means the entire subsequence
  must be from the rest of the list, and we can find that subsequence (or
  show there is none) with `seqsum(x, ys[1:])`.
- The subsequence does include `ys[0]`. In that case, we need to find a
  subsequence of the rest of the list that adds up to `x - ys[0]`. We can
  do that with a recursive call `seqsum(x - ys[0], ys[1:])`.

```python
# Thanks, Gemini
import random

def gen_instance(n):
    ys = [random.randint(1, 20) for _ in range(n)]
    
    if random.random() < 0.75:
        # 75% Solvable: Pick a random subset and sum it
        k = random.randint(0, len(ys))
        x = sum(random.sample(ys, k))
    else:
        # 25% Unsolvable: Force list to be even, target to be odd
        ys = [y * 2 for y in ys]
        # Sum a subset then add 1 to ensure x is odd (and thus impossible)
        k = random.randint(1, len(ys))
        x = sum(random.sample(ys, k)) + 1
        
    return x, ys
```

Let's actually write the above algorithm and see how it works on different
problem sizes.
