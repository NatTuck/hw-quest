---
title: "cs2381 Notes: 09-03 Instance Methods"
date: "2025-09-01"
---

Let's write a static method that calculates the area of a square.

I'm going to ignore the design recipe for a moment for speed.


```java
// Calculate area of square.
static double area(double width) {
    return width * width;
}
```

Next, let's write a method that calculates the area of a circle. Note
that the Math class is available by default.


```java
// Calculate area of circle.
static double area(double radius) {
    return Math.PI * Math.pow(radius, 2.0);
}
```

Problem: Can't have two methods with the same name and the same
argument types.

Digression: We can have two methods with different arguments; that's
called method overloading.

```java
// Calculate area of rectangle.
static double area(double width, double length) {
    return width * length;
}
```

Solutions:

 - Give the methods different names (```rectangleArea```, ```circleArea```)
 - Put the static methods in different classes (```Rectangle.area```, ```Circle.area```)
   - Some languages make this the normal solution, usually called "modules".
 - Have Rectangle and Circle objects with instance methods.

```java
class Square {
    final double width;
    
    Square(double width) {
       this.width = width; 
    }

    double area() {
        return width * width; 
    }
}

class Circle {
    final double radius;
    
    Circle(double radius) {
       this.radius = radius; 
    }

    double area() {
        return Math.PI * Math.pow(radius, 2.0);
    }
}
```

Why would we want this?

 - The language will remember what our numbers represent (square or circle)
   and we structrually can't call the wrong area function by mistake.
 - We get to use the same short name for both methods without any interferance.
 


```python
from math import pi

class Circle:
    def __init__(self, radius):
        self.radius = radius

    def area(self):
        return pi * pow(self.radius, 2)

class Rectangle:
    def __init__(self, width):
        self.width = width

    def area(self):
        return self.width * self.width

shapes = [Circle(2), Rectangle(2)]

for sh in shapes:
    print("area =", sh.area())
```

 - This called "duck typing". If it looks like a duck, and quacks like a duck,
   and has method called "quack", we can call that method.
 - This works in a dynamic language like Python, but not in a static language
   like Java.

```java
import java.util.List;

public class App {
    public static void main(String[] args) {
        Circle ci = new Circle(2);
        Square sq = new Square(2);

        List<Circle> shapes = List.of(ci, sq);
        // List shapes = List.of(ci, sq);

        for(var sh : shapes) {
            System.out.println("area = " + sh.area());
        }
    }
}
```

 - Doesn't work, because Java's Object class doesn't have an area
   method and we can't name the type of the items in the list.
 - We want "polymorphism", where we can do the same thing to objects
   of different types. And Java will do that if we ask correctly.
 

Solution 1: Inheritence

```java
class Shape {
    double area() { return 5.0; }
}

//abstract class Shape {
//    abstract double area();
//}

class Square extends Shape ...

class Circle extends Shape ...

main() {
        List<Shape> shapes = List.of(ci, sq);
```

 - All objects of type Shape have an area method that returns a double.
 - Square and Circle are both subclasses of Shape (all Circles are Shapes)
 - our List is a list of Shapes

This is the most traditional approach, but it has some drawbacks:

 - In Java, each class can only have one superclass.
 - The "is a" relationship can be tricky. Sure, Circle is a Shape, but
   is a Horse a Vehicle?
 - Records can't extend any custom class.


A similar and more recent concept in Java is "interfaces".

```java
interface Shape {
    double area();
}

class Square implements Shape {
    public double area() { ...

class Circle implements Shape {
    public double area() { ...

main() {
        List<Shape> shapes = List.of(ci, sq);
```

 - A class can implement more than one interface.
 - No "is a" relationship is implied. Only that this object
   provides a certain interface (or collection of methods)
 - This is closer to "duck typing"; we could have a Ducklike interface
   that includes a quack method.
 - Records can implement interfaces.

Summary, for now:

 - Polymorphism is the biggest functional benefit we get out of
   instance methods, although namespacing is pretty nice too.
 - We're going to prefer interfaces, mostly because we use a lot of records.
 - Functionally, these concepts are pretty close.


Design method for a record:

 - Let's design through a Rectangle record with an area method, using the
   design method page on the web site.
 - Then let's have it implement Shape.
