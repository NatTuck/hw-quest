---
title: "cs2010 Notes: 05 Base Conversions"
date: "2024-09-08"
---

## Base conversions

**Last time**

 - Binary <=> Hex with a lookup table.

**Today**

 - Decimal <=> Binary
 - Hex <=> Decimal

Plan A:

 - You can pull out the least significant digit by doing an integer
   division, 4th-grade style, by the new base.
 - The remainder is the least significant digit.
 - The (integer) quotient contains the remaining digits, continue until
   done.

Example: Convert 19 to binary

   - 19 / 2 = 9, remainder 1
   - 9 / 2 = 4, remainder 1
   - 4 / 2 = 2, remainder 0
   - 2 / 2 = 1, remainder 0
   - 1 / 2 = 0, remainder 1
   - so 19 in binary is 10011 = 16 + 2 + 1

Plan B:

 - You can pull out the most significant digit by dividing by the largest
   power of the base less than the input.
 - The (integer) quotient is the most significant digit
 - The remainder contains the remaining digits.
 - Continue with the next lower power of base until done, zero quotients
   are zero digits.

Example: Convert 19 to binary

 - 32 is too big, so 16 is the largest power of 2 less than 19.
 - 19 / 16 = 1, remainder 3
 - 3 / 8 = 0, remainder 3
 - 3 / 4 = 0, remainder 3,
 - 3 / 2 = 1, remainder 1
 - 1 / 1 = 1
 - So 19 in binary is 10011
 - For binary, this might be easier to think of as "can we subtract out
   one of the power of 2", but division handles any base.

Plan C: Just do the implicit arithmetic in the target system.

 - Convert hex 3A to decimal
 - That's (3)(16) + (10)(1) = 58


Example: Convert 50 to hexidecimal

Plan A:

 - 50 / 16 = 3, remainder 2
 - 3 / 16 = 0, remainder 3
 - 50 decimal is 32 hex

Plan B:

 - 256 is too big, so start with 16
 - 50 / 16 = 3, remainder 2
 - 2 / 1 = 2, remainder 0
 - 50 decimal is 32 hex

Example: Convert binary 110011 to decimal

Plan A: 

 - 110011 / 1010
 - Let's use repeated subtraction
 - Ends up being 5, remainder 1
 - 5 < 10, so 10's place is 5.


Example: Convert hex 3FA9 to decimal

 - (3)(4096) + (15)(256) + (10)(16) + 9


# Binary Arithmetic

Addition


Subtraction


Multiplication


Negative Numbers

Plan A: Sign bit

Plan B: Two's complement

 - Flip all bits
 - Add one (ignore overflow)
 - This flips the sign of a signed integer
