---
title: "cs2381: Practice Final"
date: "2023-12-01"
draft: true
---

## Practice Final Exam: cs2381 Fall 2023

2023-09-25: This sample exam is provided to help provide some
direction in studying for the upcoming final.

Keep in mind that anything we've covered in class, in lab, or in a lab
assignment may be on the exam.

These questions reference the code provided at the end of the exam.
Skim that first to see what the questions are talking about.

The answer to an "asymptotic complexity" question on this exam will be
one of: O(1), O(log n), O(n), O(n log n), O(n^2), O(n^3), O(2^n)

**1. In the App#main method, what is the type of the ``args`` parameter?**

<br><br><br><br>

**2. If we run the App program, what will it print?**

<br><br><br><br>



## Reference Code

```java
// App.java
package midterm;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.ArrayDeque;
import java.util.HashMap;
import java.util.TreeMap;

public class App {
    public static void main(String[] args) {
        var xs = ConsList.list(33, 81, 72, 5, 53, 28);
        System.out.println("max of " + xs + " is " + maximum(xs));
        
        var ys = ConsList.list(5, 84, 16, 28, 11, 41);
        System.out.println("matches = " + matches(xs, ys));
    }

    
    static int maximum(ConsList<Integer> xs) {
        // TODO: Given a ConsList of non-negative integers, 
        // return the maximum value.
    }
    
    static int matches(ConsList<Integer> xs, ConsList<Integer> ys) {
        int count = 0;
        for (var xp = xs; !xp.empty(); xp = xp.rest()) {
           for (var yp = ys; !yp.empty(); yp = yp.rest()) {
               if (xp.first() == yp.first()) {
                   count += 1; 
               }
           }
        }
        return count;
    }
}
```

