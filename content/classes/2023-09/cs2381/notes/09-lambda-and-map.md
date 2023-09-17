---
title: "cs2381 Notes: 09 Lambda and Map"
date: "2023-09-17"
---

Starting from the "generics" project.

**List Operations**

```java
    record Pet(String species, String name, double weight) {}

    List<Pet> xs = new Empty<Pet>();
    xs = new Cell<Pet>(new Pet("cat", "Fluffy", 3.5));
    xs = new Cell<Pet>(new Pet("dog", "Spot", 6.5));
    xs = new Cell<Pet>(new Pet("cat", "Simba", 6.7));
    xs = new Cell<Pet>(new Pet("dog", "Buddy", 4.5));
    
    // heavier species total (cat or dog)
  
    // totalSpeciesWeight
    // Recursive version
    // for (curr; !curr.empty(); curr = curr.rest()) version
```

**A Quadratic Method**

Design a function that takes two lists and returns a list of items
that occur in both.

 - Helper: recursive contains()
 - Recursive: A O(n) function calls an O(n) function, so O(n^2)
   - Or O(m*n)
 - Direct iterative: Two loops, so O(n^2)

**Introducing Map**

Setup:

 - A method that takes a ```List<Pet>``` and ages each pet by one year.
 - A method that doubles each number in a list.


```java
  // Import
  import java.util.function.Function;

  // List
  <U> List<U> map(Function<T, U> op);

  // Empty
  @Override
  public <U> List<U> map(Function<T, U> op) {
    return new Empty<U>();
  }

  // Map
  @Override
  public <U> List<U> map(Function<T, U> op) {
    return new Cell<U>(op.apply(this.first()), this.rest.map(op));
  }
```

Now rewrite our two example methods to use map.

Notes:

 - The thing with "->" is called an anonymous function or a lambda function.
 - It constructs an object with no name, of a type with no name, that implements
   the interface Function[T, U].
