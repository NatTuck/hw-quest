---
title: "cs2381 Notes: 13 Really Intro Stack"
date: "2024-09-24"
---

## New Topic: Stacks


A Stack is a sequence of items with a big restriction: You can only
access it from one end: the top.

There are two basic stack operations:

 - push - Add an item to the top.
 - pop - Get the top item, removing it from the stack.
 - isEmpty

Stacks commonly have a few other operations for convenience:

 - peek - Look at the top item without removing it.
 - size - Is stack empty?

For us at the moment, the simplest implementation of a Stack is a
ConsList. The top of the stack is the front of the list, and every
operation can be implemented in O(1) time.

We can think of Stack as being an interface:

```java
interface Stack<T> {
    /**
     * Add an item to the top of the stack.
     *
     * @param  item  The item to add
     */
    void push(T item);
    
    /**
     * Remove an item from the top of the stack and return it.
     *
     * @return The item
     */
    T pop();
    
    /**
     * Get the item from the top of the stack without removing it.
     *
     * @return The item
     */
    T peek();
    
    /**
     * Gives the number of items currently on the stack.
     *
     * @return Size of stack
     */
    boolean empty();
}
```

**Reverse an Array**

Simply pushing stuff onto a stack and then popping it will reverse a
sequence.

First, let's draw this on the board.

Then, let's look at code:


```java
import java.util.Stack;

...

    public static void main(String[] args) {
        int[] xs = {1, 2, 3, 4, 5};
        int[] ys = reverse(xs);

        for (int ii = 0; ii < xs.length; ++ii) {
            System.out.println(ys[ii]);
        }
    }

    static int[] reverse(int[] xs) {
        var st = new Stack<Integer>();
        for (int ii = 0; ii < xs.length; ++ii) {
            st.push(xs[ii]);
        }

        var ys = new int[xs.length];
        for (int ii = 0; ii < xs.length; ++ii) {
            ys[ii] = st.pop();
        }
        return ys;
    }
```

All of the operations of Java's Stack are O(1). What's the complexity
of reverse?

 - Two loops = 2*n
 - Drop the constant factor = O(n)

**Postfix to Infix**

https://www.codeproject.com/Articles/405361/Converting-Postfix-Expressions-to-Infix

When we write down arithmetic expressions, we typically put our operators
between their arguments - like "3 + 4".

Some calculators use an alternate order, called reverse polish
notation. In this system the operators come last. So the same
expression would be "3 4 +".

RPN has the advantage that there is one consistent rule for order of
operations: the operators that come first happen first.

Another traditional stack algorithm lets us convert a RPN expression
into an infix expression. The rules are:

 - Traverse tokens left to right.
 - If you have a number, push it onto the stack.
 - If you have an operator, pop two items from the stack and combine
   them with the operator, in parens. Push the result back on the
   stack.
 - When you run out of tokens, pop the stack for the answer.
 
Let's try some examples on the board:

 - 1 3 +
 - 29 34 + 81 54 + *

Now let's write some code:

```java
    public static void main(String[] args) {
        String postfix = "35 29 14 + *";
        String infix = postfixToInfix(postfix);
        System.out.println("postfix = " + postfix);
        System.out.println("infix   = " + infix);
    }

    static String postfixToInfix(String in) {
        String[] tokens = in.split("\\s");

        var st = new Stack<String>();

        for (int ii = 0; ii < tokens.length; ++ii) {
            String tt = tokens[ii];
            if (isOperator(tt)) {
                var a1 = st.pop();
                var a2 = st.pop();
                st.push("(" + a1 + tt + a2 + ")");
            }
            else {
                st.push(tt);
            }
        }

        return st.pop();
    }

    static boolean isOperator(String xx) {
        return xx.equals("+") || xx.equals("-")
            || xx.equals("*") || xx.equals("/");
    }
```

This same approach can be used to evaluate RPN expressions. Instead of
pushing the expression on the stack, we evaluate it and push the
result onto the stack.

Let's try some examples on the board:

 - 1 31 +
 - 3 4 + 2 1 + *


```java
    public static void main(String[] args) {
        String postfix = "3 29 14 - *";
        int yy = evalPostfix(postfix);
        System.out.println("postfix =  " + postfix);
        System.out.println("        => " + yy);
    }

    static int evalPostfix(String expr) {
        String[] tokens = expr.split("\\s");

        var st = new Stack<String>();

        for (int ii = 0; ii < tokens.length; ++ii) {
            String tt = tokens[ii];
            if (isOperator(tt)) {
                var a1 = Integer.parseInt(st.pop());
                var a2 = Integer.parseInt(st.pop());
                st.push("" + applyOp(tt, a1, a2));
            }
            else {
                st.push(tt);
            }
        }

        return Integer.parseInt(st.pop());
    }

    static int applyOp(String op, int xx, int yy) {
        switch (op) {
        case "+":
            return yy + xx;
        case "-":
            return yy - xx;
        case "*":
            return yy * xx;
        case "/":
            return yy / xx;
        default:
            throw new Error("bad op");
        }
    }
```
