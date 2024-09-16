---
title: "cs2010 Notes: 06 Boolean Logic"
date: "2024-09-08"
---

**AND (∧, ·, &)**

A  B  A & B 
0  0    0
0  1    0
1  0    0
1  1    1

**OR (∨, +, |)**

A  B  A | B
0  0    0
0  1    1
1  0    1
1  1    1


**NOT (¬, ~, !)**

A  !A
0   1
1   0

**Single Concrete Expressions**

We can use parens for grouping.

```(1 & 0) | (1 & 1)```

```(0 | 1) & (0 | 0)```


**Expressions with Two Variables**

```a | 1 & b | c```

Truth table:

A  B  C  =
0  0  0  0
0  0  1  1
0  1  0  1
0  1  1  1
1  0  0  0
1  0  1  1
1  1  0  1
1  1  1  1

Algebraic simplifcation:

```a | 1 & b | c = b | c```

Satisfiability:

 - We can find an input that makes this true: A=0, B=0, C=1


**Why do we care?**

 - The conditions for "if" and "while" in programming are boolean values,
   produced by evalating (extended) boolean expressions.
 - Digital circuits are made up of logic gates, which are boolean operators
   implemented in hardware. 

**Boolean Algebra**

http://www.toomey.org/tutor/harolds_cheat_sheets/Harolds_Discrete_Boolean_Algebra_Cheat_Sheet_2021.pdf
