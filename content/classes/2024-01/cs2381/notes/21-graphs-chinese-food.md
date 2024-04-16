---
title: "cs2381 Notes: 21 Graphs and Chinese Food"
date: "2024-04-15"
---

### More on Graphs

Single-source shortest path

**Dijkstra's Algorithm**

 - For each node, track the following info in a single mutable map:
   - Estimated distance.
     - Intially zero for starting node, +inf for others.
   - Best previous node.
     - Initially null.
   - Fully Explored.
     - Initially false.
 - Keep a priority queue of next nodes to explore.
 - For the current node:
   - Check each neighboring node that isn't fully explored.
   - If the path through the current node is shorter, update
     the best previous and distance to use that and add that
     node to the priority queue with distance as priority.
   - Once all neighbors have been checked, mark this node as
     fully explored.
 - Pull next node from the priority queue. If this one's already
   explored, pull another one.
 - Once the dest is reached, traverse previouses.

**A-star**

 - Use estimated distance - including distance to goal - to order
   priority queue.
   
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

Start with the chinese-menu demo in the scratch repo.

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




```java
package demo;

import java.io.Console;
import java.io.InputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.TreeMap;
import java.util.List;
import java.util.stream.Stream;
import java.util.zip.GZIPInputStream;

public class App {
    public static void main(String[] args) {
        var menu = new HashMap<String, MenuItem>();
        for (var line : readMenuLines()) {  // O(n) in size of menu
            var parts = line.split("\t"); // total: O(n) in size of menu
            var code = parts[0];  // O(1)
            var name = parts[1];  // O(1)
            var price = parts[2]; // O(1)
            var item = new MenuItem(code, name, priceToCents(price));
                 // total: O(n) in size of menu
            menu.put(code, item); // O(1)  - expected, amortized 
        }
        // Loop:
        //  - O(n) * (4 * O(1))
        //  -  + 2 * O(n)
        // = 6 * O(n)
        // = O(n)

        var con = System.console();

        while (true) {
            var orderText = con.readLine("order> ");
            var itemCodes = orderText.split("\\W"); // O(n) in input size

            var receiptLines = new TreeMap<String, ReceiptLine>();
            //var receiptLines = new HashMap<String, ReceiptLine>();
            for (var code : itemCodes) { // O(n) in input size
                var item = menu.get(code); // O(1)
                if (receiptLines.containsKey(item.name())) { // O(log n) 
                    var line0 = receiptLines.get(item.name()); // O(log n)
                    var line1 = new ReceiptLine(item, line0.count() + 1); // O(1)
                    receiptLines.put(item.name(), line1); // O(log n)
                }
                else {
                    var line = new ReceiptLine(item, 1); // O(1)
                    receiptLines.put(item.name(), line); // O(log n)
                }
            }

            // One whole loop iteration is O(n log n)

            //   O(n) in input
            // + O(n) * O(log n) = O(n log n)


            // + O(n) in input * (O(1) + O(log n) + O(log n))
            // + O(n) in input  (was # of recipt lines)
            // + O(n) in input  (was # of recipt lines)

            // # of receipt is O(# of input codes)

            // O(n) in # of recipt lines
            var receipt = new Receipt(receiptLines.values().stream().toList());
            // O(n) in # of recipt lines
            con.printf(receipt.toString());
        }
    }

    static int priceToCents(String price) {
        var parts = price.split("\\.");
        return 100 * Integer.parseInt(parts[0]) +
            Integer.parseInt(parts[1]);
    }

    static List<String> readMenuLines() {
        InputStream txt = App.class
            .getResourceAsStream("/menu.tsv");
        InputStreamReader rdr = new InputStreamReader(txt);
        BufferedReader buf = new BufferedReader(rdr);
        return buf.lines().toList();
    }
}

record MenuItem(String code, String name, int cents) {
    String price() {
        return PH.toDollars(cents);
    }
}

record Receipt(List<ReceiptLine> lines) {
    private int subtotalCents() {
        int cents = 0;
        for (var line : lines) {
            cents += line.item().cents() * line.count();
        }
        return cents;
    }

    String subtotal() {
        return PH.toDollars(subtotalCents());
    }

    private int taxCents() {
        return (int) Math.round(0.0625 * subtotalCents());
    }

    String tax() {
        return PH.toDollars(taxCents());
    }

    private int totalCents() {
        return subtotalCents() + taxCents();
    }

    String total() {
        return PH.toDollars(totalCents());
    }

    @Override
    public String toString() {
        var yy = new StringBuilder();
        yy.append(" == Your Receipt == \n");
        for (var line : lines) {
            yy.append(line.toString());
        }
        yy.append(String.format("subtotal:\t\t%s\n", subtotal()));
        yy.append(String.format("tax:\t\t%s\n", tax()));
        yy.append(String.format("total:\t\t%s\n", total()));
        return yy.toString();
    }
}

record ReceiptLine(MenuItem item, int count) {
    int totalCents() {
        return item.cents() * count;
    }

    String total() {
        return PH.toDollars(totalCents());
    }

    @Override
    public String toString() {
        return String.format("%s\t\t%s\t%d\t%s\n",
                             item.name(), item.price(), count(), total());
    }
}

class PH {
    static String toDollars(int cents) {
        long dollars = cents / 100;
        long frac = Math.floorMod(cents, 100);
        return "$" + dollars + "." + frac;
    }
}

/*
A receipt is several lines, each one has:
    - A menu item
    - Count ordered
    - Calculate a total
Additionally:
    - Subtotal
    - Tax
    - Total
*/
```


    

