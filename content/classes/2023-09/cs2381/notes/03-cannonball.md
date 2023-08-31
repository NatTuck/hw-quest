---
title: "cs2381 Notes: 03 Cannonball"
date: "2023-08-29"
---


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
    // State of the world:
    //   To draw the scene or calculate the next state, all we
    //   need is one value, the current altitude of the balloon.
    double balloonAltitude;

    LaunchWorld(double y0) {
        this.balloonAltitude = y0;
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
        return new LaunchWorld(this.balloonAltitude + 2);
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

```java
import image.*;
import world.*;

public class Cannon {
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

