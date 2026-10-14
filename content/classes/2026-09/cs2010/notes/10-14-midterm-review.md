---
title: "cs2010 Notes: 10-14 Midterm Review"
date: "2026-10-12"
---

30 practice questions for the midterm, covering:

- **Number conversions** (Part A)
- **Structure of a computer, files & paths** (Part B)
- **Text files & Git** (Part C)
- **Large language models** (Part D)
- **Boolean logic** (Part E)

Show your work on the conversion questions, exactly like the homework.

---

## Part A — Number Conversions

**Q1.** Convert the decimal number **37** to binary using **repeated division**.

**Q2.** Convert the decimal number **53** to binary by **repeatedly subtracting
the largest power of two**.

**Q3.** Convert the binary number **11010** to decimal.

**Q4.** Convert the decimal number **200** to hexadecimal.

**Q5.** Convert the hexadecimal number **7B** to decimal.

**Q6.** Convert the decimal number **90** to octal.

**Q7.** Convert the octal number **52** to decimal.

**Q8.** Convert the binary number **11101001** to hexadecimal.

**Q9.** Convert the hexadecimal number **F4** to binary.

**Q10.** Convert the decimal number **13.75** to binary (do the whole part and
the fractional part separately).

**Q11.** Convert the binary number **1010.101** to decimal.

**Q12.** Convert the decimal number **-9** into **8-bit two's complement**
binary.

**Q13.** The 8-bit two's complement number **11110110** represents which decimal
number?

**Q14.** Decode the single-precision IEEE 754 value
`0 10000010 01000000000000000000000` to decimal.

---

## Part B — Structure of a Computer, Files & Paths

**Q15.** List **four main parts of a computer** and give a one-line
description of each. (This is a terrible question, but I might ask what RAM is.)

**Q16.** (a) While a program is running, where is its data kept? (b) If you want
that data to still be there after the program exits, where does it go?

**Q17.** Fundamentally, what is a **file** made of? Besides its contents, what
kind of extra information (metadata) does a file have?

**Q18.** (a) What character does an absolute path start with on Linux and macOS?
(b) What does it start with on Windows? (c) What character separates the parts
of a path on Linux?

**Q19.** Your terminal's working directory is `/home/alice/docs`.
(a) What is the absolute path of the file `../notes/todo.txt`?
(b) What does `..` mean, and what does `.` mean?

**Q20.** Compare a **GUI** and a **CLI**: give one advantage of each.

---

## Part C — Text Files & Git

**Q21.** In one sentence, what is a text file? Then: how many **bytes** long is
the text `Hello, CS 2010` when stored as ASCII?

**Q22.** (a) How many bits is ASCII? (b) If we really use 8 bits per character,
how does the computer tell an ASCII character from a non-ASCII one?

**Q23.** What is **UTF-8**, and why was it invented? Roughly how many bytes does
each of these take: an ASCII character, a character from most other alphabets, a
CJK/Hangul character, and an emoji?

**Q24.** Define each of these Git terms: **repository**, **commit**, **push**,
**clone**.

**Q25.** Give **two reasons** to use version control. Then describe the basic
collaborative GitHub workflow (branch → change → commit → push → pull request).

---

## Part D — Large Language Models

**Q26.** In one sentence, what does a large language model do? What is a
**token**?

**Q27.** Why can't you run the very largest LLMs on a normal laptop? In your
answer, mention **weights** and **quantization**.

---

## Part E — Boolean Logic

**Q28.** Fill in the truth tables for **AND**, **OR**, and **NOT**.

**Q29.** Evaluate `(A AND B) OR (NOT A)` for `A = 1`, `B = 0`. Show your steps.

**Q30.** A lamp is controlled by two switches and should be **ON if exactly one
switch is on** (and OFF otherwise). Write a truth table and a boolean expression
for this.

---

# Answer Key

## Part A

**Q1.** 37 → binary
- 37 / 2 = 18 r **1**
- 18 / 2 = 9 r **0**
- 9 / 2 = 4 r **1**
- 4 / 2 = 2 r **0**
- 2 / 2 = 1 r **0**
- 1 / 2 = 0 r **1**

Remainders in reverse: **100101** (check: 32 + 4 + 1 = 37 ✓)

**Q2.** 53 → binary (subtract largest power of two)
- 32 ≤ 53 → **1**, 53 − 32 = 21
- 16 ≤ 21 → **1**, 21 − 16 = 5
- 8 > 5 → **0**
- 4 ≤ 5 → **1**, 5 − 4 = 1
- 2 > 1 → **0**
- 1 ≤ 1 → **1**, 1 − 1 = 0

Answer: **110101** (check: 32 + 16 + 4 + 1 = 53 ✓)

**Q3.** 11010 = 16 + 8 + 0 + 2 + 0 = **26**

**Q4.** 200 → hex
- 200 / 16 = 12 r **8**
- 12 / 16 = 0 r **12 = C**

Remainders in reverse: **C8** (check: 12 × 16 + 8 = 200 ✓)

**Q5.** 7B = 7 × 16 + 11 = **123**

**Q6.** 90 → octal
- 90 / 8 = 11 r **2**
- 11 / 8 = 1 r **3**
- 1 / 8 = 0 r **1**

Remainders in reverse: **132** (check: 1 × 64 + 3 × 8 + 2 = 90 ✓)

