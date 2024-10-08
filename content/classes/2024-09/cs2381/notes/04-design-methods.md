---
title: "cs2381 Notes: 04 Designing Static Methods"
date: "2024-09-03"
---

## Startup

## Maven Project Concepts

Grab the demo archive from the course website.

 - Tar archives
   - Packing
   - Unpacking
 - Maven
   - clean
   - compile
   - test
   - verify
   - exec:java
   - combo: compile exec:java
 - VSCode
   - Snap is sketchy - maybe we'll try the real package

## Design Recipe for a Method

To design a method, follow the design recipe:

 - Javadoc
   - Purpose statement
   - @param lines
   - @return line
 - Stub method
   - static, Name, return type, argument names with types
 - Tests
   - Based on problem statement, write one or more tests
 - Standard pattern
   - Which argument are you primarily operating on?
   - Based on the type of the primary argument to the method, what’s
     the normal thing you do with one of those?
 - Write the function body
 - More tests
   - Add tests that exercize any code in the function body
     that isn't covered yet.
   - Add tests for edge cases.


## Example problem

In the course syllabus, it gives a mapping from percentage scores to
letter grades. An F is a failing grade, while any other grade passes.

Design a static method called passingScore that takes a percentage
score as a floating point number and returns a boolean value
indicating whether that score would pass the class.

We'll start with the demo starter from the course website.

**Javadoc**

```java
/**
 * Is this a passing score?
 *
 * @param  score  The percentage score, typically from 0.0 to 100.0
 * @return        True for a passing score, else false.
 */
```

**Stub method**

```java
// In new file main/.../Prob.java

// public class Prob {

static boolean passingScore(float score) {
    return false;
}
```

**Initial Tests**

```java
// In test/.../ProbShould.java

import static demo.Prob.passingScore;

public class ProbShould {

    @Test
    void determine_if_scores_pass() {
        assertEquals(passingScore(85.0f), true);
        assertEquals(passingScore(27.3f), false);
    }
```

**Standard Pattern**

 - We're doing something with ```score```.

```java
static boolean passingScore(float score) {
   ... score ...
}
```

**Body**

Pull up the course syllabus to find the pass threshold.

Note: Generally want no top level "if" in boolean function.


```java
static boolean passingScore(float score) {
    if (score > 60) {
       return true;
    }
    else {
       return false; 
    }
}
```

```java
static boolean passingScore(float score) {
    return score > 60;
}
```

**More Tests**

```
    void determine_if_scores_pass() {
        assertEquals(passingScore(85.0f), true);
        assertEquals(passingScore(27.3f), false);
        // edge case
        assertEquals(passingScore(60.0f), true);
    }
```

Run the tests. Fix the bug.


## More examples:

 - Calculate the area of a rectangle.
   - Two args, no single primary, so we'll do something with
     both.

## Review of Lab 02

Extended concepts
