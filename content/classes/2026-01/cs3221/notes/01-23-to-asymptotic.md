---
title: "Notes: 01-23 Big-O Notation"
date: "2026-01-21"
---

## Counting and Pretty Math

Let's quickly look at a problem from lab yesterday, give a long answer, and
then write it with fancy math notation.

```python
import math

def beer_song(nn):
  text = ""

  for ii in range(0, nn):
    text += f"{ii} beers, {ii} beers\n"

  return text

def song_len(nn):
  return len(beer_song(nn))
```

Handle numbers, song:

```python
import math

def num_len(nn):
    return len(str(nn))


def num_len_math(nn):
    if nn <= 0:
        return 1
    else:
        return 1 + math.floor(math.log10(nn))


def song_len_math(nn):
    sum = 0
    for ii in range(0, nn):
        sum += 15 + 2 * num_len_math(ii)
    return sum

print(0, num_len(0), num_len_math(0))

for ii in range(1, 10):
    xx = 2**ii

    print(xx, num_len(xx), num_len_math(xx))
```

Format in Pandoc markdown:

```md
Here's the number length function:

$$
    \text{nlen}(x) =
    \begin{cases}
        1 & x \le 0 \\
        \lfloor \log_{10}(x) \rfloor & otherwise
    \end{cases}
$$

And here's the full (simplified) song length function:

$$
\text{slen}(x) = \sum_{i=1}^{x}(2(\text{nlen}(i))+15) 
$$
```

## Which Song is Bigger?

```python
def gift_song(nn):
  text = ""

  for ii in range(1, nn + 1):
    text += f"on day {ii}, I got\n"
    for jj in range(ii, 0, -1):
      text += f"item {jj}; "
    text += "\n\n"

  return text

for ii in range(0, 10):
    xx = 2**ii

    print(xx, song_len(xx), len(gift_song(xx)))
```

A better question: Which song grows faster as `nn` grows?

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
