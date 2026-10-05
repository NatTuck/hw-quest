---
title: "cs4140 Notes: 10-05 Programming Languages"
date: "2026-10-03"
---

If we're using LLMs to write code *and* assist with code reviews, why would we
pick any specific programming language?

- Platform support
- Existing libraries
- Immediate performance
- "Language runtime" features
- Correctness enhancing features

Platform support has always been a concern, but is also innately flexible:

- C is the native language on Linux / Unix
- That doesn't mean all Linux programs are written in C
- Similarly with C / C++ / C# for Windows or C / Swift / whatever for Mac

Some especially interesting languages:

- Rust
- Elixir / Erlang
- Go
- TypeScript

Why specifically Elixir?

- Problem: Telecom Switches
  - Reliability
  - Redundancy
  - Concurrency
  - I/O dominates performance
- Internet servers
  - Similar problems
  - With other uses for concurrency too
- Functional programming
  - Immutability
  - Pure functions
  - Explicit state
    - Defined data
    - Any "mutation" is creating a new object
    possibly passed to a recursive call
- Message passing
  - Clear concurrency model
  - Transparent across several machines
- Soft real-time + processes
- Our problems specifically
  - Transient server-side state
  - GenServer (a process that holds state
  and the rules for interacting with it)
  - Horizontal scaling
  - Supervision trees

Modeling Grange with OTP
