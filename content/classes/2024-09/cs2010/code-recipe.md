---
title: "Coding Recipe for JavaScript"
date: "2024-11-14"
---

{{< lead >}}
Coding Recipe for JavaScript
{{< /lead >}}

# Intro

We can think of a JavaScript program as a collection of functions.

If we can figure out how to write a function, we just have to do that
several times to write a whole program.


## Object Definitions

It's frequently useful to name a type of object. For example, we
might say:

// A Car has these fields:
//  - tankSize: Number, in gallons
//  - mileage: Number, in miles/gallon

Once we've done that, we can talk about Car in our signatures.


## How to Write a Function

Here are five steps:

 - Signature - What type of data are the function inputs and output?
 - Names - What's the name of the function and its arguments?
 - Examples - What are some inputs and corresponding outputs?
 - Standard pattern - Based on the types, what's the most likely thing
   we're doing in the function?
 - Code - What does the function need to do?


## Standard Pattern

 - What are our function arguments? We should use those.
 - For each one, we should do the standard thing with it based in its type.
 - What are we returning? How do we build it?


## Pattern: Simple Data

With simple data, there's no complex pattern.

 - For arguments, we should use them.
 - For a return value, we should calculate and return it.


## Pattern: Object

Each object should have an object definition.

An object has several fields.

 - For arguments, we should access the fields, either with dot notation
   or by unpacking the object into local varaibles.
 - If a field has a complex type, we should either follow its pattern
   or call a helper function to process it.
 - To return an object, we first need to construct it by assigning appropriate
   values to its fields.


## Pattern: List

For each list, we should specify what type of thing it contains.

 - For arguments, we should loop through the items in the list 
   (e.g. for (let xx of xs) { ... } ).
 - For a return value, we should start with an empty list and then
   add values at the end with the .push method.


