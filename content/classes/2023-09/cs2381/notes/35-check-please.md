---
title: "Notes: 35 Check Please"
date: "2023-11-27"
---

I grabbed the menu from a local chinese restaraunt:

https://www.hongkonggardenplymouth.com/menu/menu-1.php

At least for page 1 of the menu, every item has a code. That means we
can (almost) describe an order with a list of codes.

 - Problem: Some items say "Chicken or Beef"; we'll igore that.
 - Problem: Duplicates; we can just have duplicates in our list.

Let's build the worst point of sale system for this restaraunt:

 - Interactive terminal program.
 - User types in an order (list of codes)
 - Program prints a bill

A bill is:

 - A list of: item, price each, quantity, item total
 - A subtotal
 - A total with 6.25% meal tax included

We want our program to be efficient so:

 - We'll read in the menu data at startup and process it in O(n) time in the
   size of the menu.
 - We'll make sure that we can generate our bill in O(n) time in the size
   of the order.

I've pre-processed the menu into a tab-separated text file, tossed
that in our resource directory, and added some code to read it:

```java
    Stream<String> readMenuLines() {
        InputStream txt = App.class
            .getResourceAsStream("/menu.tsv");
        InputStreamReader rdr = new InputStreamReader(txt);
        BufferedReader buf = new BufferedReader(rdr);
        return buf.lines();
    }
```

And here's some hints for console read / write:

```java
import java.io.Console;

    Console con = System.console();
    var line = con.readLine("order> ");
    con.printf("Your order: [%s]\n", line);
```


But from there, we're going to build this using standard library tools.

Hints:

 - Split lines with String#split
   - Talk about regular expressions
   - Split on literal tab
 - For O(1) lookup, we want HashMap
   - get
   - put
 - We want to store the whole menu line, so we need a MenuItem record.
 - So setup is:
   - Read the menu data, build MenuItems, stick in HashMap keyed by code.
 - For each order:
   - Split on non-word
   - Easy to get list of MenuItem
   - To handle multiples, we need BillRow record with quantity.
   - To do that in O(n) time, we need another HashTable
   - Then we can print out order.
 - Tradeoff: Print bill in alphabetical order? Requries sorting or treemap,
   which would make this take O(n log n) time.

