---
title: "cs2381 Notes: 01 Welcome"
date: "2023-08-27"
---

Data Structures First Day:

## Hello

 - Hello
 - Data structures?
   - How to structuring data
   - Second semester of programming
 - Attendence

## Syllabus

 - Attendence is strongly recommended.
   - Also, eating and sleeping.
 - Attendence for labs on Tuesdays is graded.
 - We'll be treating the lecture and lab as one course,
   I'll probably have to enter your grade twice at the end
   of the semester.
 - Lab projects are the largest grade component. You'll work
   in pairs and write code.
 - Exams are on paper, and really will include writing code with
   a pencil.
 - We'll see an autograding example tomorrow.
 - I think tutoring is 6-8pm Monday-Thursday in the lab, but
   I'm not 100% sure.
 - Please don't cheat.

## Introducing Java


```java
// Hello.java

public class Hello {
    public static void main(String[] args) {
        System.out.println("Hello");
    }
}
```

http://bryanchadwick.com/javaworld/index.html

https://openclipart.org/detail/175310/red-balloon

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
