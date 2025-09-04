---
title: "cs2381 Notes: 09-05 Instance Methods"
date: "2025-09-03"
---

## Lists

In Python, if we want a sequence of items we use a list.

In Java, we've seen three ways to make a sequence so far:

- Arrays
- Last lecture, one of the examples used List.of(...)
- Singly linked lists (`Cell`)

As we'll see, there are lots of ways to make a list, and there are advantages
and disadvantages to each.

The Java standard library deals with this by making List an **interface**,
not a concrete type: [java.util.List](
https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/List.html)

So List is defined by what it can do, not how it's specifically implemented.

Let's look at the docs. What can a list do?

- add(item): Stick a new element on the end. That's already an operation
  you couldn't do with just an array.
- get(index): Get the item at a given index.
- set(index, item): Put an item at a given index.
- size(): Gets the number of items in the list.
- contains(item): Check if an object appears in the list.
- iterator(): This allows us to loop through the list with a for-each style loop.

Java also provides several list implementations. Two of them are especially
noteworthy:

- ArrayList - Uses an array to store the list items.
- LinkedList - Uses a linked list of cells to store the list items.

## Sample Algorithm: Bubble Sort

```java
import java.util.List;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.ListIterator;
import java.util.Random;


public class App {
    public static void main(String[] args) throws InterruptedException {
        // try 20,000 for ArrayList and 2000 for LinkedList
        List<Integer> xs = randomInts(30000);

        //System.out.println("before: " + xs);
        
        long t0 = System.nanoTime();

        bubbleSort2(xs);

        long t1 = System.nanoTime();
        double dt = (t1 - t0) / 1000000000.0;
        
        //System.out.println("after: " + xs);

        System.out.println("sorted? " + (isSorted(xs) ? "yes" : "no"));

        System.out.printf("That took %.03f seconds\n", dt);
    }

    static boolean isSorted(List<Integer> xs) {
        for (int ii = 0; ii < xs.size() - 1; ++ii) {
            if (xs.get(ii) > xs.get(ii + 1)) {
                return false;
            }
        }
        return true;
    }

    static void bubbleSort1(List<Integer> xs) {
        for (int ii = 0; ii < xs.size(); ++ii) {
            for (int jj = 0; jj < xs.size() - 1; ++jj) {
                int vv0 = xs.get(jj);
                int vv1 = xs.get(jj + 1);

                if (vv0 > vv1) {
                    // swap
                    xs.set(jj, vv1);
                    xs.set(jj + 1, vv0);
                }
            }
        }
    }

    static void bubbleSort2(List<Integer> xs) {
        for (int ii = 0; ii < xs.size(); ++ii) {
            ListIterator<Integer> it = xs.listIterator();

            while (it.nextIndex() < xs.size() - 1) {
                int vv0 = it.next();
                int vv1 = it.next();
                    
                if (vv0 > vv1) {
                    // swap
                    it.set(vv0); // 

                    // first previous gets jj+1 again
                    it.previous();
                    // this gets us back to jj
                    it.previous();

                    it.set(vv1);

                    it.next();
                }
                else {
                    it.previous();
                }
            }
        }
    }

    static List<Integer> randomInts(int nn) {
        var rand = new Random();

        var ys = new ArrayList<Integer>();

        for (int ii = 0; ii < nn; ++ii) {
            ys.add(rand.nextInt(1000)); 
        }

        return ys;
    }
}
```

Questions to discuss:

- How does the time for bubblesort increase as we increase the
  size of the input array?
- Why?
- How does it change if we switch to a LinkedList?
- Why?
- What if we move to bubbleSort2?
