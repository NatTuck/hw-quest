---
title: "cs2010 Notes: 09-09 Base Conversions"
date: "2026-09-02"
---

**Review: Digit places**

Base 10: 1's, 10's, 100's, etc.

Base 2: 1's, 2's, 4's, 8's, 16's, etc.

Base 4: 1's, 4's, 16's, 64's, etc.

Base 16: 1's, 16's, 256's, etc.


**Common bases**

 - Base 10 is called decimal
 - Base 2 is called binary
 - Base 16 is called hexidecimal
 - Base 8 is called octal

**Converting from base 10 to base 10**

base 10 (3572), in base 10 is

`2*1 + 7*10 + 5*100 + 3*1000 = 3572`


**Converting from base 2 to base 10**

base 2 (100101), in base 10 is

`1*1 + 0*2 + 1*4 + 0*8 + 0*16 + 1*32 = 37`


**Converting from base 16, hexidecimal, to base 10**

Hex (4A37) to base 10:

`7*1 + 3*16 + (A=10)*256 + 4*(16^4) = 18999`


**Converting from base 10 to base 2**

base 10 (23) in base 2 is

(just do the arithmetic in the target base, this time base 2)

`3*1 + 2*10`

=

`11*1 + 10*1010`

=

`11 + 10100 = 10111`


**Converting from base 10 to base 2, plan b**

```
x = 23
while x > 0:
  if odd?(x):
    write down last digit = 1
  else:
    write down last digit = 0
  x = x / 2 (round down)
```

- 23 is odd => 1
- 11 is odd => 1
- 5 is odd => 1
- 2 is even => 0
- 1 is odd => 1
- 0 is zero, done

result: 10111


**Converting from base 10 to base 2, plan c**

We want to convert 23 to base 2.

Write down the powers of 2 up to 23, high to low:

16, 8, 4, 2, 1

Then for each one, high to low, we include it (1) if it's less
than or equal to our target number, otherwise (0), then we subtract it out if we included it.

- 16? 16 <= 23, so 1
  - 23 - 16 = 7
- 8?  7 > 7, so 0
- 4?  4 <= 7, so 1
  - 7 - 4 = 3
- 2? 2 <=  3, so 1
  - 3 - 2 = 1
- 1? 1 <= 1, so 1

result: 10111

This is based on the fact that there's only one way to build a binary number
that we discovered in lab.

16 is the highest power of 2 less than 23, 
so we need to to make the 16's place 1

We don't need the 8's place.

We do need the 4, 2, and 1's places.


**Converting from base 10 to base 16**

```
while x > 0
  divide by 16
    - take remainder (%) as last digit
    - take quotient (/) as new x
```


decimal input = 18999

| value | x % 16 | x // 16 |
|-------|--------|---------|
| 18999 |    7   | 1187    |
| 1187  |    3   | 74      |
| 74    | 10 = A | 4       |
|  4    |    4   | 0       |

digits from remainder column, reversed: 4A37

