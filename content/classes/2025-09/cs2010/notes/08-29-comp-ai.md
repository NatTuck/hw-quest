---
title: "cs2010 Notes: 08-25 Computers and AI"
date: "2025-08-23"
---

Computing Fundamentals is about computers, so let's talk a bit more about
computers and how they work.

Most computers now look like a cellphone or a laptop, but those mash everything
together, so let's start by thinking about a desktop PC.

Desktop Parts: Tower, Monitor, Keyboard, Mouse, Network Cable, Printer

Clearly the tower is the computer, and the rest of it is peripherals.

What do we find if we open the tower case?

Parts in case: Power Supply, Motherboard, CPU, RAM, GPU, Storage Disk

Plugs: 

- Monitor plugs into GPU
- Keyboard, Mouse, and Printer plug into USB ports on motherboard
- Network cable plugs into network port on motherboard

Diagram:

- The CPU is the part where programs actually run.
- The CPU is hooked up to everything else:
  - GPU
  - RAM
  - USB controller.
  - Disk
  - System firmware (in ROM on the motherboard).

Now let's turn on the computer.

- When the computer is powered on, the motherboard loads the system firmware
  into memory at a specific address, then starts the CPU.
- The CPU starts running code from that fixed address.
  - Load one instruction from memory.
  - Run it.
  - Load the next instruction.
  - Run it.
  - etc
- The system firmware is a program that:
  - Finds the disk we want to boot from.
  - Loads and runs a program at a fixed location on that disk.
- That program loaded from disk is the operating system kernel. For a modern,
large computer (i.e. one with at least several megabytes of RAM) the kernel is
the only code that can directly access all of the hardware. It'll start other
programs later, but those programs will ask the kernel if they want to access
hardware.
- The kernel will run a shell, which is the program that draws the user
interface and allows the user to do stuff.
- Only one program really runs at once per CPU core. The CPU and kernel work
together to quickly switch between programs so the user can logically run a
bunch of programs simultaneously.

What happens when we run a program (e.g. click on the icon for a web browser):

- A program is a series of instructions that the CPU understands, stored in a
file on disk.
- When a new program runs, first it gets copied from disk into RAM.
- When the kernel schedules that program onto a CPU core, the CPU starts
executing those instructions (again, load, execute, load next, execute, etc).
- We can think of instructions as being numbers, but to get into more detail
we'll have to talk about how computers store data.

How computers store data:

- Computers are electronic.
- They run on low voltage. 
  - A modern CPU runs with an input of about 1 volt.
  - When you take Computer Hardware, typical voltages for electronic components
    in lab will be 5V or 3.3V. 
- Voltage is a real (analog) quantity, so you could use it to represent real
  numbers. You could say 3.3V is 100, 1.65V is 50, 1V is 30.3030..., etc.
- But building circuits to detect small differences is complicated. The simplest
  thing to do is just figure out whether a wire is powered or not, 3.3V or 0V.
- That's a binary signal, and it means that with a single wire we can represent
  two numbers: 1 (powered) or 0 (not powered).
- That also makes storage easy. A hard disk can store a 0 or 1 value as by
determining whether a tiny spot of rust on a plastic disk is magnetized or not.
A DRAM can store it by charging or discharging a capacitor. A paper tape can
store it by whether a given spot has a hole punched in or not.
- A single 0 or 1 value is called a bit.
- To represent bigger numbers, we need more bits (wires, spots on our paper
tape, etc). Two bits lets us represent 4 values (0-3). Three bits gives 8 values 
(0-7). If we have N bits, we can represent a number between 0 and 2^n-1.
- 8 bits is called a byte, which is our common unit for data storage. That's a
number between 0 and 255.

And that's how computers represent data. Turn everything into numbers, then use
however many bits you need to represent those numbers.

- Text is characters encoded as numbers. The letter 'a' is 97, 'b' is 98, etc.
- Images are broken into pixels, or little colored dots. The color of each pixel
is three numbers: red, green, and blue intensity, each 8 bits.
- Sound is stored as loudness, sampled typically 44,100 times per second with
16 bits per sample (that's how CDs did it, which became the common format).

## AI Tools

LLMs have gotten pretty useful, and I want you to use them to help learn stuff
this semester.

We'll spend more time with coding-specific LLM tools later, but the most basic
way to access them is through web chatbots. There are a bunch available, let's
take a look at https://homework.quest/ai

I recommend Google Gemini as a good default option for technical discussions,
but you should play with all of them. ChatGPT isn't bad, but it's definitely
overrated given the other options.

Let's give it a try:

- How many bits are in four bytes?
- How many distinct values can be represented using 10 bits?
- How does an SSD store individual bits of data?

Some thoughts:

- Answers tend to be long and have a lot of info. You can get answers at
different levels of technical detail. Practice reading answers quickly, and
ask follow up questions when you don't understand stuff.
- Typing and reading quickly and accurately were already valuable skills. LLMs
make those skills a key bottleneck to productivity.

And the key thought:

- These tools make it very tempting to learn the tools instead of the info.
That's not new - probably when book first became common people complained about "kids
these days not memorizing anything because they can just look it up". But the
question of what to look up and what to actually personally learn and remember
hasn't changed.
- You still need to learn the core class material yourself. Use the chatbots as
tutors, not as a way to avoid learning.
