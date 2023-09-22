---
title: "cs2381 Notes: 11 Arrays"
date: "2023-09-21"
---

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
    int[] xs = new int[] = {1, 2, 4};
    int[] ys = new int[3];
    
    ys[1] = xs[0] + xs[1];
    
    System.out.println("" + ys[1]); // 3
```

The pattern to manipulate an array is a for loop over an int.

```java
    int[] xs = new int[] = {1, 2, 4};

    int sum = 0;
    for (int ii = 0; ii < xs.length; ++ii) {
        sum += xs[ii];
    }
    
    System.out.println("sum = " + sum);
```

**ArrayWrapper**

Add some methods:

 - get(ii)
 - put(ii, vv)
 - resize(nn)
 - pushFront(vv)
 - pushBack(vv)
 
**ListWrapper**

Same methods.

**Arrays vs Cons Lists**

<table class="table table-striped">
  <thead>
    <tr>
	  <td>Operation</td>
	  <td>List</td>
      <td>Array</td>
	</tr>
  </thead>
  <tbody>
    <tr> 
      <td>Get first item</td>
      <td>O(1)</td>
      <td>O(1)</td>
    </tr> 
    <tr> 
      <td>Get item by index i</td>
      <td>O(n)</td>
      <td>O(1)</td>
    </tr>
    <tr> 
      <td>Set item at index i</td>
      <td>O(n)</td>
      <td>O(1)</td>
    </tr>
    <tr> 
      <td>Add item to front</td>
      <td>O(1)</td>
      <td>O(n) (including resize)</td>
    </tr>
    <tr> 
      <td>Insert item after index ii</td>
      <td>O(n)</td>
      <td>O(n) (including resize)</td>
    </tr>
  </tbody>
</table> 
