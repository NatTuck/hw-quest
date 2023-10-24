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
