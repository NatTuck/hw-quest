---
title: "cs2381 Notes: 01 Welcome"
date: "2024-08-25"
---

Data Structures First Day:

## Hello

 - Hello
 - Data structures?
   - How to structuring data
   - Second semester of programming
 - Attendence

## Data

 - The point of code is to transform data.
 - So to figure out what code you need, first you need to figure out:
   - What data you have.
   - What data you want to have.
 - Once you've figured out the data, the code tends to be pretty
   straightforward.

## Syllabus

 - Attendence is strongly recommended.
   - Also, eating and sleeping.
 - The lecture and lab are one course.
 - Lab assignments are the largest grade component. You'll work
   in pairs and write code.
 - The final exams are on paper, and really will include writing code with
   a pencil.
 - We'll see an autograding example in lab on Friday.
 - There will be tutoring at some point.
 - Please don't cheat.

## Introducing Java

I expect that you're familiar with Python.

This semester we're going to be working in Java. 

It makes sense to think of computer programming as one skillset. Many
of the concepts and techniques you learned in Python still apply in
Java. But there are significant differences and new stuff in the new
language as well.

The differences include the basic model of how a program is
structured.

In Python, a program is:

 - A collection of modules, each in its own file.
 - A module contains statements, which includes
   defining functions and classes.
 - One module in the program is the main module.
 - The program runs by executing statements from the main
   module in order.
 - Some statements cause conditional, repeat, or delayed execution,
   which makes things complicated.

```python
#!/usr/bin/env python

def greet(name):
    print("Greetings, " + name)

greet("Alice")
greet("Bob")
```

Now let's look at a similar program in Java:

```java
public class Greet {
    public static void main(String[] _args) {
        greet("Alice");
        greet("Bob");
    }

    static void greet(String name) {
       System.out.println("Greetings, " + name); 
    }
}
```

Run that with:

```bash
$ javac Greet.java
$ java Greet
```


In Java, we start by defining a class. Python has classes, but we
didn't need one for this program. In Java, you always need a class.

In Java, a program is:

 - A collection of packages (like Python modules), each of which lives
   in its own directory.
 - Each package contains a collection of classes, some of which get
   their own file.
 - A class contains methods. 
   - There are no functions (for now), just methods.
 - Methods contain statements. 
 - There is a main package, with a main class, which has a main method.
 - The program runs by executing the statements in that main method in order.
 - Definitions are not statements. The order of class and method declarations
   doesn't matter.

Try this:

```python
#!/usr/bin/env python

greet("Alice")
greet("Bob")

def greet(name):
    print("Greetings, " + name)
```

In Python:

 - Defining a function *is* a statement.
 - It happens in order.

Similarities:

 - Functions and static methods work similarly - you can name a sequence of
   statements and call it with arguments.
 - Both languages have strings, which look the same and can
   be concatenated with a "+" operator.
 - Both languages have operators.
 - Both languages have a way to print to the console.

Differences:

 - Java code always exists in a class, even if you're not trying to describe
   a new class of data.
 - Java has explicit, static types. The name parameter of the greet method is
   a String - we need to say that, and the compiler will check that we don't pass
   in anything else (try ```greet(5)```).
 - Java writes blocks with curly braces rather than a colon and
   indentation. This has concrete advantages over the Python system - like being
   able to correctly indent code automatically.
 - A Python program frequently includes a shebang line, which is typical for
   a Unix scripting language.
 - Running a Java program typically requires an explicit compliation step.

# Data in Python

 - Primitive Types
   - Number (int vs float), String
 - Tuples
 - Classes / Instances
 - Arrays
 - Dictionaries

# Data in Java

Dynamic vs static type system

 - Primitive Types
   - integers: byte, short, int, long
   - floating point: float, double
   - boolean
   - char
 - Native complex types
   - String
   - Class wrappers: Int, Float
 - Classes / Instances
 - Stuff like Arrays / Dictionaries are in the standard library
 
```
public static void main(String args[]) {
    float xx = 5.0;
    float yy = 3.5;
    System.out.println(xx + yy);
}
```
 
 
Classes: Data or code structure?

