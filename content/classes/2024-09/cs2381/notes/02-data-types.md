---
title: "cs2381 Notes: 02 Simple Data"
date: "2024-08-27"
---

## Introducing Java

I expect that you're familiar with Python.

This semester we're going to be working in Java. 

It makes sense to think of computer programming as one skillset. Many
of the concepts and techniques you learned in Python still apply in
Java. But there are significant differences and new stuff in the new
language as well.

The differences include the basic model of how a program is
structured.

In Python, a program is:

 - A collection of modules, each in its own file.
 - A module contains statements, which includes
   defining functions and classes.
 - One module in the program is the main module.
 - The program runs by executing statements from the main
   module in order.
 - Some statements cause conditional, repeat, or delayed execution,
   which makes things complicated.

```python
#!/usr/bin/env python

def greet(name):
    print("Greetings, " + name)

greet("Alice")
greet("Bob")
```

Now let's look at a similar program in Java:

```java
public class Greet {
    public static void main(String[] _args) {
        greet("Alice");
        greet("Bob");
    }

    static void greet(String name) {
       System.out.println("Greetings, " + name); 
    }
}
```

Run that with:

```bash
$ javac Greet.java
$ java Greet
```


In Java, we start by defining a class. Python has classes, but we
didn't need one for this program. In Java, you always need a class.

In Java, a program is:

 - A collection of packages (like Python modules), each of which lives
   in its own directory.
 - Each package contains a collection of classes, some of which get
   their own file.
 - A class contains methods. 
   - There are no functions (for now), just methods.
 - Methods contain statements. 
 - There is a main package, with a main class, which has a main method.
 - The program runs by executing the statements in that main method in order.
 - Definitions are not statements. The order of class and method declarations
   doesn't matter.

Try this:

```python
#!/usr/bin/env python

greet("Alice")
greet("Bob")

def greet(name):
    print("Greetings, " + name)
```

In Python:

 - Defining a function *is* a statement.
 - It happens in order.

Similarities:

 - Functions and static methods work similarly - you can name a sequence of
   statements and call it with arguments.
 - Both languages have strings, which look the same and can
   be concatenated with a "+" operator.
 - Both languages have operators.
 - Both languages have a way to print to the console.

Differences:

 - Java code always exists in a class, even if you're not trying to describe
   a new class of data.
 - Java has explicit, static types. The name parameter of the greet method is
   a String - we need to say that, and the compiler will check that we don't pass
   in anything else (try ```greet(5)```).
 - Java writes blocks with curly braces rather than a colon and
   indentation. This has concrete advantages over the Python system - like being
   able to correctly indent code automatically.
 - A Python program frequently includes a shebang line, which is typical for
   a Unix scripting language.
 - Running a Java program typically requires an explicit compliation step.


# Data in Python

 - Primitive Types
   - Number (int vs float), String
 - Tuples
 - Classes / Instances
 - Arrays
 - Dictionaries

# Data in Java

Dynamic vs static type system

 - Primitive Types
   - integers: byte, short, int, long
   - floating point: float, double
   - boolean
   - char
 - Native complex types
   - String
   - Class wrappers: Int, Float
 - Classes / Instances
 - Stuff like Arrays / Dictionaries are in the standard library
 
```
public static void main(String args[]) {
    float xx = 5.0;
    float yy = 3.5;
    System.out.println(xx + yy);
}
```
 
 
Classes: Data or code structure?

**Records**: Halfway between tuples and classes?


## Balloon Example

http://bryanchadwick.com/javaworld/

```java
import world.*;
import image.*;

public class Launch {
    public static void main(String args[]) {
        var y0 = 0;
        var world0 = new LaunchWorld(y0);
        world0.bigBang();
    }
}

class LaunchWorld extends World {
    double yy;

    LaunchWorld(double y0) {
        this.yy = y0;
    }

    @Override
    public Scene onDraw() {
        var bg = new EmptyScene(800, 800);
        var balloon = new FromFile("./balloon.png");
        return bg.
            placeImage(balloon, 400, 800 - yy);
    }

    @Override
    public LaunchWorld onTick() {
        return new LaunchWorld(this.yy + 2);
    }
}
```

```bash
javac -cp .:JavaWorld.jar Launch.java
java -cp .:JavaWorld.jar Launch
```

## Cannonball example 

Launch with number key, that's initial velocity in +x.

Can we modify it to shoot up at a 45 degree angle?

```
import image.*;
import world.*;

public class Cannon {
    public static void main(String args[]) {
        var world0 = new CannonWorld(null);
        world0.bigBang();
    }
}

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

class Ball {
    float x;
    float y;
    float vx;
    float vy;
    
    Ball(x, y, vx, vy) {
       this.x = x;
       this.y = y;
       thix.vx = vx;
       this.vy = vy;
    }
}
```

