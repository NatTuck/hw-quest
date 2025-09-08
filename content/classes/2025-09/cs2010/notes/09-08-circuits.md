---
title: "cs2010 Notes: 09-08 Circuits"
date: "2025-09-06"
---

## Designing Circuits


We've got a hallway with two lights.

- Build a 4 tall by 11 long wall.
  -- //wand
  -- build 4 tall tower
  -- right click top
  -- left click ground 11 blocks away
  -- //set stone_bricks
- Switches at each end.
- Lights 3 apart in the middle of the "ceiling".
- Throw redstone dots on blocks outside to pass through switch status
- Throw a "circuit breaker switch" in the middle.

- Show //copy, //paste when that's built.

Three inputs: A, B, C

One output: Light

Rules:

- If C is off, the lights are off.
- If C is on, then:
  - If both switches are off, the lights are off.
  - Flipping either switch should always change the state
    of the lights.

Truth table:

| C | A | B | Lights |
|---|---|---|--------|
| 0 | 0 | 0 |   0    |
| 0 | 0 | 1 |   0    |
| 0 | 1 | 0 |   0    |
| 0 | 1 | 1 |   0    |
| 1 | 0 | 0 |   0    |
| 1 | 0 | 1 |   1    |
| 1 | 1 | 0 |   1    |
| 1 | 1 | 1 |   0    |

Reading out sum of products:

- We can easily come up with an expression to output 1 only
  when we have an exact input: AND together the inputs that
  are 1 and the not of the inputs that are zero.
- If multiple inputs give a 1 output, OR those together.
- This is a standard form for boolean expressions, called Sum 
  of Products form.

CA'B + CBA'

Let's build that circuit.


## Simplifying with Boolean Algebra

If you've got a regular algebra expression like `awx + ayz`,
you can transform it into other equivalent expressions using
algebraic laws.

We can apply the distributive law, and undistribute the `a`
to get `a(wx + yz)`.

Boolean algebra also has laws:

- Associativity of AND and OR:
  - abc = a(bc) = (ab)c, etc
  - a+b+c = a+(b+c) = (a+b)+c
- Commutativity of AND and OR:
  - ab = ba ; a+b = b+a
- Distribution of AND over OR and OR over AND:
  - a(b+c) = ab+ac
  - a+bc = (a+b)(a+c)
- Identity:
  - 1a = a
  - 0+b = b
- Annihilation:
  - 0a = 0
  - 1+a = 1
- Idempotence:
  - a+a = a
  - aa = a
- Complementation:
  - aa' = 0
  - a+a' = 1
- De'Morgan's Laws
  - x'y' = (x+y)'
  - x'+y' = (xy)'

So we can simplify our circuit by transforming `CA'B + CBA'` into
`C(A'B + AB')` (which law?)

Let's build that.


## Lab Notes

- Start with a schematic that gives input and output widgets.
- Two two-bit inputs, one 3 bit output.
- Build a 2-bit adder.
- First, write down the formulas for each of the three output
  bits as a function of the four input bits.
  - Build a truth table.
  - Pull out SoP form.
  - Simplify with boolean algebra (if possible), to minimize the
    number of gates - possibly considering shared gates.
- Then build the circuit.
- Show it working for three cases.
- To submit:
  - Truth tables.
  - SoP form.
  - Simplified form.
  - Screenshot of the circuit.
  - Screenshot of three cases.
