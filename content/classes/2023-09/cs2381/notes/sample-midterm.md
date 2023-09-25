---
title: "cs2381: Practice Midterm"
date: "2023-09-25"
---

## Sample Midterm: cs2381 Fall 2023

2023-09-25: This sample midterm is provided to help provide some
direction in studying for the upcoming midterm.

Keep in mind that anything we've covered in class, in lab, or in a lab
assignment may be on the exam.

These questions reference the code provided at the end of the exam.
Skim that first to see what the questions are talking about.

The answer to an "asymptotic complexity" question on this exam will be
one of: O(1), O(log n), O(n), O(n log n), O(n^2), or O(2^n).

**1. In the App#main method, what is the type of the ```args``` parameter?**

<br><br><br><br>

**2. In the App#main method, what is the type of the ```xs``` variable?**

<br><br><br><br>

**3. If we run the App program, what will it print?**

<br><br><br><br>

**4. Following the pattern for a recursive traversal of a linked list,
write the body of the App#maximum method.**

<br><br><br><br>

**5. Given a list of length n, what is the asymptotic complexity of
App#maximum as you implemented it?**

<br><br><br><br>

**6. Give one example of a type in Java that is not a primitive type.**

<br><br><br><br>

**7. In Java, how many bytes does it take to store an int?**

<br><br><br><br>

**8. What are two effects of declaring a type as a record rather than as a class?**

<br><br><br><br>

**9. Given two lists each of length n, what is the asymptotic complexity of the
App#matches method?**

<br><br><br><br>

**10. What are two things wrong with the code in Walrus.java?**

<br><br><br><br>


## Reference Code

```java
// App.java
package midterm;

public class App {
    public static void main(String[] args) {
        var xs = ConsList.list(33, 81, 72, 5, 53, 28);
        System.out.println("max of " + xs + " is " + maximum(xs));
        
        var ys = ConsList.list(5, 84, 16, 28, 11, 41);
        System.out.println("matches = " + matches(xs, ys));
    }

    
    static int maximum(ConsList<Integer> xs) {
        // TODO: Given a ConsList of non-negative integers, 
        // return the maximum value.
    }
    
    static int matches(ConsList<Integer> xs, ConsList<Integer> ys) {
        int count = 0;
        for (var xp = xs; !xp.empty(); xp = xp.rest()) {
           for (var yp = ys; !yp.empty(); yp = yp.rest()) {
               if (xp.first() == yp.first()) {
                   count += 1; 
               }
           }
        }
        return count;
    }
}
```

```java
// ConsList.java
package midterm;

import java.util.function.Function;

public interface ConsList<T> {
    @SafeVarargs
    public static <T> ConsList<T> list(T... args) {
        ConsList<T> ys = new Empty<T>();
        for (int ii = args.length - 1; ii >= 0; --ii) {
            ys = new Cell<T>(args[ii], ys);
        }
        return ys;
    }

    T first();
    ConsList<T> rest();
    boolean empty();
    int length();
    <U> ConsList<U> map(Function<T, U> op);
}

record Empty<T>() implements ConsList<T> {
    @Override
    public T first() {
        throw new Error("empty list");
    }

    @Override
    public ConsList<T> rest() {
        throw new Error("empty list");
    }

    @Override
    public boolean empty() {
        return true;
    }

    @Override
    public int length() {
        return 0;
    }

    @Override
    public String toString() {
        return "Empty";
    }

    @Override
    public <U> ConsList<U> map(Function<T, U> op) {
        return new Empty<U>();
    }
}

record Cell<T>(T first, ConsList<T> rest) implements ConsList<T> {
    @Override
    public boolean empty() {
        return false;
    }

    @Override
    public int length() {
        return 1 + rest.length();
    }

    @Override
    public String toString() {
        return "(" + first + " " + rest + ")";
    }

    @Override
    public <U> ConsList<U> map(Function<T, U> op) {
        return new Cell<U>(op.apply(this.first()), this.rest.map(op));
    }
}
```

```java
// Walrus.java

record Walrus(int age, String name) [
   System.out.println(this.age);

   Walrus sandwich() {
      new Walrus(14, 29);
   }
]
```
