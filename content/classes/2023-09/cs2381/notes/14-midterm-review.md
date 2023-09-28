---
title: "cs2381 Notes: 14 Midterm Review"
date: "2023-09-28"
---

**Midterm**

Is still on Monday. That's next class.

**Today: Midterm Review**

Let's pull up the sample midterm on the site, and go through each question.

For each one:

 - What's the answer?
 - What related topics should we review?

Is there anything else we should cover?

## Overflow: RPN Calculator

This same approach can be used to evaluate RPN expressions. Instead of
pushing the expression on the stack, we evaluate it and push the
result onto the stack.

Let's try some examples on the board:

 - 1 31 +
 - 3 4 + 2 1 + *

```java
    public static void main(String[] args) {
        var term = System.console();
        while (true) {
            String expr = term.readLine("rpn> ");
            int yy = evalPostfix(expr);
            System.out.println("postfix =  " + postfix);
            System.out.println("        => " + yy);
        }
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
    
    static boolean isOperator(String xx) {
        return xx.equals("+") || xx.equals("-")
            || xx.equals("*") || xx.equals("/");
    }
```
