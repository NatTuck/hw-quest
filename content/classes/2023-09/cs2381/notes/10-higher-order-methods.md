---
title: "cs2381 Notes: 10 Higher Order Methods"
date: "2023-09-19"
---

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
  
  // Add one to each number.
  void example() {
    var xs = List.list(1,2,3,4);
    var ys = xs.map((xx) -> xx + 1);
  }
```

Now rewrite our two example methods to use map.

Notes:

 - The thing with "->" is called an anonymous function or a lambda function.
 - It constructs an object with no name, of a type with no name, that implements
   the interface Function[T, U].

**Introducing Filter**

Setup: 
 
 - A method that takes a ```List<Pet>``` and selects only dogs.
 - A method that takes a list of int and takes only even numbers.
 
Punchline:

 - Write List#filter, which abstracts filtering with a function arg.
 - Rewrite the two things using filter.
