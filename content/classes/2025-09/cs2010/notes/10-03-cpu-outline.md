---
title: "cs2010 Notes: 10-03 CPU Outline"
date: "2025-10-02"
---

Today is our last day of non-review discussion of bits, number storage, boolean
logic, and circuits. After the midterm, you'll next see these topics in
the Computer Hardware class.

Midterm: 

- One week from today
- In this classroom
- On paper
- Bring a pencil, notes on paper, and an internet-disconnected calculator
  if you have one.
- We'll review midterm topics on Monday.

Today: Sketching the rest of a CPU

We have:

- A circuit that adds two numbers (an adder).
- A circuit that can store a number (a register).
- For today's exercise, let's say "a number" is 16 bits.

We need:

- Arithmetic Logic Unit
  - An adder
  - A subtracter (this is just an adder, but we two's complement the second
    number before adding).
  - A multiplier
  - Whatever other operations
  - Circuitry to activate only one operation.
  - So we have three inputs and one output:
    - operation
    - input A
    - input B
    - output
- Register file
  - A bunch of registers (say, 8)
  - Circuitry to select a single register
  - Circuitry to read the selected register
  - Circuitry to write the selected register
- A memory
  - This is just a big register file. Instead of having 8 registers,
    we have 64k or 100 million or something.
  - Typically we do byte addressing, but we could do 16 bit word addressing
    to make our story simpler right now.
- A CPU
  - Our CPU reads a fixed size instruction from memory at the address specified
    by a reserved register (the "program counter").
  - Then it executes that instruction.
    - The first few bits are a number specifying *which* instruction.
    - The next specify what the instruction operates on (e.g. which registers).
  - The instruction reads some input registers, writes an output register,
    uses the ALU, maybe does something with RAM.
  - Then the CPU increments the program counter and reads the next instruction,
    repeating forever.

Example:

- Instructions are 16 bits.
- The first 7 bits specify which instruction.
- The remaining 9 bits specify three registers: inputs A, B and output.
- So ADD, r0 + r1 => r2 might be 0000 000 000 001 010
- Can we really do this in one clock cycle?
- What if one of the input registers is also the output register?


More complex example:

- Let's write a computer program that determines how many bits
  are set in a number.
- Our computer is really simple - you punch in a number on a keypad
  which is shown on a numeric display showing the value of register
  0. You press the RUN button, the stored program runs, and the single
  number output is whatever is in register 0 when it's done.
- The stored program lives at memory address 0x100 (256).


```
r1 = 0
while r0 > 0:
  if r0 & 1 != 0:
    r1 += 1
  r0 = r0 / 2
r0 = r1
```









