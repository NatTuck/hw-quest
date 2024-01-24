---
title: "cs2381 Notes: 02 Simple Data"
date: "2024-01-23"
---

# Lab Status

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

 - http://bryanchadwick.com/javaworld/index.html
 - https://openclipart.org/detail/175310/red-balloon


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

