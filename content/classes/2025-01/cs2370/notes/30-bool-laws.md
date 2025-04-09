---
title: "cs2370 Notes: 30 Transforms"
date: "2025-04-07"
---

Review the code in the scratch repository.

- Note how the parse code can't just be accomplished with
  a single pass through the input.

## Simplifying Boolean Expressions

Stuff that obviously simplifies:

**We can eliminate double negations**

- Not(Not(x)) => x

**We can eliminate all literal 0's or 1's, unless
the expression is just a 0 or 1.**

- a+1 => 1
- a+0 => a
- a1 => a
- a0 => 0

**We can eliminate duplicate variables or duplicate clauses.**

- aba => ab
- a+a => a
- ab+ab => ab
- (a+b)(a+b) => ab

**Some other rules**

- a!a => 0
- a+!a => 1

**And some legal transformations that might help.**

- a(b+c) <=> ab+ac
- a+bc <=> (a+b)(a+c)
- !a!b <=> !(a+b)
- !a+!b <=> !(ab)

## Let's build an example

- Specifically, literal elimination.

## Disjunctive Normal Form (DNF)

- A series of clauses
- Each with a series of variables or negated variables ANDed together.
- The clauses are ORed together.
- Any boolean expression can be expressed in DNF.
- An expression in DNF corresponds to a truth table.
- An expression can be transformed into DNF either algebraically or
  by repeated evaluation. 

