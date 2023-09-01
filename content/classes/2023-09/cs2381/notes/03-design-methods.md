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

# Take Attendence

## Extended Bird Example

Starter code:

```java
class BirdMain {
    static Bird biggerBird(Bird aa, Bird bb) {
		if (aa.weight > bb.weight) {
			return aa;
		}
		else {
			return bb;
		}
	}

	public static void main(String args[]) {
		Bird b1 = new Bird();
		b1.color = "blue";
		b1.weight = 7.0; // pounds
        
		Bird b2 = new Bird();
		b2.color = "red";
		b2.weight = 9.0; // pounds

		var b3 = biggerBird(b1, b2);

		System.out.println("Biggest bird is " + b3.color);
	}
}

class Bird {
    String color;
    double weight;
}
```

Let's redo biggerBird, going through the design process.

**Stub**

```java
    static Bird biggerBird(Bird aa, Bird bb) {
        return aa;
	}
```

**Javadoc**

```
/**
 * Find the bigger bird
 *
 * @param  aa  The first bird
 * @param  bb  The second bird
 * @return     The bigger bird, by weight
 */
```

**Examples**

```
// Bird("red", 5.0), Bird("blue", 7.0) => Bird("blue", 7.0)
```

**Initial Tests**

We don't have a testing framework, so let's write a test method.

We'll skip the design recipie here.

```java
static assertEquals(Bird aa, Bird bb) {
   if (aa.equals(bb)) {
      System.out.println("pass");
   }
   else {
      System.out.println("** FAIL **"); 
   }
}
```

Then we can just stick our tests in the main method.

```java
		Bird b1 = new Bird();
		b1.color = "blue";
		b1.weight = 7.0; // pounds
        
		Bird b2 = new Bird();
		b2.color = "red";
		b2.weight = 5.0; // pounds

        Bird b3 = biggerBird(b1, b2);
        
        assertEquals(b1, b3);
```

**Template**


```java
    static Bird biggerBird(Bird aa, Bird bb) {
        // Generally bad practice to access fields on instances other classes, 
        // we'll fix that shortly
        aa.color
        aa.weight
        bb.color
        bb.weight
	}
```

**Body**

```java
    static Bird biggerBird(Bird aa, Bird bb) {
        if (aa.weight > bb.weight) {
            return aa;
        }
        else {
            return bb;
        }
	}
```

**More Tests**


```java
        Bird b4 = biggerBird(b2, b1);
        assertEquals(b1, b4);
```

**equals method**

 - Java doesn't give us an equals method by default on classes.
 - Two objects are equal if their fields are all equal.

```java
    bool equals(Bird other) {
        // Template: this, other
        return this.color.equals(other.color) && this.weight == other.weight;
    }
```

**give it a try**

**constructor and getters to clean up**

```java
class Bird {
    String color;
    double weight;
   
    Bird(String color, double weight) {
       this.color = color;
       this.weight = weight;
    }
    
    String color() { return this.color; }
    double weight() { return this.weight; }
}
```

And go through and make that consistent.

**now let's make it a record**

```java
record Bird(String color, double weight) {}
```

This gives us:

 - Constructor
 - Getters
 - equals method
 - a couple other standard methods
 - immutability

And we'll go back through and make any more needed changes.


## Lab 01

 - Open it up
 - Reiterate that students only need to change Rocket#tick and Rocket#burn

## Cannonball example 

Launch with number key, that's initial velocity in +x.

Can we modify it to shoot up at a 45 degree angle?

```java
import image.*;
import world.*;

public class CannonApp {
    public static void main(String args[]) {
        var world0 = new CannonWorld(null);
        world0.bigBang();
    }
}

record Ball(float x, float y, float vx, float vy) {}

class CannonWorld extends World {
    Ball ball;

    CannonWorld(Ball b0) {
        this.ball = b0;
    }

    @Override
    public Scene onDraw() {
        var bg = new EmptyScene(800, 600);
        if (ball != null) {
            var ball_img = new Circle(20, "solid", "black");
            return bg.placeImage(ball_img, ball.x(), 600 - ball.y());
        }
        else {
            return bg;
        }
    }

    @Override
    public CannonWorld onTick() {
        if (ball == null) {
            return this;
        }

        var b1 = new Ball(this.ball.x() + this.ball.vx(),
                          this.ball.y() + this.ball.vy(),
                          this.ball.vx(),
                          this.ball.vy() - 2);
        return new CannonWorld(b1);
    }

    @Override
    public CannonWorld onKey(String ke) {
        try {
            int vx = Integer.parseInt(ke);
            var b1 = new Ball(0, 600, vx, 0);
            return new CannonWorld(b1);
        }
        catch (NumberFormatException ee) {
            return this;
        }
    }
}
```

## Overflow

Pull lab01 and design Rocket#tick using the recipe.

