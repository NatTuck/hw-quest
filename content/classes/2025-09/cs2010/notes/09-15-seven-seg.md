---
title: "cs2010 Notes: 09-15 Seven Segment Display"
date: "2025-09-13"
---

Today we're going to build a circuit to control a seven segment display.

The display has seven segments, as follows:

```
 aaa
b   f
b   f
b   f
 ggg
c   e
c   e
c   e
 ddd
```

The segments each light up if a signal is applied, and we can use
that to make any digit 0-9. For example, to make a 5, we apply signal
to segments a, b, d, e, and g:

```
 aaa
b   
b   
b   
 ggg
    e
    e
    e
 ddd
```


Let's display a digital number on our display.

In order to distinguish all 10 possible decimal digits, we need 4 input bits.

To convert from 4 bits to 7 segments, we'll need seven truth tables.


|      | a |
|------|---|
| 0000 | 1 |
| 0001 | 0 |
| 0010 | 1 |
| 0011 | 1 |
| 0100 | 0 |
| 0101 | 1 |
| 0110 | 1 |
| 0111 | 1 |
| 1000 | 1 |
| 1001 | 1 |
| 1010 | x |
| 1011 | x |
| 1100 | x |
| 1101 | x |
| 1111 | x |

- x is don't care
- That leaves mostly 1's.
- So we can pull out product-of-sums form:
  (w+x+y+z')(w+x'+y+z)

So let's start building this mess.
