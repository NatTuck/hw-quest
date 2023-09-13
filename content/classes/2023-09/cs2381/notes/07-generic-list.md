---
title: "cs2381 Notes: 07 Generic List"
date: "2023-09-12"
---

**Casting**

 - Primitive types (numerical conversions)
 - Objects

**On Abstraction**

Abstraction is a thing we do a lot in programming. The basic idea
goes like this:

 - Two things are similar.
 - We pull out the similarities into an abstraction, parameterized
   by the differences.

**Methods abstract over Code**

```java

    // concrete
    // subtotal is $3.70
    double mealTotal1 = 3.70 * 1.085;
    // subtotal is $25.93
    double mealTotal2 = 25.93 * 1.085;
   
    // abstraction
    static addMealTax(double subtotal) {
       return subtotal * 1.085;
    }
```

**Records abstract over structured data types**

```java
   
   // rect is 3 x 7
   int area1 = 3 * 7;
   // rect is 4 x 9
   int area2 = 4 * 9;
  
   // Two parts:
   //  - 1. Structure
   record Rect(int width, int height) {
      // - 2. Logic
      int area() {
         return width * height; 
      }
   }

```

**Interfaces abstract over types with shared methods**

New today, abstracting over types without any shared methods.

**Pair => Generic Pair**

```java
record DoublePair(double left, double right) {}
record StringPair(String left, String right) {}

record Pair<T>(T left, T right) {}
```

... examples

**Generic Linked List**

```java
// interface List {
//   int first;

interface List<T> {
    T first();
    List<T> rest();

    boolean empty();
    int length();
}

record Empty<T>() {
    // ...
}

record Cell<T>(T first, List<T> rest) {
    //...
}
```

```java
    static int sumList(List<Integer> xs) {
        if (xs.empty()) {
            return 0;
        }
        else {
            return xs.first() + sumList(xs.rest());
        }
    }
```

```java
    static String longest(List<String> xs) {
       // do it
    }
```

