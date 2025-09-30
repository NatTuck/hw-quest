---
title: "cs2381 Notes: 10-01 More Vibes"
date: "2025-09-29"
---

## Better Vibe Coding

Last time we tried to build Missile Command.

We flailed a lot, and didn't make that much progress.

Today, we're going to restart, and we're going to use some better
techniques:

- A design notes document.
- An explicit architecture:
  - Separate data and rendering
  - Data Model - let's do an immutable, simulation style design.
  - Thinking about events better: inputs, tick
  - Testability
- Then we'll build our app in stages:
  - Data, tests
  - Event handlers, tests
  - Rendering, tests
- Also, we're allowed to type code, especially for data design.

Let's see how far we can get generating something a bit more coherent
and intentional.



