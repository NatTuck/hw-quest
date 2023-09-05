---
title: "cs2381 Notes: 04 Nesting Dolls"
date: "2023-09-05"
---

## Startup

 - There should be tutoring now. I think they're actually in this room.
 - Delay attendence until after the first example.

## Record from Class: Car

**Simple Class**

```java
class Car {
    double tankSize; // gallons
    double mileage; // mpg
}
```

Problem: Those fields are mutable.

Why that's a problem:

 - Unexpected mutation can create unexpected bugs.
 - Immutable structures are easier to reason about.
 - The bugs and reasoning considerations become much more
   significant in concurrent and distributed programs.

**Add ```final``` to each field**

Problem: Can't say ```new Car(10.0, 20.0)```

**Add Constructor**

```java
    Car(tankSize, mileage) {
        this.tankSize = tankSize;
        this.mileage = mileage;
    }
```

Problem: No accessor methods.

**Add accessors**

Convention in Java says that a method should't access fields on
an instance of a different class. This allows interfaces to change,
for example we might decide we want a maxRange to be a field and
mileage to be calculated.

```
    double tankSize() { return this.tankSize; }
    double mileage() { return this.mileage; }
```


Problem: No equals, toString, or hashCode method

**Add equals method**

```java
    boolean equals(Object obj) {
        if (obj instanceof Car) {
            Car that = (Car) obj;
            return this.tankSize == that.tankSize
                && this.mileage == that.mileage;
        }
        else {
           false; 
        }
    }
    
    // toString and hashCode are also free with a record
```

# Take Attendence

## Nesting Dolls Example

First, we're going to have a doll wear a hat.

```java
import image.*;
import world.*;

public class App {
    public static void main(String args[]) {
        var h0 = new Hat("blue");
        var d0 = new Doll("darkgreen", h0);
        var world0 = new DollWorld(d0);
        world0.bigBang();
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

class DollWorld extends World {
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

Let's do nesting dolls.

```java
record Doll(String color, Doll inner) {
    int depth() {
        if (inner == null) {
            return 1;
        }
        else {
            return 1 + inner.depth();
        }
    }

    Image draw() {
        // Template gives us color, inner
        var img = new Circle(20 * depth(), "solid", color);
        if (inner == null) {
            return img;
        }
        else {
            return img.overlay(inner.draw());
        }
    }
}

    public static void main(String[] args) {
        var d4 = new Doll("pink", null);
        var d3 = new Doll("blue", d4);
        var d2 = new Doll("yellow", d3);
        var d1 = new Doll("green", d2);
        var d0 = new Doll("orange", d1);
        var world0 = new DollWorld(d0);
        world0.bigBang();
    }
```

## Overflow: 

 - Go back to Car and show toString for both
   a record and manually.
