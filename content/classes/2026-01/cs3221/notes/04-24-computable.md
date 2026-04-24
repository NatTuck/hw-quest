---
title: "Notes: 04-24 Computability"
date: "2026-04-22"
---

## Post Correspondence Problem

See demo: <https://pcp-game.homework.quest/>

## The Halting Problem

1. Computer programs are data in a computer.
2. That means we can write computer programs that take other computers as input
   and then do computations based on the input. We have plenty of programs that
   do this: compilers, static analysis tools, etc.
3. Can we write a computer program H that takes a program A as input and outputs
   whether A halts (e.g. exits) or not?

This is typically expressed in terms of Turing Machines. Let me outline those
quickly:

- We need an alphabet. We can pick any finite set of symbols (e.g. {0, 1}, {A ..
Z}, {0 .. 9,999} etc).
- We have a tape, with an unbounded series of cells. Each tape cell can contain
one symbol from the alphabet.
- The machine points to one cell on the tape, which can be moved one cell at a
time.
- We need a control table. For every possible {state, current tape cell} pair we
have a {value to write to tape, direction to move} pair. Direction can either be
left, right, or halt.
- At each step, the machine looks up what to do in the control table and does it
until the direction is halt.
- The machine input is the initial state of the tape.
- The machine output is the state of the tape when it halts.

This is sufficiently powerful to compute anything that any computer can compute,
although it frequently adds a factor of O(N) to the complexity of algorithms
since there's no random access to the tape - going 100 left takes 100 steps.

We can just as well talk about some simplified machine code or even code in a
high level language like Python.

So here's the trick:

```
def halts(fun1):
  # Assume this function returns True if
  # fun1 halts and False if it doesn't.

def troll():
  if halts(troll):
    loop_forever()

print(halts(troll))
```

There's no way to write a correct function `halts` that can handle `troll`.

- This is an *undecidable* problem.
- No algorithm can solve it in the general case.
- Not "no efficient algorithm can solve it". There isn't even an *inefficient*
algorithm to solve it.

It's possible to reduce the halting problem to PCP.

So we've got several categories of problem / algorithm:

- Very efficient: O(1), O(log n)
- Efficient: O(n), O(n log n)
- Technically efficient: O(n^2) or worse polynomial.
- Inefficient: O(2^n)
- Impossible: This stuff

Now let's see how we'd try to solve PCP better. Remember: Just because it's
impossible in general doesn't mean we can't solve it for specific cases.
