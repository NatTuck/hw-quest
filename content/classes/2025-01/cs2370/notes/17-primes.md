---
title: "cs2370 Notes: 17 Primes"
date: "2025-03-04"
---

Finding prime numbers.

Goal: Given an integer N (N > 1), find all the prime
numbers less than N.

The plan:

 - A prime number is a number with no factors (integer divisors) other
   than itself and 1.
 - We can check if X is divisible by Y using ```X % Y == 0```
 - We can find all the numbers from 2 to N with a for-range loop.
 - We can find only prime numbers by excluding non-primes from
   our result list.
 - The only candidate divisors for X are between 2 and X, so
   if none of those evenly divide X then X is prime.


Version 1:

```python

# ref: https://t5k.org/howmany.html

def is_prime(xx: int) -> bool:
    for ii in range(2, xx):
        if xx % ii == 0:
            return False
    return True


def list_primes(nn: int) -> list[int]:
    """List all the primes below nn."""

    ys = []
    
    for ii in range(2, nn):
        if is_prime(ii):
            ys.append(ii)

    return ys


def count_primes(nn):
    return len(list_primes(nn))
        

import sys

if __name__ == '__main__':
    nn = int(sys.argv[1])
    if nn <= 100:
        print(list_primes(nn))
    print("count =", count_primes(nn))
```

Improvements:
 
 - We only need to check candidate divisors that are prime. If
   X is divisible by a non-prime Y, then it's also divisible by
   all of Y's prime factors.
 - We only need to check candidate divisors from 2..sqrt(X), because
   if some Y > sqrt(X) divides X then X/Y must be an integer from
   2..sqrt(X) that also divides X.
 - We can skip evens > 2.
