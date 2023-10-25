---
title: "cs2381 Notes: 25 Introducing Hash Tables"
date: "2023-10-24"
---

**Propagating Traversal State**

In order to implement the Scapegoat Tree insert logic for Problem 3 in
the lab, you need to come up with some way to transfer information
both into and out of the recursive calls.

Specifically:

 - In order to determine the maximum depth a node is allowed to be without
   triggering a rebalance, you need the size field of the TreeMap class.
 - In order to calculate the depth of the newly inserted node, you need
   to increment a counter as you recurse down the tree in the Branch record.
 - You can't compare the actual depth to the maxmimum depth and
   determine if a rebalance is needed until you're doing the insert in
   the Leaf record.
 - You can't find the scapegoat until after the recursive call in the
   Branch record.

So that means passing several pieces of information up and down the recursion:

 - Max depth needs to be passed down.
 - Current depth needs to be passed down.
 - Whether to do a rebalance needs to be passed up.
 - The size of that subtree rooted at the current node.

Passing items down is pretty straightforward: add more method arguments.

Passing items back up is a bit trickier - that's naturally a return
value, but you're already returning a new tree node.

 - Solution: Return a multi-piece data structure.
 - Most straightforwardly, a record with both the new node and a
   needsRebalance flag.

Alternate plan: An insertion state object.

 - Add one argument with an object allocated at the top and space for
   all the extra info.
 - Fill in fields in the object as you get the info.
 - Advantage: Only one allocation per insert.
 - Disadvantage: Harder to reason about one bucket of mutable fields
   for different things than clearly separating arguments and return
   values.

**New Concept: Hash Table**

All this tree and list stuff where you have to traverse a data
structure is complicated.

Let's have an:

 - Array of Pairs
 - A way to lookup which slot in the array our pair will be in
   given the key.

Scenario A:

 - We have an array with 4 slots.
 - The keys we're trying to insert are integers 0-3.
 - Draw this in the board.

Scenanrio B:

 - Not all integers are between 0 and 3. What if we try to insert
   a pair with a key of 5?
 - We need a way to map arbitrary integers to slots in the array.
 - So how do we convert 5 to an integer between 0 and 3? We can convert
   any integer into that range with the modulo function.

Remainder vs. mod operations:

 - In java, the ``%`` operator gives you a remainder.
 - The mod operation is available as ``Math.floorMod``

Difference:

 - ``rem(-5, 10) = -5``
 - ``mod(-5, 10) = 5``

Given any integer ``xx``, we can get a slot in an array of size ``nn``
by doing ``Math.floorMod(xx, nn)``.

Problem: Collisions

 - We have an array with 4 slots.
 - We map keys to slots with ``Math.floorMod(key, 4)``
 - We insert (3 -> 7); 3 mod 4 = 3
 - We insert (4 -> 5); 4 mod 4 = 0
 - We insert (7 -> 8); 7 mod 4 = 3 ; but (3 -> 7) is already in that slot.

That's a collision.

 - How to deal with collisions is the tricky part with hash tables.
 - We can't just pick one or the other, both of those records need to be in our map.
 - But for the hash table plan to work, we need to be able to find every entry
   by index.

For now, we can just grow the table.

 - Allocate an 8 slot array.
 - Copy over the items in the existing table, calculating (xx mod 8) to find the slot.
 - (3 -> 7) goes in slot 3, (7 -> 8) goes in slot 7.

But we don't always want to grow the table on each collision. Alternate plans:

 - Linked lists: Have each item in the table be a ``ConsList<Entry>``
   instead of an Entry.
 - Linear probing: If we can't put it in slot xx, try slot (xx + 1)
   mod nn. Keep trying slots until we find an empty one.
 - Without collisons, hash table lookups are O(1). With collisons, if
   every item ends up in the same slot, lookups become O(n).

Problem: Non-integer keys

 - Most possible key types aren't integers.
 - But we need an integer to find the right slot in the table.
 - So we use a hash function: A function from our key type to an integer.
 - This could conceptually be any function, but we want a function that
   tends to minimize collisions - so any change in the input should drastically
   change the integer result.
 - Hash table hash functions are different from cryptographic hash functions. 

Example function for strings:

```java
static int hashString(String text) {
    int yy = 37;
    for (char cc : text.toCharArray()) {
       // consider integer overflow
       // as far as I can tell, signed integer overflow in Java is defined as
       // being two's-complement wrapping 
       yy = 257*yy + 5*cc; 
    }
    return yy;
}
```

In Java, we don't need to write a hash function for String. Java
strings have a hashCode method, which calculates a reasonable default
hash function.

Every java Object has a hashCode method. For built in types, most
standard library types, and records this is provided by default. For
any class you define you will need to provide your own hashCode method
if you want to use objects of that type as keys in a hash table.

Demo:

 - Open up a "scala" repl, try some examples:
 - 5.hashCode()
 - 6.hashCode()
 - "a".hashCode()
 - "b".hashCode()
 - "aa".hashCode()
 - "ab".hashCode()
 - (1, 2).hashCode()
 - (1, 3).hashCode() 

## Building a Hashmap

Here's a HashMap with Linear Probing:

25/demo/.../HashMap.java
