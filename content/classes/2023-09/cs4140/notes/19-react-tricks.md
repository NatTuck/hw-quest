---
title: "cs4140 Notes: 19 React Review"
date: "2023-10-07"
---

**Quick React Review**

Functional reactive programming.

What is functional programming?

Programming style focused on two key ideas:

 - Immutable data
 - Pure functions

**Immutable Data**

 - Immutable data can't be changed after it's created.
 - This can make programs easier to reason about, because
   that's a pretty strong invariant.
 - This allows for some optimizations.
   - e.g. React uses this to optimize equality comparisons: if data is
     immutable, then unchanged identity implies unchanged value.
 - This allows for some simplifications in programming style.
   - e.g. Immutable data is safe to read in multi-threaded code without
     locks.

**Pure Functions**

 - A pure function has no side effects.
   - Doesn't mutate global state.
   - Doesn't do any sort of I/O action. 
 - It takes some values as arguments, and doesn't mutate them.
 - It constructs one new value and returns it.
 - It doesn't rely on any mutable global state that isn't passed
   as an explicit argument.

This means:

 - A pure function will always produce the same value given the same
   arguments.
 - That means it's safe to memoize (i.e. cache).
 - That means it's safe to call extra times.

**Functional-Reactive Programming**

This is a way to handle interactive, graphical programs in a
functional style.

No program can be 100% functional. Anything useful that a program does
is a side effect and any non-trivial program requires changable state.

So functional programming works by trying to isolate those elements.

In functional-reactive programming, you've got the following ideas:

 - You've got one state value, managed by the runtime environment.
 - You have a render function. This is a pure function that takes the
   current state value as input and generates the current graphical
   view of the app. The simplest version would be a 3D game engine
   generating a single frame.
 - You have several event handler functions. These take an event (e.g.
   key press, mouse click, periodic "tick" to handle time passing) and
   the current state as input and generate a new state as output.
 - When the state changes, or at a fixed frame rate, the render
   function is called to genenrate the new view.

React works exactly like this, with three compliations:

 - The view is an HTML document, so the render function translates the
   current state to an HTML tree.
 - Browsers aren't great at doing complete re-renders, so react
   generates a "Shadow DOM" with the full document tree internally but
   then only requests that the browser render the changes from the
   current document state. So rendering everything on every event
   allows React to minimize actual rendering cost.
 - The render function, event handlers, and even application state are
   broken up into a bunch of little pieces.

   




