---
title: "cs2370 Notes: 31 Standard Forms"
date: "2025-04-09"
---

## Sum of Products form

- A series of clauses
- Each with a series of variables or negated variables ANDed together.
- The clauses are ORed together.
- Any boolean expression can be expressed in SoP.
- An expression can be transformed into SoP algebraically.

Example: ab!c+def+g!hi+adf

## Disjunctive Normal Form (DNF)

- The same as SoP, except each clause must mention every variable.
- An expression in DNF corresponds to the true rows of a truth table,
  so it may be up to 2^n clauses.
- An expression can be transformed into DNF by evaluating all possible
  inputs.

## Product of Sums Form

- A series of clauses, each combining terms with OR.
- Those clauses are ANDed together.
- Also can represent any boolean expression.

Example (a+b+!c)(!b+c+d)(b+!c)

## Canonical Conjunctive Normal Form (CNF)

- PoS, where each clause mentions every variable.
- Corresponds to the false rows of a truth table.

## Thinking about SAT

- A formula in SoP form is always satisfiable (unless it has zero clauses). Each
  clause is a satisfying assignment.
- A formula in PoS form is satisfiable if one term in each clause can be made
  true simultaneously.
- This means that conversion to SoP (including DNF) will find all satisfying
  assignments.
- SAT instances are typically specified in PoS form, since SoP instances are
  easy.

## Converting to DNF

 - Start with the HW starter code.
 - We want an OR at the top, ANDs under that, and terms under that.

## Overflow

 - Symbolic evaluation
 - Partial evaluation
 - Brute-force search
