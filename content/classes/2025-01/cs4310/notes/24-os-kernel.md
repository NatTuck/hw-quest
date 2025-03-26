---
title: "Lecture Notes: 24 OS Kernel"
date: "2025-03-24"
---


## First, Project 1 questions?

 - How to optimize
 - How to deal with mutexes


## New Topic: OS Kernels

The kernel is component of the operating system that runs when the
machine is fully booted and has unrestricted access to the hardware.

Here's some stuff that kernel code can do that userspace code
(normal programs) can't do:

 - Use physical memory addresses.
 - Execute any CPU instruction.
 - Change special CPU registers (e.g. the one that sets page tables).
 - Directly send commands to hardware (e.g. disks, network interfaces,
   IO devices, etc)

That means we should look at two things:

 - How the kernel can talk to hardware.
 - How user programs can talk to the kernel.


## Kernel <=> Hardware

Go through slides #28 - #48:

https://homework.quest/classes/2025-01/cs4310/christo-slides/3_Arch_and_Kernels.pptx


## User Program <=> Kernel

On 32 bit Intel, there was no syscall instruction. Instead, you'd say "int 0x80".

That simplifies the model. When an interrupt occurs, from hardware *or* from user code:

 - The user code stops running.
 - Kernel code runs, and saves all registers to the stack.
 - The interrupt number is used as an index into the "interrupt vector",
   an array of function pointers.
 - The interrupt handler runs.
 - When the interrupt handler is done, the kernel "returns" from it.
 - The user registers are restored from the user stack.
 - Then user execution continues from the restored program counter register.

Overflow: Finish the slides from #49.
