---
title: "cs2370 Notes: 05 Functions"
date: "2024-01-31"
---

We've been using functions for a while, but where do they come from?

```python
def add2(xx):
    return xx + 2
```

And that's the whole story, any questions?



Maybe it's a bit more complicated than that.


```python
def square(xx):
    return xx * xx


def sqrt(xx):
    guess = 1
    while square(square(guess) - xx) > 0.01:
        guess = 0.5 * (guess + xx / guess)
    return round(guess, 1)
```


Two basic kinds of functions:

```python
def say_hello(name):
    print("Hello,", name)
    # return None
```

 - Functions that do stuff are said to have side effects.
 - Functions that just compute and return a value are said to
   be pure.
 - Functions that only exit for their side effects aren't really
   "functions" - other languages might call them procedures or
   subroutines.


## Designing a function:

 - Purpose statement
 - Signature (e.g. int -> int)
 - Examples
 - Stub
 - Standard pattern
 - Asserts
   
Design a function to:

 - Convert Farenheight to Celsius
   -  °C = (°F - 32) × 5/9
 - Given a numeric grade and the syllabus, determine if
   we passed the class
 - Reverse a string with a loop and an accumulator
   - Standard pattern: Single item or sequence?
   - For sequence, a for loop
 - Given a numeric grade and the syllabus, determine the
   letter grade (just the letter part)
 - Given two sports teams and their scores (t1, s1, t2, s2),
   determine which team won the game.
 - Print a square of a given size with "+-|" characters.
