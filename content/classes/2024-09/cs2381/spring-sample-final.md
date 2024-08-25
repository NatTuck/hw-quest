---
title: "cs2381: Spring Practice Final"
date: "2024-08-01"
---

[&larr; Back to Course Site](../)

## Practice Final Exam: cs2381 Spring 2024

This sample exam is provided to help provide some direction in
studying for the upcoming final.

Keep in mind that anything we've covered in class, in lab, or in a lab
assignment may be on the exam.

These questions reference the code provided at the end of the exam.
Skim that first to see what the questions are talking about.

The answer to an "asymptotic complexity" question on this exam will be
one of: O(1), O(log n), O(n), O(n log n), O(n^2), O(n^2 log n),
O(n^3), O(2^n)

**1. In the SeaApp#main method, what is the type of the ``args`` parameter?**

<br><br><br><br>

**2. In the SeaApp#main method, what is the type of the ```nums``` variable?**

<br><br><br><br>

**3. If we run the SeaApp program, what will it print?**

<br><br><br><br>

**4. What is the asymptotic complexity of the SeaApp#squid method? Why?**

<br><br><br><br>

**5. What is the asymptotic complexity of the SeaApp#crab method? Why?**

<br><br><br><br>

**6. What is the asymptotic complexity of the SeaApp#tuna method? Why?**

<br><br><br><br>

**7. How many bytes does it take to store the declared fields of a Pair record? Why?**

<br><br><br><br>

**8. Why is the complexity of ArrayList#add "amortized" O(1) rather than just O(1)?**

<br><br><br><br><br><br>

**9. What are the names and descriptions for the standard operations for a Stack?**

<br><br><br><br>

**10. How is a Stack different from a Queue?**

<br><br><br><br>

**11. If a multithreaded program that makes good use of many cores
takes 12 seconds on 12 processor cores, how long would you expect it
to take on 6 cores? Why?**

<br><br><br><br>

**12. Write the body of SeaApp#keepUnique. This should return a new
List, not modify the input, and run in O(n) time in the size of the input.**

<br><br><br><br><br><br>

**13. Give one example of a type in Java that is not a primitive type.**

<br><br><br><br>

**14. What are two effects of declaring a type as a record rather than as a class?**

<br><br><br><br>

**15. Why might you want to use a TreeSet instead of a HashSet?**

<br><br><br><br>


## Reference Code

```java
package exam;

import java.util.ArrayList;
import java.util.List;
import java.util.HashSet;

public class SeaApp {
    public static void main(String[] args) {
        var nums = new ArrayList<>(List.of(1,2,3,4,5));
        var retv = tuna(nums);
        System.out.printf("squid => %d, crab => %d\n", retv.xx(), retv.yy());
    }

    static Pair tuna(ArrayList<Integer> xs) {
        var sq = squid(xs);
        var cr = crab(xs);
        return new Pair(sq, cr);
    }

    static int squid(ArrayList<Integer> xs) {
        if (xs.isEmpty()) {
            return 3;
        }
        var aa = xs.get(0);
        xs.remove(0);
        return aa + squid(xs);
    }

    static int crab(ArrayList<Integer> xs) {
        var yy = 3;
        for (var xx : xs) {
            yy += xx;
        }
        return yy;
    }
    
    static List<Integer> keepUnique(List<Integer> xs) {
       // Build and return a new ArrayList containing
       // each item from xs only once.
       
       // Examples: 
       //  - keepUnique([1,1,1,1,1,2,1,1,2]) -> [1,2]
       //  - keepUnique([1,2,1,5,3,2,3,4,5]) -> [1,2,5,3,4]
    }
}

record Pair(int xx, int yy) {
    // pass
}
```

