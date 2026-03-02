---
title: "Notes: 03-02 Exam Review"
date: "2026-03-02"
---

## Topic 1: Big-O Analysis

### Question 10

Solve the recurrence T(n) = 2T(n-1) + 1 with T(0) = 0 using recursion trees.

**Answer:**
**Recursion Tree:**

- Level 0: 1 node, work = 1
- Level 1: 2 nodes, each does 1, total = 2
- Level 2: 4 nodes, total = 4
- Level i: 2^i nodes, total = 2^i

Number of levels = n (from n down to 0)

Total = 1 + 2 + 4 + ... + 2^{n-1} + 2^n - 1 (base case)
      = 2^n - 1
      = **Θ(2^n)**

This is exponential - the recurrence describes algorithms like the naive recursive subset sum.

---

### Question 6

Prove that for all n ≥ 1, the sum 1 + 2 + ... + n = n(n+1)/2.

**Answer:**
**Base Case:** n = 1: Left side = 1. Right side = 1(1+1)/2 = 1. ✓

**Inductive Case:** Assume the formula holds for n = k:
1 + 2 + ... + k = k(k+1)/2

```
For n = k+1:
1 + 2 + ... + k + (k+1)
= [k(k+1)/2] + (k+1)              (by induction hypothesis)
= [k(k+1) + 2(k+1)] / 2
= (k+1)(k+2) / 2
= (k+1)((k+1)+1) / 2
```

This is exactly the formula with n = k+1.

By induction, the formula holds for all n ≥ 1. ∎

---

### Question 10

Prove that the following algorithm correctly determines whether a string is a palindrome:

```
def is_palindrome(s):
  if len(s) <= 1:
    return True
  return s[0] == s[-1] and is_palindrome(s[1:-1])
```

**Answer:**
**Base Cases:**

- Empty string (len = 0): returns True. Empty string is a palindrome. ✓
- Single character (len = 1): returns True. Single character is a palindrome. ✓

**Inductive Case:** Assume is_palindrome correctly determines if any string of length < k is a palindrome. Consider string s of length k ≥ 2.

The function checks if s[0] == s[-1]:

- If false: first and last characters differ, s cannot be palindrome. Returns False correctly.
- If true: The outer characters match. For s to be a palindrome, the inner substring s[1:-1] must also be a palindrome.

By the induction hypothesis, is_palindrome(s[1:-1]) correctly determines if the inner substring is a palindrome.

Therefore, the function correctly determines if s is a palindrome.

By induction, the algorithm is correct for all strings. ∎

---

### Question 4

For the game of Tic-Tac-Toe on a 3×3 board, estimate the size of the complete game tree (upper bound). Explain your reasoning.

**Answer:**
**Upper Bound:** 9! = 362,880 nodes

**Reasoning:**

- Player X goes first and can place in any of 9 positions
- Player O then has 8 remaining positions
- Player X then has 7 remaining, and so on
- Total orderings: 9 × 8 × 7 × ... × 1 = 9!

**Tighter bound:**

- Game ends early when someone wins or board is full
- After 5 X's and 4 O's (9 total), the game definitely ends
- More accurate upper bound: 9! / 5!4! ≈ 12,654 (considering game ends)

The actual number of distinct games is around 255,168 (with optimal play and early termination).

---

The grocery store has priced apples at 5 for a dollar.

You want the most weight of apple.

Does the greedy algorithm work? Prove or disprove.
