---
title: "cs2381 Notes: 09 Iterator and Recursive Data"
date: "2024-09-15"
---


# Deep into Iteration
 
 - Write a method that appends "s" to each item in a list of Strings.
   - Start with for-each loop over array.
   - Run on example with excess capacity - crash.
   - Need C-style for loop.
 - Write a method that adds 1 to each item in a list of ints.
   - Try for-each loop again.
   - This one doesn't crash, but it appends zeros. Why?
 - Implement Iterable for our ArrayList.
   - Need to import Iterator, but iterable is available by default.
   - Rewrite with for-each over the object itself.
 - Abstract to map method.

```java
  import java.util.function.Function;

  // ArrayList method
  <U> List<U> map(Function<T, U> op) {
    ArrayList ys = new ArrayList<U>();
    
    for (int ii = 0; ii < this.size(); ++ii) {
      ys.add(op.apply(this.get(ii)));
    }
    
    return ys;
  }
 
  // Usage:
  // xs.map((xx) -> xx + 1);
```

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
