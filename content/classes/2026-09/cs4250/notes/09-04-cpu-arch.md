---
title: "cs4250 Notes: 09-04 CPU Arch"
date: "2026-09-01"
---

- Remember: Attendance on Inkfish.
- Note to self: Prep for GPIO lab next week, get people to bring USB C cables
that can plug into their computer.

## Computer Programs

- A computer program is a sequence of instructions in memory.
- The CPU has a register, the instruction pointer, that points at the
current instruction.
- The CPU needs to:
  - Load the current instruction
  - Decode it
  - Fetch args
    - Registers? Pretty fast.
    - Memory? Way slow.
  - Execute the instruction
  - Store result(s)
    - Register? Fast
    - Memory? Slow
  - Update the instruction pointer
    - Usually next instruction
    - But jumps mean we need to point somewhere else

Design questions:

- How big is an instruction?
- Why short / long?
- Fixed length or variable?
- What sort of operation does one instruction let you do?
- Does the design have consistent formats for some or
all instructions?

Real arch:

- RISC-V 32 / 64 use fixed 32 / 64 bit instructions.
  - Each instruction is reasonably simple.
  - Instructions largely have 1 or 2 register inputs and one register output.
  - Some user-visible instructions are pseudoinstructions or aliases for other
  instructions (or pairs). 
- AMD64 can be from 1 to 15 bytes.
  - In 32-bit x86, "inc %eax" could be expressed as one byte.
  - In 64-bit, there are fewer useful one byte instructions, but stuff like cltq
  (sign extend eax to rax) is still one byte.
- The Intel Itanium arch, used 128 bit instructions, where each instruction was
really several instructions to run in parallel. Several GPUs use this sort of
VLIW instructions with 2-4 "instructions per instruction".

In the 80's, "Acorn Risc Machines", who later became ARM, made a *huge*
marketing deal bout the difference between "RISC" machines with simple
instruction sets and "CISC" machines with complex instructions.

In the late 80's they may have been right. Simpler machine code meant simpler
circuits meant higher clocks, etc.

By ~2000, "CISC" machines translated to RISC-style micro-operations before
execution. And "RISC" machines batched instructions together and re-ordered them
for increased efficiency and concurrency. And the fancy new thing was VLIW,
where instructions come in batches and the compiler pre-schedules them. But VLIW
could be executed mostly sequentially, and RISC can be executed out-of-order,
etc.

So the instruction set matters a bit, but much more important is what the CPU
does with whatever instructions it gets.

Let's look at some slides... start with deck 07.
