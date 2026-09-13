---
title: "cs2010 Notes: 09-14 More Numbers"
date: "2026-09-02"
---


## Review: Binary

- 10101 to decimal
- 35 to binary


## Negative Numbers

Concept: Sign bit (initial 0 bit means positive)

Concept: Two's complement (flip all the bits, add 1)



## Fixed point numbers

Decimal $3.25

Binary point, 1/2, 1/4, etc.


## Floating point numbers

E2M1

4 bits:

- Sign bit
- Exponent (2 bits)
- Mantissa (1 bit)

Complications:

- Exponent bias
- Subnormals
- NaN / inf

Normals: `value = (-1)sign × 2(exponent - 1) × (1 + mantissa / 2)`

Subnormals: `value = (-1)sign × 20 × (mantissa / 2)` (just 0.5)

Values: 0, 0.5, 1.0, 1.5, 2.0, 3.0, 4.0, 6.0


IEEE 754 binary 32

- Sign
- 8 bit exponent
- 23 (+1) bit mantissa / significand

## Text

Encoding in lab: Caesar cipher is easy as addition:

- Convert letter to number, add 3, convert number to letter?
- A = 1, B = 2, ..., ?
- 5 bit = 32 chars, 6 bit = 64, 7 bit = 128
- ASCII = 7 bit, A = 65, a = 97, 1 = 49, . = 46 (python `ord`)
- We really use 8 bits, per character:
  - Top bit 0: rest is an ascii code
  - Top bit 1: multi-byte character, non-ascii
- Text is a series of bytes.
  - For English keyboard chars, each byte is one character.
  - So the text "Hi, Welcome to CS 2010" is 22 bytes.

## Structure of a Computer

- CPU
- RAM
- Disk
- I/O: Keyboard, screen, network

## Where do we store data?

- Running program: in RAM
- Longer than one program? On disk, in a file.
- A file is a series of bytes, with a name (short text)

## Demonstrate file <-> bytes and different UI modes

- Use gedit to create sample file
- Use nemo to show properties:
  - Name
  - Size in bytes

Two user interface modes:

- GUI, like gedit/nemo
  - gives a single clear view
  - common actions are visual and discoverable
  - Less common actions are hidden or entirely missing
- CLI, repeat with echo/ls/stat/vim
  - "we can do better than point and grunt: language"
  - communicate with text: commands and command output
  - Need to know the language(s), both concepts and grammar
  - `hd (FILE)`
  - `man ascii`
  - Absolutely need to read some docs.
- Option 3: Natural language
  - opencode - Gemma
  - "Create a text file named 'hello.txt' containing 'Hello, CS 2010'"
  - What are the ascii codes for the characters in the file?
  - Append a snowman emoji to the end of the file.
  - *Still* need to know the concepts, although but there's some
  improved discoverability through discussion.
