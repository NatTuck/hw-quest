---
title: "cs4140 Notes: 10 FP and Deploying"
date: "2024-09-17"
---

# Functional Programming in Elixir

Intro:

 - Elixir is built on the Erlang Virtual Machine
 - Elixir has basically the same semantics and behavior as Erlang with
   different syntax and a more modern and familiar standard libary.
 - The main design goal of Erlang was reliability, which lead to two
   focuses different from other languages: functional programming and
   a focus on distributed/concurrent applications.
 - We'll talk more about reliability, concurrency, and distributed
   apps later.

Elixir is a Functional language 

Functional languages have three key properties:

 - First class functions, but most modern languages do that
 - Immutable data
 - Pure functions

This has some benefits:

 - This style of function is similar to mathematical functions and allows for
   mathmatical reasoning.
 - In a pure function, functions always give the same output for the same input.
 - That makes testing easy: testing outputs for inputs is the whole testing process.
 - That means you can do tricks like memoization, where once you compute a function
   for a given input once you can cache that result.
 - Composability: Functions combine in predictable ways that you can reason about
   without worrying about side effects or implicit state.

Having the language enforce this has some downsides:

 - You can't mutate a loop index, so all repetition must be done by recursion rather
   than looping.
 - Really pure functions mean no side effects. Elixir doesn't go that far in general,
   but it does force all state to be made implicit.
 - You need to think in a functional style. You're always producing a new object
   rather than modifying an object, and you produce it "all at once" rather than
   as a sequence of modifications.
   
Example: Compare the two version of addOneToAll(List) in Python, then show in
Elixir.

Server-side web apps conceptually map well to pure functions:

 - Version 1: The web app server is a pure function mapping an HTTP request
   to an HTTP response.
 - Version 2: The web server is a pure function mapping an HTTP request to a
   list of database actions, followed by a pure function mapping the request
   and the database query results to a response.
 - In Phoenix, controller actions are impure functions if they do DB queries,
   but most of the rest of the work are various pure functions (e.g. templates
   are pure).

# Deployment

We're going to build deployment scripts for Party Animal and use them
to deploy our latest change. This should result in full documentation
of the (dev mode) deployment process.
