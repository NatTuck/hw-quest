---
title: "cs2381 Notes: 04 Cannonball"
date: "2023-08-29"
---

## Startup

 - There should be tutoring now. I think they're actually in this room.
 - Review design recipe for method steps
   - See post on course site
 - Delay attendence until after the first example.


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

# Take Attendence

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
        // Problem: We can't test this, because we can't
        // compare image equality.
        //
        // That's how it is.
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

        // Eventually move this to Ball
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
            // Move this to a helper.
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

