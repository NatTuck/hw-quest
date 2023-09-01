---
title: "cs2381 Notes: 03 Designing Methods"
date: "2023-08-29"
---

## Startup

 - Announce Lab01 extension to Tuesday:
   - Lab software issues.
   - No tutoring on Labor Day.
 - Delay attendence until after the first example.

## Design Recipe for a Method

To design a method, follow the design recipe:

 - Stub method
   - Name, return type, argument names with types, static?
   - Trivial return statement if needed
 - Javadoc
   - Purpose statement
   - @param lines
   - @return line
 - Examples
   - Based on the problem statement, write one or more examples
 - Initial Tests
   - Translate the examples into tests
 - Template
   - Based on the arguments to your method, figure out what you
     have to work with and write that down.
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

**Stub method**

```java
// In new file main/.../Prob.java

// public class Prob {

static boolean passingScore(float score) {
    return false;
}
```

**Javadoc**

```java
/**
 * Is this a passing score?
 *
 * @param  score  The percentage score, typically from 0.0 to 100.0
 * @return        True for a passing score, else false.
 */
```

**Examples**

```java
// 75.0 => true
// 30.7 => false
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

**Template**

What do we have access to in this function body?

 - The arguments
 - "this", if the method isn't static

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

