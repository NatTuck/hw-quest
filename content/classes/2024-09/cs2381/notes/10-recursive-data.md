---
title: "cs2381 Notes: 10 Recursive Data"
date: "2024-09-17"
---

# Overhead

**Tutoring**

As everyone heard in Lab today, tutoring is happening now. I think
it's this room, 6pm-8pm, Monday-Thursday - but double check the signs
Stephanie will post everywhere.

I recommend everyone start the next homework immediately after class,
and bring it to tutoring to ask Alex for help.

**Intro to Programming: In Java**

This is intermediate programming, so we generally assume that everyone
is comfortable with concepts like declaring local variables and
iterating through lists using for loops.

But, I've noticed that several people have been having issues with
those concepts in lab.

If you want a review of programming basics concepts specifically in
the Java langauge, I recommend doing the Exercism exercies in Java. I
put a link on the course main page on Canvas.


# Recursive Data

Starter code at [doll-worldx.tar.gz](../doll-worldx.tar.gz).

First, we're going to have a doll wear a hat.

```java
public class App {
    public static void main(String args[]) {
        var h0 = new Hat("blue");
        var d0 = new Doll("darkgreen", h0);
        var world0 = new DollWorld(d0);
        BigBang.start(world0, "Dolls");
    }
}

record Hat(String color) {
    Image draw() {
        return new Triangle(80, "solid", color);
    }
}

record Doll(String color, Hat hat) {
    Image draw() {
        // Template gives us color, hat
        // So we have access to all methods of hat
        return new Circle(80, "solid", color)
            .overlayxy(-40, 75, hat.draw());
    }
}

class DollWorld implements World {
    Doll doll;

    DollWorld(Doll d0) {
        this.doll = d0;
    }

    @Override
    public Scene onDraw() {
        var bg = new EmptyScene(800, 600);
        var fg = doll.draw();
        return bg.placeImage(fg, 400, 300);
    }
}
```

Then we're going to make it more complicated.

```java
record Hat(String color) {
    Image draw() {
        return new Triangle(80, "solid", color);
    }
}

record Doll(String color, Hat hat) {
    Image draw() {
        // Template gives us color, hat
        // So we have access to all methods of hat
        return new Circle(80, "solid", color)
            .overlayxy(-40, 75, hat.draw());
    }
}

class DollWorld implements World {
    Doll doll;

    DollWorld(Doll d0) {
        this.doll = d0;
    }

    @Override
    public Scene onDraw() {
        var bg = new EmptyScene(800, 600);
        var fg = doll.draw();
        return bg.placeImage(fg, 400, 300);
    }
}
```

## Introducing Linked Lists

ArrayLists are one way to build lists.

Another way is a LinkedList, sometimes called a ConsList for
historical reasons.


```java
record IntList(int item, IntList rest) {
    /*
    Standard pattern: 
   
    int size() {
        ... item ...
        ... rest ...
        ... rest.sameMethod() ...
    }
    
    */

    int size() {
       return 1 + rest.size();
    }
}
```

This will let us build a list, but we've got a big problem to solve:

 - A list of length 0 has no items.
 - But an IntList record has one.
 - So we need to have zero IntList records.

Any reference in java can be ```null```. We can use this to represent
an empty list, just like we did with dolls. 

But this has some issues:

 - Null isn't really a value of whatever type, so this is kind of
   cheating our signature.
 - A null value doesn't have methods, so we need to manually check
   for null before calling methods.

```java
record IntList(int item, IntList /* or null */ rest) {
    int size() {
       if (next == null) {
          return 0;
       }
       else {
          // Now we have an IntList
          return 1 + next.size();
       }
    }
}
```


If we can avoid using null values, the langugage will do more work for
us in making sure we get our logic right.

Another way of looking at this is that a list is one of two different
types of object: An empty list or a non-empty list.

To have our code do that, we need a way name a group of types - we've
got two ways to do that: interfaces and inheritence.

So let's try that:

```java
interface IntList {
    boolean isEmpty();
    int first();
    IntList rest();
    int length();
}

record IntEmpty implements IntList {
    @Override
    public boolean isEmpty() {
        return false;
    }
    
    @Override
    public int first() {
       throw new RuntimeError("empty list");
    }
    
    @Override
    public int rest() {
       throw new RuntimeError("empty list");
    }

    @Override
    public int size() {
       return 0; 
    }
}

record IntCell(int first, IntList rest) implements IntList {
    @Override
    public boolean isEmpty() {
        return false;
    }
    
    @Override
    public int size() {
       return 1 + rest.size(); 
    }
}
```

Dynamic dispatch:

 - When a method is called on an object of an Interface type like an
   IntList, the method of the appropriate concrete type (like IntEmpty
   or IntCell) gets called.
 - This is functionally similar to the if / else statement in the version
   using null.
 - Explicitly compare the two patterns.

Overflow - design more methods:

 - Sum
 - Max

Next step: Make it generic







