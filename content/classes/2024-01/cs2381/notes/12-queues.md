---
title: "cs2381 Notes: 12 Queues"
date: "2024-03-03"
---

**Queues**

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
     * Add an item to the end of the queue.
     *
     * @param  item  The item to add
     */ 
    void push(T item);
    
    /**
     * Get the first item and remove it from queue.
     *
     * @return First item
     */
    T shift();
    
    /**
     * Get the first item.
     *
     * @return First item
     */
    T first();
    
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


**Building a Queue with ConsLists**

We have the same problem as with an ArrayList - if we insert on the
end of a singly linked list that offers O(1) insertions then removing
an item from the other end will take O(n) time.

We can't use the same solution though, because a linked list doesn't
provide O(1) indexing.

But there is a way to get amortized O(1) for removing items from a
linked-list based queue by using two linked lists.

 - Have two lists: front and back
 - Insert into the back list in O(1) time.
 - When we try to take an item from the front of the queue, the front
   list will be empty and the back list will have the wrong end of the
   queue first.
 - So when we want to take an item from the front of the queue and the
   front list is empty, we reverse the back list, make it the front
   list, and then take the first item of the front list in O(1).
 - This is amortized O(1) time because:
   - Each item will take 1 operation to remove from the front list.
   - Each item will take 1 operation to move from the back list to
     the front list when the list is reversed.
   - So to take *n* items from the front of the queue it takes *2n*
     operations which is O(n), or amortized O(1) per operation.

Example:

```
 empty: f=[] b=[]
 add 1: f=[] b=[1]
 add 2: f=[] b=[2 1]
 add 3: f=[] b=[3 2 1] 
 get 1: f=[2 3] b=[]    (reversed b to get new f, removed 1 from first]
 add 4: f=[2 3] b=[4]
 add 5: f=[2 3] b=[5 4]
 get 2: f=[3] b=[5 4]
 get 3: f=[] b=[5 4]
 add 6: f=[] b=[6 5 4]
```

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


# Doubly Linked List


```java
    public static void main(String[] args) {
        var queue = new DoubleList<Integer>();
        for (int ii = 0; ii < 5; ++ii) {
            queue.push(ii);
        }
       
        for (int ii = 0; ii < 3; ++ii) {
            System.out.println(queue.shift());
        }
    }


public class DoubleList<T> {
    Cell<T> head;
    Cell<T> tail;

    DoubleList() {
        head = null;
        tail = null;
    }

    void push(T item) {
        var oldTail = this.tail;
        this.tail = new Cell<T>(tail, item, null);
        if (oldTail == null) {
            this.head = this.tail;
        }
        else {
            oldTail.next = this.tail;
        }
    }

    T shift() {
        T item = head.data;
        this.head = this.head.next;
        if (this.head != null) {
            this.head.prev = null;
        }
        return item;
    }
}

class Cell<T> {
    T data;
    Cell<T> prev;
    Cell<T> next;

    Cell(Cell<T> prev, T data, Cell<T> next) {
        this.data = data;
        this.prev = prev;
        this.next = next;
    }
}
```

