---
title: "cs4250 Notes: 09-02 Electronics"
date: "2026-09-02"
---

- This is CS 4250 Computer Architecture
- I am Nat Tuck
- We're doing attendance on Inkfish.

## Electronics Review

- Our power supply gives us volts.
- Power is measured in watts, which is volts X amps.
- Amps (measure current, or number of electrons going by per second) are a good
measure of whether or not our stuff will melt or let out the magic smoke.
- In a circuit, Ohms law applies: V = I×R

Our goal with electricity:

- We've picked some components. We want them to work.
- We power components by applying voltages to them.
- Voltage too low, part doesn't work.
- Voltage too high, I = V/R, current too high, magic smoke comes out.

## Resistors

A resistor is a component that:

- Limits current (to I = V/R).
- Drops voltage (by V = I×R).
- Generates heat (by W = V×I = V^2/R; note that V here is the voltage drop, 
for this resistor not the voltage of the full circuit). 

Our most likely use of resistors is going to be to limit current (and thus
avoid components generating more heat than we want).

## Capacitors

- Capacitors store power and can be used to smooth out varying voltages in
various ways.

## Inductors

- These exist. I have no idea what they're for.

## Diodes

- Diodes only allow current to flow one way.
- They have a voltage drop and emit heat (or light), but don't follow Ohm's law.

How diodes work is both neat and potentially relevant:

- For a material to conduct electricity, electrons need to be able to move
through it. That means you need both a loosely bound electron that can move, and
a nearby empty space that it can move to.
- Insulators are materials that are missing either those mobile electrons or the
empty holes for them to move to, frequently because the electron shells in the
material are full - the next shell is too far away in energy for electrons to
jump up to the empty spaces there.
- Semi-conductors are like insulators, but the energy gap is smaller.
- Doped semiconductors have either extra free electrons (n type) or extra holes
(p type).
- If you put an N type semiconductor next to a P type one, you may get a diode.
At the boundary, electrons can freely move N->P, but trying to push them P->N
increases the energy difference and gets you an insulator and no current.

![led band gap](../led-band-gap.png)

(Ref: https://eng.libretexts.org/Bookshelves/Materials_Science/Supplemental_Modules_(Materials_Science)/Semiconductors/Light_Emitting_Diodes )

## Transistors

- Two layers, NP, is a diode.
- Three layers, NPN (or PNP) is a transistor.
- Apply no voltage to the middle layer and no current can flow edge to edge.
- Apply voltage to the middle layer and you squish both band gaps and get a
transistor across.
- This can be used just as a switch, or the complex effect of applying varying
voltages can do all kinds of crazy stuff.


## NAND Gates

https://mathcenter.oxford.emory.edu/site/cs170/nandFromTransistors/

## Then what?

- NAND gates are complete for arbitrary boolean circuits.
- If we have NAND gates, we can build anything.

Specifically:

- Not: A NAND A = NOT A
- And: NOT(A NAND B) = A AND B
- Or: (NOT A) NAND (NOT B) = A OR B

## Let's build the rest of the CPU

- ALU
- Crap, we need an instruction set. Let's look up RISC-V 32

https://msyksphinz-self.github.io/riscv-isadoc/html/rvi.html

- Add is 00000, 00, rs2:5, rs1:5, 000, rd:5, 01100, 11
- Sub is 00100, 00, rs2:5, rs1:5, 000, rd:5, 01100, 11
- Xor is 00000, 00, rs2:5, rs1:5, 100, rd:5, 01100, 11

Gonna need a register file.

That needs SRAM, which is an array of flip-flops. Each flip-flip is 6
transistors. The overall circuit is is a RAM: you set the address bits,
the R/W bit, and it either outputs or inputs a word.

Load / store need RAM.

RAM is slow so we want caches, more details later, but there's
several levels of them.

RAM is slow even with caches, and some operations are slow, so pipelines.

Pipelines stall, so speculative execution.

If we just do multiple things at a time, we're never wrong, so SMT.

If we just copy the core, we can have multiples, so multi-core.

More cores or fast cores? More cores or wide cores? Cores or cache? Cache or
memory channels?




