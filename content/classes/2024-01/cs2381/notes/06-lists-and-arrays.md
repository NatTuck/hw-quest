---
title: "cs2381 Notes: 06 List and Arrays"
date: "2024-02-06"
---

First, lets look at the Bird.

 - Download the starter code.
 - The questions skip a key piece: showFrame
 - Uncomment the code that shows the bird.
 - Questions?

**Next: Building ArrayList**

Last time:

 - Array interface
 - ArrayList
 - Complexity / big-O

We saw how to use a list, and that one kind was called an ArrayList,
but this is a data structures class. We need to know how different
kinds of lists work and what their properties are.

To do that, we're going to build a our own ArrayList.

First, we'll need to introduce anther building block that Java gives
us: the array.

**Introducing Arrays**

Today, we're going to look at a new kind of object in Java.

It's not a primitive value type. It's not a class instance object.
It's an array of objects.

Facts about Arrays:

 - A collection of zero or more items.
 - All items are the same type. 
 - Each array has a fixed length, specified when it
   is created.
 - Items in the array can be accessed (and modified)
   by numerical index, starting at 0.
 - Arrays have a length field that can be accessed directly.

Simple example:

```java
    int[] xs = {1, 2, 4};
    int[] ys = new int[3];
    
    ys[1] = xs[0] + xs[1];
    
    System.out.println("" + ys[1]); // 3
```

Just like with Lists, there are two basic patterns to deal with an
array:

```java
    int[] xs = {1, 2, 4};

    int sum1 = 0;
    // for-each loop
    for (int xx : xs) {
       sum1 += xx; 
    }
    
    System.out.println("sum1 = " + sum1);

    int sum2 = 0;
    // c-style for loop
    for (int ii = 0; ii < xs.length; ++ii) {
        sum2 += xs[ii];
    }
    
    System.out.println("sum2 = " + sum2);
```

Just like with Lists, you go for the C-style loop if you need the indexes, which
usually happens when you plan to modify the array contents in place.


**ArrayWrapper**

Add some methods:

 - get(ii)
 - put(ii, vv)

Now we'd like to add one more method:

 - add(vv) - Append 

Problem: 

 - add is O(n), which means the typical pattern for building
   an array is O(n^2)

**ArrayList**

The problem with ArrayWrapper#add is that adding one item requires
allocating a new array and copying everything over.

New plan: Instead of adding only one space when we allocate a new
array, we'll add several spaces.

On modern computers, we've got plenty of memory. And when we're
thinking about things with big-O, we can ignore constant factors. So
we'll *double* the size of the array whenever it grows.

But we still need to keep track of how many items are actually in the
array. That means we've got two seperate concepts:

 - The number of items actually in the list - this is the list "size".
 - The number of slots in the array - this is the list "capacity".

Adding an item to the array still requires a reallocation / copy, and
thus takes O(n) operations. But extending an array by n slots ends up
taking O(n) operations rather than O(n^2) - which means we can say
that the add operation takes "amortized" O(1).

If this were Algorithms I'd prove that. Instead, let's do an example.

 - On the whiteboard:
 - Start with an ArrayList: size 0, capacity 2
 - Append to it until we get to size 17
 - Count the total number of array slot writes as we go - the total
   is bounded above by k*n, for some small constant k.


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
