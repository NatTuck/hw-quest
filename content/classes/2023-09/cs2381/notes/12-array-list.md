---
title: "cs2381 Notes: 12 Array List"
date: "2023-09-24"
---

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
      <td>O(n)</td>
    </tr>
    <tr> 
      <td>Add item to back</td>
      <td>O(n)</td>
      <td>O(n) (including resize)</td>
    </tr>
    <tr> 
      <td>Insert item after index ii</td>
      <td>O(n)</td>
      <td>O(n) (including resize)</td>
    </tr>
  </tbody>
</table> 

**ArrayList**

We've seen arrays and the idea of a wrapper object.

Let's add one more method:

```java
    void append(T vv) {
        int ii = length();
        resize(ii + 1);
        set(ii, vv);
    }
```

Now we can fill an Array with items like this:

```java
    var xs = new ArrayWrap<Integer>();
    for (int ii = 0; ii < 10; ++ii) {
       xs.append(vv); 
    }
```

Problem: What is the asymptotic complexity of that loop?

 - What's the complexity of xs.append?
 - And we do that n times.
 
Counting inserts:

 - 1 for first item.
 - 1 for second, plus copy 1 = 2
 - 1 + copy 2
 - 1 + copy 3
 - ...
 - 1 + copy (n-1)
 - ~ O(n^2)
 
We can do better than that. Let's write an ArrayList.

Trick:

 - Add a length field, allowing the length of the ArrayList
   to be shorter than the length of the backing array.
 - Grow by doubling the length of the backing array.
 
Now let's try counting inserts.

 - 1 for first item (cap = 1)
 - 1 + 1 for second (cap = 2)
 - 1 + 2 for third (but now cap = 4)
 - just one for 4th
 - = 7 
 
 - 1 + 4 for fifth  (cap = 8)
 - just 3 for next 3
 - = 15 for 8th
 
 - 1 + 8 for 9th (cap = 16)
 - just 7 for next 7
 - = 31 for 16th
 
 - = 63 for 32
 - = 127 for 64
 - = 2*n-1 for n
 - ~ O(n) to insert n

Let's build (or at least describe) some more methods for ConsList and ArrayList:

 - Insert after index
 - Delete item
 - Concatenate
 - Split into two
 - What if we don't want to destroy the old one?
