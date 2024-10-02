---
title: "cs2381 Notes: 16 Queues to Dequeues"
date: "2024-02-27"
---

**Building a queue with an Array or ArrayList: Ring Buffer**

 - If we added at the back and removed at the front, taking the next
   item would be O(n) because we'd have to copy the whole array down
   one index.
 - Rather than moving the items, let's just move the front of the
   queue. The front of the queue starts at index 0, but increases by
   one index each time we remove an item.
 - But then the queue will grow forever and waste space. But we have
   extra space at the start of the array... so let's use that space.
 - We'll treat the array like a big circle and track both the current
   front and back index.
 - If we run out of space, we still need to copy.

RingQueue fields:

 - data: array of T
 - front index: where we remove the next item
 - back index: where we add the next item
 - size: how many items in queue 

Example:

```
  empty: [   |   ]
          f b
  
  add 1: [ 1 |  ]
          f   b

  add 2: [ 1 | 2 ]      (b is at capacity + 1)
          f       b
          
  add 3: [ 1 | 2 | 3 |   ]   (was full, double capacity)
          f           b

  get 1: [ 1 | 2 | 3 |   ]
              f       b

  add 4: [ 1 | 2 | 3 | 4 ]
              f       b

  add 5: [ 5 | 2 | 3 | 4 ]   (hit end, loop around)
              b f

  get 2: [ 5 | 2 | 3 | 4 ]
              b   f

  get 3: [ 5 | 2 | 3 | 4 ]
              b       f

  add 6: [ 5 | 6 | 3 | 4 ]
                  b   f
```

Complexities:

 - Add is amortized O(1) as long as we double capacity each time
   we grow, same as for ArrayList.
 - Next is O(1) because we just need to increment an index modulo
   capacity, decrement size, and return an item.
 - Peek is O(1), we just look at the thing at the front index.
 - Empty is O(1), we just determine if size is zero.


# Deque

Stacks and queues are great if those are the operations we need, but
what if we want to insert and remove items from *either* end
efficiently?

Such a structure is called a "double-ended queue", or "deque".

```java
interface Deque<T> {
    /**
     * Add an item to the end of the deque.
     *
     * @param  item  The item to add
     */ 
    void push(T item);
    
    /**
     * Get the last item and remove from deque.
     *
     * @return Next item
     */
    T pop();

    /**
     * Add an item to the start of the deque.
     *
     * @param  item  The item to add
     */
    void unshift(T item);

     /**
     * Get the first item and remove from deque.
     *
     * @return Next item
     */
    T shift();
    
    /**
     * Get the first item.
     *
     * @return Item
     */
    T first();

    /**
     * Get the last item.
     *
     * @return Item
     */
    T last();
    
    /**
     * Determine if queue is empty.
     *
     * @return True if empty
     */
    boolean empty();
}
```

This is a bit more complicated than queues, but it should be solvable
with the same basic strategies.

**Ring Buffer**

Using a deque to build a ring buffer, all of our operations are O(1)
or amortized O(1) to grow.

**Two Lists**

This is tricky to analyze.

 - If you use it as a stack everything is O(1). 
 - Using it as a queue, everything is at least amortized O(1).
 - But if you mix operations, you can construct scenarios where
   every operation is O(n).
   
Example worst case:

 - Push 100, then
 - Shift.
 - Unshift.
 - Pop.
 - Push.
 - Alternate shift/unshift, pop/push. Every removal is O(n).



