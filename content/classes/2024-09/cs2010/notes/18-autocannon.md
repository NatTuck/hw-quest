---
title: "cs2010 Notes: 18 Autocannon"
date: "2024-10-20"
---


We have our ram/cannon code from last time. Now it's time to see what happens
if we have multiple things:

 - First, allow multiple cannon balls.
 - Then, allow multiple rams.

Core ideas:

 - Helper functions for nested data.
 - The standard pattern for an object is to unpack it and then use
   the pieces.
 - The standard pattern for a list is to loop through it.

New trick:

 - We can use the spread operator ```{...oldObj, field: value}``` to
   construct new objects similar to old ones.
