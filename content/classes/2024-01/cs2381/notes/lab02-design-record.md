---
title: "cs2381 Notes: Lab 02 - Design Records"
date: "2024-01-25"
---

Delay teams until after mini-lecture.

## Records

A ```record``` in Java is a special kind of class that's especially
suitable for storing data values.

You define a record like:

```java
/**
 * Info about a serving of ice cream.
 *
 * @param  flavor  Ice cream flavor.
 * @param  scoops  How many scoops.
 *
 * @author Nat
 */
record IceCream(String flavor, int scoops) {
    // can add extra methods here
}
```

This gives you some methods:

```java
    var ic = new IceCream("Vanilla", 2);
    ic.flavor();  // returns "Vanilla"
    ic.scoops();  // returns 2
```

Record objects are immutable - they can't be changed after
they are created.

For this course, records should be the default way to define a data
type, although we'll run into scenarios where we need mutable objects
and therefore need regular classes.

## Design Recipie:

 - https://homework.quest/classes/2024-01/cs2381/design-recipe/

## Style checker

You probably ran into the style checker on the last homework. It's a
jerk.

## Attendence & Teams

Let's do that now.

