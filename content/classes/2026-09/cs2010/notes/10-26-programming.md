---
title: "cs2010 Notes: 10-26 Programming"
date: "2026-10-24"
---

Today we're going to explicitly look at programming, and how it fits into the
story we've been building up all semester.

To review, our basic story is:

- To understand and make good use of computers, we need to think about how data
is represented and transformed.
- Data at rest tends to live in files.
- We tend to transform data by running programs that read and write files.

That's great, if the program that does the transformation we want exists and we
have a copy, but frequently we want to do something that no program we have
does.

Luckily, we can write a new program that does basically whatever we want, as
long as we have a reasonable understanding of what computers and computer
programs can do.

## Key idea: Layers of Abstraction

The basic function of a computer is pretty simple:

- The computer reads an instruction from RAM into the CPU.
- That instruction can do one simple thing:
  - Arithmetic on two numbers.
  - Load or store data to/from memory.
  - Change what instruction runs next.
- Repeat forever.

So, for example, we might have a program with these instructions:

```
i = 0
sum = 0
again:
  load x from address base + i
  add x to sum
  if i > 10, goto done
  goto again
done:
```

That's going to add up 10 numbers.


[Notional Machine Slides](
https://nattuck.github.io/cs2010-slides/notional-machines-slides/#/title-slide)