**Q7.** 52 (octal) = 5 × 8 + 2 = **42**

**Q8.** 11101001 → group into nibbles: `1110 1001` = **E9**

**Q9.** F4 → each hex digit is 4 bits: F = 1111, 4 = 0100 → **11110100**

**Q10.** 13.75 → binary
- Whole part, 13: 13 / 2 = 6 r1; 6 / 2 = 3 r0; 3 / 2 = 1 r1; 1 / 2 = 0 r1 →
  reverse → **1101**
- Fractional part, 0.75: 0.75 × 2 = 1.5 → digit **1**; 0.5 × 2 = 1.0 → digit **1**
  → in order → **.11**

Answer: **1101.11** (check: 8 + 4 + 1 = 13, and 0.5 + 0.25 = 0.75 ✓)

**Q11.** 1010.101
- Whole: 8 + 2 = 10
- Fraction: 1/2 + 1/8 = 0.5 + 0.125 = 0.625

Answer: **10.625**

**Q12.** −9 in 8 bits: +9 = `00001001`; flip → `11110110`; add 1 → **11110111**

**Q13.** `11110110` is negative. Flip → `00001001`; add 1 → `00001010` = 10, so
the value is **−10**

**Q14.** `0 10000010 01000000000000000000000`
- Sign = 0 (positive)
- Exponent = 10000010₂ = 130; real exponent = 130 − 127 = **3**
- Fraction = 0100… = 1/4, so mantissa = 1.25
- Value = 1.25 × 2³ = 1.25 × 8 = **10.0**

## Part B

**Q15.** The four main parts:
- **CPU** — runs the program / does the computation.
- **RAM** — fast, temporary working memory while the computer is on.
- **Disk** — slow, persistent storage that survives power-off.
- **I/O** — input/output devices: keyboard, screen, network, etc.

**Q16.** (a) In **RAM** (main memory). (b) On **disk**, in a **file**.

**Q17.** A file is a **series of bytes** (its contents) plus a **name** and some
**metadata** (size, dates, maybe a type).

**Q18.** (a) A forward slash `/`. (b) A **drive letter** such as `C:`. (c) `/`.

**Q19.** (a) `/home/alice/notes/todo.txt`.
(b) `..` means the **parent directory** (the directory one level up). `.` means
the **current directory**.

**Q20.** **GUI** — common actions are visual and discoverable; good for casual
use. **CLI** — a language of commands, so it is more powerful and scriptable, but
you have to know the commands.

## Part C

**Q21.** A text file is a file whose bytes are meant to be read as **characters
of text** (rather than, say, image or audio data). `Hello, CS 2010` is **14
bytes** (one byte per ASCII character).

**Q22.** (a) ASCII is **7 bits** (128 possible characters). (b) We store each
character in a byte: if the **top bit is 0**, the remaining 7 bits are an ASCII
code; if the **top bit is 1**, the byte is part of a **multi-byte (non-ASCII)**
character.

**Q23.** **UTF-8** is a **variable-length** encoding of Unicode (invented by Ken
Thompson) that keeps ASCII text unchanged. It was invented so that old
8-bit/ASCII tools would still work while the full Unicode set was supported.
Sizes: ASCII = **1 byte**; most other alphabets = **2 bytes**; CJK/Hangul = **3
bytes**; rare/historical characters and emoji = **4 bytes**.

**Q24.**
- **Repository** — a project whose files and full change history Git is
  tracking.
- **Commit** — a saved snapshot of your changes, with a message, stored
  **locally**.
- **Push** — send your local commits up to a **remote** (e.g. GitHub).
- **Clone** — make a local copy of a remote repository on a new machine.

**Q25.** Two reasons: (1) **tracking changes over time** (history, ability to
see/undo what changed), and (2) **multi-user collaboration**. Workflow: make a
**branch**, make a **change**, **commit** it, **push** the branch, then open a
**pull request** so it can be reviewed and merged.

## Part D

**Q26.** An LLM predicts the **next token** given the previous tokens, then
appends that token and repeats. A **token** is a chunk of text (roughly a word or
symbol) represented by a number.

**Q27.** To generate each token, the model must do math using **all of its
weights**, so the weights have to fit in fast memory (VRAM/RAM). The biggest
models have **trillions of weights**, which would need far more memory than a
laptop has. **Quantization** stores each weight with fewer bits (16 → 8 → 4) to
shrink the model so it fits, at some cost in quality.

## Part E

**Q28.**

| A | B | A AND B | A OR B |
|---|---|---------|--------|
| 0 | 0 |    0    |   0    |
| 0 | 1 |    0    |   1    |
| 1 | 0 |    0    |   1    |
| 1 | 1 |    1    |   1    |

| A | NOT A |
|---|-------|
| 0 |   1   |
| 1 |   0   |

**Q29.** `(A AND B) OR (NOT A)` with A = 1, B = 0:
- A AND B = 1 AND 0 = **0**
- NOT A = **0**
- 0 OR 0 = **0**

**Q30.** Truth table (1 = on):

| A | B | Lamp |
|---|---|------|
| 0 | 0 |  0   |
| 0 | 1 |  1   |
| 1 | 0 |  1   |
| 1 | 1 |  0   |

Expression: **(A AND NOT B) OR (NOT A AND B)** — this is **XOR**.
