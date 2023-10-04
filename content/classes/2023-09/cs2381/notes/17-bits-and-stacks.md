---
title: "cs2381 Notes: 17 Bits and Queues"
date: "2023-10-04"
---

**Bit Packing: Chess**

ref: https://www.lennyfacecopypaste.com/text-symbols/chess.html

We want to represent a chess board in as few bytes as possible.

 - There are 64 squares on a chess board.
 - Each square can be one of:
   - Blank
   - A piece, one of: ♔ ♕ ♚ ♛ ♘ ♗ ♙ ♖ ♞ ♝ ♟ ♜
 - So that's 1 + 2*6 = 13 possible states.
 - We can represent those states using 4 bits.
 - There are 8 rows of 8 squares. Each row takes 8 * 4 = 32 bits, or 1 int.
 - So we can represent a chess board using an array of 8 ints, one for each row.

Let's write methods to encode and decode chess boards.

# Queues

A stack is a data structure where you can only add and remove items
from the top. It's sometimes referred to as LIFO, for "Last In First
Out".

If a collection can be LIFO, another option is "First In First Out",
or FIFO. That means you insert things at one end and remove them at
the other. The first thing in is the first thing out, like the items
are waiting in line. Such a structure is called a Queue.

```java
interface Queue<T> {
    /**
     * Add an item to the queue.
     *
     * @param  item  The item to add
     */ 
    void add(T item);
    
    /**
     * Get the next item and remove it from queue.
     *
     * @return Next item
     */
    T next();
    
    /**
     * Get the next item.
     *
     * @return Next item
     */
    T peek();
    
    /**
     * Determine if queue is empty.
     *
     * @return True if empty
     */
    boolean empty();
}
```

Again, queues are generally expected to be efficient, so for a simple
FIFO queue these operations should generally be amortized O(1).

## Use Cases

In British English, "wait in line" is "wait in queue". We can use a
queue data structure to model situations where something or someone
needs to wait in line. More generally, a queue is useful any time people or
things need to take turns and share a resource.

Example:

 - Simulating a lunch counter and people waiting in line.
 - Simulating traffic on a one-lane tunnel: cars will exit in the same
   order they entered.
 - Scheduling problems:
 - An operating system uses queues to determine which program should
   run next when multiple programs are running on a single CPU core.
 - A stock market might use queues to schedule trade execution.

Next lab you will be building some queues, so I'm not going to provide
code for them, but I am going to walk through a couple of strategies
for building an efficient queue.

## How to Build a Queue

Our two sequence data types were great for building stacks. They
provide effiicent mechanisms for us add items at one end and then
remove items from the same end - and that's what a stack needs to do.

A queue is a bit trickier, because we want to add items at one end and
remove them from the other.

**Building a queue with an ArrayList: Ring Buffer**

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


