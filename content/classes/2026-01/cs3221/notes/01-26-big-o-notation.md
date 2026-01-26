---
title: "Notes: 01-24 Big-O Notation"
date: "2026-01-21"
---

## The songs from last time

- Assuming that any number is one "word":
- Beer had a length in words of 15 + 2n.
- Assuming all presents are four words long, Christmas had a length in words of
sum(1..n) of (7 + 4 * (1 + 2 + 3 + ... + n)).
- We can apply *Gauss's formula*: (n(n+1))/2.

## To Big-O

- Sometimes we care about exact numbers.
- Usually we're mostly interested in running stuff on computers.
- "Will it run on a computer" is a question about pretty big numbers. Today,
with gigahertz, gigabytes, terabytes, teraflops, numbers in the billions or
trillions.
- If we're asking "will the song fit in RAM", then one million and five million
are basically the same.
- We really want to catch that "N Days of Christmas" grows much faster than "N
Bottles of Beer".

So we'll commonly be using "asymptotic notation", where we take math expressions
and keep just the largest term without any coefficient.

- $$ 2x^3 + 5x^2 + 27 $$ becomes just $$ x^3 $$.

We then use one of the following notations to use that as an asymptotic bound:

- Big-O: f(x) is O(g(x)) means that as x grows to infinity, f(x) doesn't grow faster
than g(x) if we ignore a constant factor.
- Big-Omega: f(x) is \Omega(g(x)) means that as x grows to infinity, f(x) doesn't grow faster
than g(x) if we ignore a constant factor.
- Big-Theta: f(x) is \Theta(g(x)) means f(x) doesn't grow faster or slower than g(x) if we
ignore a constant factor.

To be exact:

f(x) is O(g(x)) means:

- You can pick constants K, x0 such that
- f(x) < K(g(x)) for all x > x0

Let's try that with a couple values. Prove as much of the
following hierarchy as we can:

- f(x) = K, for any constant K is our slowest class:  \Theta(1)
- f(x) = log(x) grows faster; \Theta(log(n))
- f(x) = sqrt(x) grows faster; \Theta(sqrt(n))
- f(x) = (K)(x) for any constant K; \Theta(x)
- f(x) = x log x (any log base, any constant coefficients); \Theta(x log x)
- f(x) = $x^K$ for K = 2,3,4 each grow faster
- f(x) = $2^x$ grows even faster than that.

A tight big-O bound is a lot like a big-Theta bound. If you see just O(f(x)) in
a context where the writer isn't being pedantic about the definitions, it's
likely they're implying a tight bound and specifying basically the big-Theta
class rather than the broader lose-big-O class.

## Overflow

That was the songs with words.

Can we show that the complexity classes are different if we count
characters instead of words? Numbers spelled out as words?
