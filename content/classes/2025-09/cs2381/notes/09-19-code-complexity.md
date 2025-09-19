---
title: "cs2381 Notes: 09-19 Code Complexity"
date: "2025-09-17"
---

Last time, we separated numerical functions into orders of growth.

For figuring out about how fast things grow, we can:

- Take only the highest degree term.
- Ignore any coefficient.

We can classify our functions by that highest degree term.

- f(x) = 1
- f(x) = log2(x)
- f(x) = x
- f(x) = x*log2(x)
- f(x) = x^2
- f(x) = x^3
- f(x) = 2^x

Today, we'll look at how this applies to comparing algorithms
on computers.

Let's start with a sorted ArrayList of N integers:

`[3, 11, 41, 92, 278, 531, ...], length = N`

Let's consider a simple function that determines if a given number appears in
the list.

```java
    static boolean listContains(List<Integer> xs, int yy) {
        for (int ii = 0; ii < xs.size(); ++ii) {
            int xx = xs.get(ii);

            if (xx == yy) {
                return true;
            }
        }
        return false;
    }
```

How many operations does this take?

- Calling a method takes some operations, but we'll ignore that 
  for the moment.
- The loop will happen several times, once per item in the list.
  - We already said the list is length N, so the loop runs N times.
- int ii = 0 // once
- ii < xs.size() // N times
- ++ii // N times
- int xx = xs.get(ii) // N times
- if (xx == yy) // N times
- return true // At most once
- return false // At most once

- So that's 4 things that happen N times + 3 things that happen once.
- But some of the things might be many operations:
  - ii < xs.size()? How many ops is xs.size() for an ArrayList?
    - Is "<" and the method call two separate things?
  - xs.get()? Again, for an ArrayList.
- It ends up being about ops(n) = 4n + 3, or O(n).

Let's consider some more:

- Finding the smallest value in a sorted list.
- Determining if any two items sum to 100.
  - Random list?
  - Sorted list?
- Finding the median value in the list.
- Finding the median value... with a LinkedList.
- Binary Search on an ArrayList.

- What if we have two lists? Let's consider a function that
  determines if there is some pair of items, one from xs and one from
  ys, that sum to 100.

**Wait a second: We want time!**

Let's consider that listContains method again.

- We really want time. How does that relate to "operations"?
- How long does "++ii" take?
  - This one's reasonably simple.
  - The int value ii will be stored in a CPU register, and increment is one
  machine instruction. It takes one clock cycle.
  - There are some complexities, but running on one core of 3 GHz CPU we can
  reasonably expect to be able to do about 3 billion integer increments in a
  second.
- How long does "xs.get(ii)" take?
  - Again, the integer value ii lives in a register.
  - The xs variable will be in a register too, but that's not the list, that's
  the address of the ArrayList object.
  - So we've got to fetch that object from memory.
  - But that's still not the list. The items are in an array which is referenced
  from a field of the object.
  - So we've got to fetch that from memory.
- How long does a memory fetch take?
  - If we need to go out to main memory, it could take 80ns or 240 clock cycles.
  - But there's cache. A best case cache hit might only take 4 clock cycles (or
    less than 2ns).
  - So the first call of xs.get(ii) might take 160ns, the second one might take
