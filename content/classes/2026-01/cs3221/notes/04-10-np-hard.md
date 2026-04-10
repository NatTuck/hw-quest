---
title: "Notes: 04-10 NP Hard"
date: "2026-04-08"
---

We've looked at a bunch of different complexity classes: O(log n), O(n), O(n log
n), O(n^2), O(n^30), O(2^n), etc.

## Decision Problems

A decision problem is a problem that where we need a single yes / no answer.

Examples:

1. Given a list of integers, are there any duplicates?
2. Given a graph and two vertices s and t, is there a path from s to t?
3. Given a boolean logic circuit with N inputs and one output, is there an
assignment of true/false values to the inputs that will give a true output?
4. Given a graph is there a cycle that visits every vertex exactly once?

Classifying the computational complexity of decision problems leads us to one of
the most famous / significant problems in theoretical computer science.

- What's the complexity of an algorithm to solve problem 1?
- Problem 2?
- Problem 3?

We can easily solve problems 1 and 2 in polynomial time, so we put them in a
class called P.

Most likely we neither came up with a algorithm for problem 3 in polynomial time
nor did we prove that no such algorithm exists. The problem is that there's no
way in general to pick the right assignment of inputs better than just trying
all possible combinations of inputs.

So our process for figuring out which assignment of boolean variables {a, b, c,
d, ...} goes like this:

- Guess that a is 0, recurse on {b, c, ...}
- Guess that a is 1, recurse on {b, c, ...}

Imagine for a moment our CPU could do non-deterministic guessing. We guess that
a is either 0 or 1 and recurse (non-deterministically) and then the return value
we end up with is an arbitrary set of guesses that returns true.

Now this takes O(n) recursive calls, rather than O(2^n). So on a
non-deterministic computer it takes poynomial time. This class of complexity is
called NP (non-deterministic polynomial).

Another way to look at this is that given a proposed solution with answer yes we
can check that solution in polynomial time.

Since yes and no aren't quite equivalent for decision problems:

- P: We can answer yes/no in polynomial time.
- NP: We can check a proposed "yes" answer in polynomial time.
- co-NP: We can check a proposed "no" answer in polynomial time.

The great question of CS: Does P = NP? Most people think no, but nobody's proved
it yet.

## NP-hard and NP-complete

A problem is NP-hard if solving it in polynomial time would imply that every
problem in NP could be solved in polynomial time.

Note that some NP-hard problems may be *harder* than the problems in NP.

A problem is NP-complete if it's NP-hard and in NP.

The textbook doesn't prove that problems are NP hard, but let's start with

- Circuit satisfiability (CircuitSAT) is NP-hard

To show that any other problem A is NP-hard, we need to reduce a known NP
hard problem to A (showing that if we can solve A, we can also solve the other
problem).

Let's consider another problem: Boolean formula satisfiability (SAT).

- We can reduce CircuitSAT to SAT by transcribing the circuit to a formula, so
SAT is NP-hard.

It's worth noting that we also can do the reduction the other way. These
problems are equivalent.

## Why is SAT exciting?

If P=NP and we had a polynomial time algorithm for SAT, we could break a bunch
of cryptography.

Most obviously, cryptographic hash functions.

y = SHA256(x): Takes any bit sequence x and produces a 256-bit output y. This
function isn't easily reversible. Given an output y, there's no better way to
calculate the input x than guess-and-check. Obviously this problem is in NP -
you can check answers in by running SHA256 which is a polynomial time
algorithm, but it's also clear how to do this: build a big circuit for SHA256,
bind the output bits to y (e.g. one output = bit1 and bit2, etc), and then run
the SAT solver on it.

Breaking hash functions would immediately break digital signatures, which would
make secure websites pointless, break all cryptocurrency, etc.

Breaking symmetric encryption is a little trickier. Let's see if we can figure
it out.

## 3SAT

Given boolean formula in conjunctive normal form with exactly three literals per
clause, find an assignment of variables that makes the formula true.

This is also NP-complete. We can reduce from CircuitSAT:

- Make sure every AND and OR gate has exactly two inputs. If one has more,
replace it with a chain of two-input gates.
- Every wire is a variable. We get a clause per gate: a = bc, a = b+c, or a = b'
- a = bc => (a+b'+c')(a'+b)(a'+c)
- a = b+c => (a'+b+c)(a+b')(a+c')
- a = b' => (a+b)(a'+b')
- We can expand two variable clauses into three variable clauses like this:
(a+b) = (a+b+x)(a+b+x') by adding a new variable x.
- Similarly, one variable clauses become four clauses with two new variables.

This transformation takes linear time and produces an output that's bigger than
the input by a constant factor.
