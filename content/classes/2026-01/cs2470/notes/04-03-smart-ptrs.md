---
title: "Lecture Notes: 04-03 C++ Smart Pointers"
date: "2026-04-02"
---

## Last time

C++ is C with:

- Generics
- Classses
- A big stdlib
- Some smaller changes.

## This time

### RAII

Need to specifically talk about the RAII is pattern.

- Destructors let us free resources other than memory.
- Show file wrapper (we can even do this for open (2)).
- Show mutex wrapper.

### Then, more stdlib

- std::string_view - Look, it's slices

### And the key stuff

Two more stdlib features:

- std::unique_ptr / make_unique
- std::shared_ptr / make_shared

These are huge, and can save us from needing to manually call "delete" or
"free" almost ever.

Sequence:

- Port our conslist to use std::unique_ptr
- Make shared structure lists.
- Port our conslist to use std::shared_ptr
- Complain about circular lists.
- Demonstrate solving it with std::weak_ptr

When might we still need to manually call new / delete?

When might we still need to call malloc / free in a C++ program?

## Overflow

- Let's figure out lambdas and do a lambda example.
