---
title: "cs2010 Notes: 26 Semester Review"
date: "2024-12-05"
---


## Final Exam info:

 - Wed Dec 11 @ 8am - 10:30am



## Semester Review

### What's a computer?

 - Could be broadly defined, but
 - "A programmable electronic device"
 
What is computer science?

 - The study of computer programs.
 - What can they do?
 - What can't they do?
 - How do you write them?

 
### Parts of a Computer

Conceptual Model

 - CPU
 - RAM
 - Storage
 - I/O devices


### Data

Computers typically store data as binary digits (bits), which are
typically described as either a zero or one. In hardware,
differentiating zero volts vs more than zero volts is easier than
distingushing different voltage levels.

One or more bits can be used to represent values that are interesting
to users are programmers.

If that value is an integer than can be only zero or one or a boolean
value (true / false), then how bit values map to domain values is
pretty obvious.

For anything more complex, you need some scheme for encoding values.

Encoding integers:

 - Fixed number of bits.
 - Binary number.
 - Place value
 - Complication: Byte ordering, endianness

More complicated:

 - Encoding two integers.
 - Encoding an array of integers (C vs Java {size, ...data})
 - Encoding a string (C vs. Java)
 - Encoding an image.


### Algorithms

A well-orderecd collection of unabigiously and effectively computable
operations that, when executed, produces a result and halts in a
finite amount of time.

 - Well-ordered collection?
 - Effectively computable?
 - Produces a result?
 - Halts in finite time?


### Ways to express algorithms

You can try to express an algorithm as text, but it's likely to be
unclear.

More clear ways to specify the steps exactly include:

 - Pseudocode 
 - Flowcharts
 - Code


### Boolean Logic

 - Basic operators: AND (·), OR (+), NOT (')
 - Truth tables

Uses of boolean logic:

 - Logic and conditions in computer programs (e.g. in an if statement)
 - Digital circuit design


### Base Conversions

 - We typically use base-10 numbers.
 - Computers typically store data as binary numbers.
 - Representing binary numbers as hexidecimal (or octal) is convenient.
 - The exam may have a conversion problem to some other base.
 - So it's useful to figure out how to convert bases.

Basic concept: Place-value notation.

For any base, you've got a digit for each power of that base, showing
how many of that power you have in the number.

Examples: 

 - What's the decimal value of base 7 "325"?
 - Convert binary "10101" to base 3.



### Binary Arithmetic

 - Addition, Subtraction, Mulitplication, Division



### Negative numbers:

 - Plan A: Sign-magnitude.
   - Problem: Negative numbers need special handling for arithemtic.
 - Plan B: Two's complement (flip all bits, add one, ignore overflow)
   - Works for addition and subtraction just like unsgined.


### Logic Gates and Circuits

 - We can represent any boolean expression as a circuit / logic diagram.


### Simplification wtih K-Maps

 - This lets us optimize boolean expressions.


### Programming in JavaScript.

 - A program is a series of statements, which run in order.
 - Some statements have associated blocks of code (in curly braces) that
   are executed conditionally, repeatedly, or delayed for later execution.
 - We can store values in variables to use later. The value in a variable can
   typically be updated / modified as the program executes.
 - Functions are a mechanism to name a block of code to be executed with
   some parameters; these are the basic building block of more complicated
   programs.
 - Code Recipe:
   - Signature
   - Names
   - Examples
   - Standard Pattern
   - Code

### Examples and Assignments

 - Graphical browser examples
 - Big homework
 - Cookie Clicker
 - Function recipe
 - Web app
 - Word Game


### Networking Stuff

 - Network Addresses
 - Protocol Layers
 - Basic Security Stuff
 - HTTP Server


### That's it. Questions?







