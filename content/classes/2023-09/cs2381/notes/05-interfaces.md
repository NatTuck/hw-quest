---
title: "cs2381 Notes: 05 Interfaces"
date: "2023-09-07"
---

**Kinds of data do we have so far**

Primitive data types:

 - Single values
 - Not instances of classes / records (not created with "new")

Objects:

 - Composite values, with potentially multiple fields.
 - A Car(tankSize, mileage) is (a double) AND (a double)
 - A Doll(color, hat) is (a String) AND (a Hat)
 - Fields can be primitive values or objects.
 - Can be nested or even recursive.
 
New thing - Interfaces:

 - What if we want to represent one of several different options?
 - A Toy is (a Doll) or (a Puzzle)
 - In Python, we have dynamic types, so we can just do this.
 - In some languages there are "union types".
 - In Java, we've got two options: Inheritence and Interfaces
 - Inheritence and Interfaces are very similar, but Interfaces are
   a bit more useful, so we'll focus on those.

**Starter Code**
 
```java
public class App {

    public static void main(String[] args) {
        var c1 = new Circle(10);
        var c2 = new Circle(12);

        printBigger(c1, c2);
    }

    static void printBigger(Circle xx, Circle yy) {
        if (xx.area() > yy.area()) {
            System.out.println("Bigger is: " + xx);
        }
        else {
            System.out.println("Bigger is: " + yy);
        }
    }
}

record Circle(double radius) {
    double area() {
        return Math.PI * Math.pow(radius, 2);
    }
}
```

Let's make this more complicated:

```java
record Square(double width) {
    double area() {
        return Math.power(width, 2);
    }
}

// Now let's compare a Square to a Circle...
    public static void main(String[] args) {
        var c1 = new Circle(10);
        var c2 = new Circle(12);
        var s1 = new Square(10);

        printBigger(c1, s1);
    }
```

That... doesn't compile. Because the method doesn't take Squares.
Let's fix that:

```java
interface Shape {
    double area();
}

record Circle(double radius) implements Shape {
    public double area() {
        return Math.PI * Math.pow(radius, 2);
    }
}

record Square(double width) implements Shape {
    public double area() {
        return Math.pow(width, 2);
    }
}
```

# Attendence

## Stuff from Lab01

**Core Strategy For Assignments**

 - Expect to get stuck at least once
 - Plan to get stuck soon enough to have time to get unstuck - optimally get
   stuck *in lab* on Tuesday.
 - Make sure your program builds and runs. If the way you're stuck is that
   the program won't compile and you don't know why, start over.
 - Use help resources: Tutoring and my office hours.

**Let's Solve It**

 - Download Lab01
 - Using 7zip, inspect the archive graphically.
 - Unpack it.
 - Run 'mvn verify -q'
 - Run the Perl script
 - Run mvn verify
 - Go look at the tests
 - In the tests, match up literals to variables.
 - Put the resulting formulas in Rocket.java
 - Run the tests again.
 - Pack up the archive.
 - Using 7zip, inspect the new archive graphically.
   - Note that the new structure is the same as the old structure.
 - Submit to Inkfish

## Overflow: Drawable interface example

 - Doll, Hat, and Robot

