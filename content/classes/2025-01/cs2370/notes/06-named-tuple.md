---
title: "cs2370 Notes: 06 Named Tuple"
date: "2025-02-03"
---

Five steps:

 - Stub with Names and Purpose statement
 - Types
 - Tests
 - Standard pattern
 - Function body

Standard pattern for tuples:

 - Input: Unpack it
 - Output: Build one.

Rectangle (width, height)

Posn (x, y)



A FuelBarrel is a tuple with three fields:

 - Radius (m)
 - Height (m)
 - Energy Density (mj/L)

Fuels:

 - Gasoline is 35 MJ/L
 - E10 33 MJ/L
 - E100 is 22 MJ/L
 - Diesel is 38 MJ/L

```python
from collections import namedtuple
FB = namedtuple('FuelBarrel', ['rad', 'height', 'eden'])
```

 - Calculate the energy content of a barrel.
 

A Car is: {type, mpg}

 - Given a car and a barrel:
 - How many miles would a barrel go if we converted the car?
