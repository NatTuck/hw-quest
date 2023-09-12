---
title: "cs2381 Notes: 06 Linked List"
date: "2023-09-10"
---

Now that we have records (one object can have several fields) and
interfaces (an object can be one of several different types), we have
the pieces to build a way to store an unbounded number of items of the
same type: Linked Lists.

**Diagrams on Whiteboard**

 - Variables and fields each contain a single value.
   - A primitive value
   - An object reference.

Primitive value vs object reference:

```java
int xx = 5; // xx [ 5 ] 
String yy = "Hello";  // yy [ ] ---> "Hello"

int aa = xx; // aa [ 5 ] 
String bb = yy; // 
```

Linked list:

 - xs points to Cell[first, rest], rest points to Cell[first, rest], ... Empty

**Concrete Linked List**


```java
record Cell(int first, Cell rest) { }
```

Problem: Can't handle empty lists.

 - We could use null, but then an empty list isn't a list and any user of
   our code needs to worry about checking for null all the time.
   
```java
record Empty() { }
```

But a list can be either of those things, so we need an interface.

```java
/**
 * A linked list of ints.
 */
interface List {
    /**
     * Determines if list is empty.
     *
     * @return  True if empty.
     */
    boolean empty();
    
    /**
     * Gets first item in list.
     * 
     * Crashes if list is empty.
     *
     * @return  First item.
     */
    int first();
    
    /**
     * Gets the part of the list after the first item.
     * 
     * Crashes if list is empty.
     *
     * @return  The rest of the list.
     */
    List rest();
}

/**
 * An empty linked list.
 */
record Empty() implements List {
    @Override
    public boolean empty() {
        return true;
    }
    
    @Override
    int first() {
        throw new Error("empty list");
    }
    
    @Override
    List rest() {
        throw new Error("empty list");
    }
}

/**
 * A non-empty linked list.
 */
record Cell(int first, List rest) implements List {
    @Override
    public boolean empty() {
        return false;
    }
}
```

Let's design a sum method.

```java
// Interface
    /**
     * Calculate the sum of the list elements.
     *
     * @return  The sum.
     */
    int sum();

// Empty
    @Override
    int sum() {
        return 0;
    }
    
// Cell
    @Override
    int sum() {
        return this.first + this.rest.sum();
    }
```

Demo code:

```java
  ... main() {
        List xs = new Empty();
        xs = new Cell(1, xs);
        xs = new Cell(2, xs);
        xs = new Cell(3, xs);
        xs = new Cell(4, xs);
        System.out.println("xs.sum() = " + xs.sum());
```

