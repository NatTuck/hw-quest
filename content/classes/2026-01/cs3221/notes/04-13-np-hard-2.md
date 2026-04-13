---
title: "Notes: 04-13 NP Hard (2)"
date: "2026-04-11"
---

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
clause:

- Decision problem: Can it be satisfied?
- Non-decision problem: Find an assignment of variables that satisfies it.
(Makes the formula true)

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

## Maximum Independent Set

We're working with a simple, unweighted, undirected graph.

An *independent set* in G is a subset of the vertices of G with no edges
between them.

The MIS problem: Given a graph G and an integer *k*, does G contain an independent
set of size at least *k*?

Non-decision version: What's the set?

To show that this problem is NP-hard, we'll reduce 3SAT to it.

- First we reduce *any* instance of 3SAT to some instance of MIS in
polynomial time.
- Then we solve MIS on that graph.
- Then, for the non-decision problem, we want to be able to convert back in
polynomial time.

Our reduction:

- Each clause becomes three new vertices with edges connecting them into a
triangle. So if clause 4 is (a+b+c') becomes three vertices a4, b4, and c'4.
- Our MIS vertices will correspond to a set of variables (or negated variables)
that, if true, satisfy the 3SAT instance.
- In order to prevent a and a' from both being true, we put an edge from each a
  to each a' (and the same for every other variable to its negations).

If we had a polynomial time solver for MIS, we could:

- Convert any 3SAT instance to MIS in polynomial time.
- Run our solver.
- Solve 3SAT in polynomial time.

Therefore, MIS is NP-hard.
