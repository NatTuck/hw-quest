---
title: "cs2381 Notes: 07 ArrayList"
date: "2024-02-11"
---

First, lets look at the Bird.

 - Download the starter code.
 - The questions skip a key piece: showFrame
 - Uncomment the code that shows the bird.
 - Questions?


**Finishing ArrayList**

Last time:

 - List vs. Array
   - Interface vs. Built-in thing with special syntax
 - ArrayWrapper

```java
    int[] xs = {1, 2, 4};
    List ys = List.of(1, 2, 4);
```

Problem:

 - Arrays have fixed size.
 - To add an addional item, we first need to
   allocate a new array and copy all the existing items over.


**ArrayList**

The problem with ArrayWrapper#add is that adding one item requires
allocating a new array and copying everything over.

New plan: Instead of adding only one space when we allocate a new
array, we'll add several spaces.

On modern computers, we've got plenty of memory. And when we're
thinking about things with big-O, we can ignore constant factors. So
we'll *double* the size of the array whenever it grows.

Some useful methods:

```java
    @SafeVarargs
    public static <T> ArrayList<T> of(T... args) {
      ArrayList<T> ys = new ArrayList<T>();
      for (int ii = args.length - 1; ii >= 0; --ii) {
            ys.append(args[ii]);
        }
        return ys;
    }
    
    @SuppressWarnings("unchecked")
    ArrayList() {
        // This appears to be the standard way to get a new array of T.
        this.data = (T[]) new Object[2];
        this.length = 0;
    }
    
    @SuppressWarnings("unchecked")
    void setCapacity(int nn) {
        T[] data1 = (T[]) new Object[nn];
        int len1 = Math.min(nn, this.length);

        for (int ii = 0; ii < len1; ++ii) {
            data1[ii] = this.data[ii];
        }

        this.data = data1;
        this.length = len1;
    }
```


Working from existing ArrayWrap:

 - Copy to ArrayList
 - Revert ArrayWrap to the grow-by-1 logic
 - Have ```add``` only grow array when it needs to.
 - Have the code count array slot writes.


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
