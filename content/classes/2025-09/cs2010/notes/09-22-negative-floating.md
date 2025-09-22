---
title: "cs2010 Notes: 09-22 Negative, Floating"
date: "2025-09-20"
---

We've talked about:

- How to represent numbers in binary.
- How to convert to and from arbitrary bases, most relevantly hexadecimal
  to compactly display binary data.

That's neat, but it raises a more concrete question: How do computers
really store numbers?

**Bytes and Words**

The smallest unit that modern computers typically store is a byte, or
a block of 8 bits.

If we want to store a non-negative integer, one byte lets us store
a value between 0 and (2^8)-1 = 255.

Internally, one of the most common things computers use numbers for is as memory
addresses. Going back to our diagram of a computer, we've got a CPU and RAM. We
store data in RAM, and can do operations on the CPU.

So if we want to add two numbers:

- There's an adder circuit in the CPU.
- But first the two numbers need to be loaded from RAM into registers in the
  CPU.
- To load the numbers from memory we need addresses, which need to fit in
  registers too.

If we have 8-bit registers (a "word" is 8 bits), then we can store 8-bit memory
addresses. Typically each address in memory stores one byte of data, so an 8 bit
computer can have 256 bytes of RAM.

You can't do much with only a couple hundred bytes, so the first broadly adopted
computers were 16-bit machines. A register or memory address ("word") was two
bytes, and the maximum RAM they could handle was 2^16 = 65536 bytes. This is the
80's.

In the 90's, new home computers had 32-bit words and could address 2^32 = 4GB of
RAM (although actual computers from 1995 shipped with maybe 8MB).

And in the 00's, home computers moved to 64-bit words. That's 2^64 = 16 EB of
addressable RAM. The 2010's and 2020's so far haven't maxed that out, even for
heavy duty servers.

But even on a 64-bit system, you sometimes don't want to spend 8 bytes for every
integer. So we commonly see 8, 16, 32, and 64-bit integers.

**Negative Numbers**

Plan A: Sign bit.

Problems:

- There's two zeros.
- You need more complicated adders.

Crazy trick that solves both problems: Two's complement.

- To make a number negative: Flip all bits, add 1.
- Show this for some 4-bit numbers.
- Add -1 + 5.

Weird thing: Extra negative range.

Show negative numbers in hex.

**Floating Point Numbers**

binary32: 24 bit significand, 7 bit exponent, 1 sign bit

https://en.wikipedia.org/wiki/Minifloat

Let's look at the 8-bit 1.4.3 table.

