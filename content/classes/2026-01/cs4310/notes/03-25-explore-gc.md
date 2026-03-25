---
title: "Lecture Notes: 03-25 Exploring GC"
date: "2026-03-23"
---

The homework where you set up riscv boards and write some asm is posted.

For the homework after that, you'll build a garbage collector for C.

Today, we'll start exploring the problems that you'll run into.

## Review: Mark and Sweep GC

- Users allocate bytes our custom malloc: gc_alloc
- Users never call any "free" function.
- Calling gc_alloc occasionally triggers garbage collection.

Garbage collection:

- To start, no allocated objects are marked.

Mark:

- Starting at the roots (stack, globals), we scan for pointers to allocated
objects.
- When we find a pointer to an object, we mark it, and then scan that object
for more pointers.

Sweep:

- Once the scan is done, we sweep.
- For each object, if it's not marked, we free it.
- For each object, if it is marked, we unmark it to prepare for the next
marking phase.

## Problems

**Identifying Roots**

There's no way for us to find global variables that contain pointers to GC
objects, so users will need to register them.

At GC time, the *entire* stack will need to be treated as one big GC root. That
means we need to know the top and bottom of the stack. *How?*

## Simplest Design

- Free list
- Used list

(both sorted by memory address, with global head and foot ptrs)

```
do_gc():
 scan_from_roots_and_mark()
 for each in used: if not marked, free
 for each in used: unmark
```
  
## Scanning for Pointers

Given a range of memory that might contain pointers:

- Check each aligned, 8 byte block. Each of those might be a pointer.
- If the value is between addr(used_head) and addr(used_foot), then scan the
used list for matching ptrs and mark them.
- That may have false positives. Fine.

That's a plan. Let's start experimenting.

- Can we find the top of the stack? Probably need a gc_init() macro that gets
called from main(). May need to round to page boundary.
- Easier to find bottom of stack.

Great. Let's build the thing.
