---
title: "cs2381: Design Recipe"
date: "2023-09-01"
---

## Design Recipe for a Method

To design a method, follow this design recipe:

 - Stub method
   - Name, return type, argument names with types, static?
   - Trivial return statement if needed
 - Javadoc
   - Purpose statement
   - @param lines
   - @return line
 - Examples
   - Based on the problem statement, write one or more examples
 - Initial Tests
   - Translate the examples into tests
 - Template
   - Based on the arguments to your method, figure out what you
     have to work with and write that down.
 - Write the function body
 - More tests
   - Add tests that exercize any code in the function body
     that isn't covered yet.
   - Add tests for edge cases.

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

## Design Recipe for a Program

A Java program is a collection of Classes, Records, and Interfaces.

If you design all the pieces, you've designed the program.

If you don't know where to start, you know you need a main class (with
a static main method), so start there. As you discover more pieces you
need, design those too. Repeat until done.
