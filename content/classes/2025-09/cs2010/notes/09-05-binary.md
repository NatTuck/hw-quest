---
title: "cs2010 Notes: 09-05 Binary Numbers and Logic"
date: "2025-08-27"
---

## Boolean Logic

At the grocery store, the policy is that a clerk should request an ID from a
customer if they try to buy beer.

They should sell the beer to the customer only if the presented ID is legitimate
and it shows an age over 21.

Alice tries to buy beer at the grocery store and hands over her ID.

The ID shows an age of 23.

The ID is obviously fake.

Should the clerk sell Alice the beer?

This rule can be expressed as a logical proposition:

A = old enough?
b = id valid?

if (A and B) then sell beer, otherwise don't.

Historically, analyzing this sort of logical proposition was a philosophy thing.
They were trying to figure out mathematically what it meant to live a good life,
whether God exists, etc.

They didn't answer all of life's questions, but eventually a guy named Boole did
come up with an algebra of true and false statements. And that Boolean algebra
is the mathematical basis for modern electronics.

It's pretty simple:

- Two values: true, false
- Three operations: and, or, not

We can describe / define the operations using truth tables.

Write out tables for and, or, not.

Writing down logical expressions:

- AB + C
- (A + B')(B + C)'

(Why is OR addition and AND multiplication?)

## Regular Arithmetic

If we have one bit, boolean logic is very useful.

But when we use multiple bits to represent numbers, we also want to do regular
arithmetic. Good news, we learned that in elementary school.

  0 1 1 0
+ 1 0 1 1
---------
1 0 0 0 1 (don't forget the carries)

Binary subtraction, multiplication, and division also all work fine using the
elementary school procedure. Just remember that the only digits are 0 and 1.


## Adding using logic

- A plus B, one bit
- S (sum) digit = A or B
- C (carry) digit = A and B


## Logic gates and circuits

- AND is flat and round
- OR is indented and pointier
- not is a triangle with a circle on the tip

## Logic gates in Minecraft

- Show the basic logic gates from the textbook working.

## Half-adder in Minecraft

- Show a half-adder. Keep in mind that XOR is (A + B)(AB)' and
  we already have AB.


