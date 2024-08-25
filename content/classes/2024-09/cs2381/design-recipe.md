---
title: "cs2381: Design Recipe"
date: "2024-01-24"
---

[&larr; Back to Course Site](../)

## Design Recipe for a static method

To design a static method, follow this design recipe:

 - Javadoc
   - Purpose statement
   - @param lines
   - @return line
 - Stub method
   - static, Name, return type, argument names with types
 - Tests
   - Based on the problem statement, write one or more tests
 - Standard pattern
   - Which argument are you primarily operating on?
   - Based on the type of the primary argument to the method, what's
     the normal thing you do with one of those?
 - Write the function body
 - More tests
 

## Design Recipe for an instance method

To design an instance method, follow this design recipe:

 - Javadoc
   - Purpose statement
   - @param lines
   - @return line
 - Stub method
   - not static, Name, return type, argument names with types
 - Tests
   - Based on the problem statement, write one or more tests
 - Standard pattern
   - Rather than find a primary argument, you've got to consider
     the arguments to the method and the fields of the class.
   - Which thing are you operating on, and how do you normally
     operate on that type of thing?
 - Write the function body
 - More tests
 

## Design Recipe for a Record

A Record is a composite data type with a selection of fields
and maybe some methods.

Follow this design recipe:

 - Stub record
   - Name, field names with type
 - Javadoc
   - Purpose statement for the record.
   - @author line
   - @param lines for each field
 - Methods
   - For each method, follow the design recipe for a method.

## Design Recipe for a Class

 - Class name
 - Javadoc
   - Think: Is this class to organize data or logic?
     - Normally shouldn't do both.
     - Static methods hint at a logic class.
     - Non-static fields hint at a data class.
     - If data class, should this be a record?
   - Purpose statement for the record.
   - @author line
 - Methods
   - For each method, follow the design recipe for a method.
   - If data class, consider:
     - Constructor(s)
     - Standard methods: equals, hashCode, toString, 
       getters/setters, etc
     - Should this be immutable (all fields final)?

## Design Recipe for an Interface

 - Interface name
 - Javadoc
   - Purpose statement
   - @author
 - Methods
   - Since these are stub methods, they only need:
     - Stub, with no body
     - Javadoc
 - Note: Methods that implement interface methods should
   say ```@Override```, which means they don't need their
   own Javadoc.

## Design Recipe for a Program

A Java program is a collection of Classes, Records, and Interfaces.

If you design all the pieces, you've designed the program.

If you don't know where to start, you know you need a main class (with
a static main method), so start there. As you discover more pieces you
need, design those too. Repeat until done.
