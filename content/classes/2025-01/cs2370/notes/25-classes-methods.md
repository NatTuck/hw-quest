---
title: "cs2370 Notes: 24 Classes and Methods"
date: "2025-03-27"
---

**Classes**

```python
from math import pi

class Circle:
    radius = 5
    color = "blue"
   
    def __init__(self, rad):
        self.radius = rad
    
    def area(self):
        return self.radius * pow(pi, 2)


def Square:
    def __init__(self, width):
        self.width = width

    def area(self):
        return self.width * self.width
```

 * Draw the scoping diagram to resolve instance vs. class fields.
 * Duck typing.
 * Inheritence, default methods and class fields.
 
**Operator overloading**

ref: https://web.mit.edu/fluids-modules/www/exper_techniques/2.Propagation_of_Uncertaint.pdf

```python

from numbers import Number
from functools import total_ordering

@total_ordering
class NumErr:
    """Represents a number with uncertainty (val +- err)"""
    def __init__(self, val, err=0):
        if isinstance(val, NumErr):
            self.val = val.val
            self.err = val.err + err
        else:
            self.val = val
            self.err = err

    def __add__(self, yy):
        if isinstance(yy, Number):
            yy = NumErr(yy, 0)
        return NumErr(self.val + yy.val, self.err + yy.err)

    def __sub__(self, yy):
        if isinstance(yy, Number):
            yy = NumErr(yy, 0)
        return NumErr(self.val - yy.val, self.err + yy.err)

    def frac_err(self):
        return self.err / abs(self.val)

    def __mul__(self, yy):
        if isinstance(yy, Number):
            yy = NumErr(yy, 0)
        val = self.val * yy.val
        err = abs(val * (self.frac_err() + yy.frac_err()))
        return NumErr(val, err)

    def __div__(self, yy):
        if isinstance(yy, Number):
            yy = NumErr(yy, 0)
        val = self.val * yy.val
        err = abs(val * (self.frac_err() + yy.frac_err()))
        return NumErr(val, err)

    def __eq__(self, yy):
        err = self.err + yy.err
        return self.val + err >= yy.val and self.val - err <= yy.val 

    def __lt__(self, yy):
        return self.val < yy.val

    #def __gt__(self, yy):
    #    return self.val > yy.val

    def __repr__(self):
        return f"NumErr({self.val}, {self.err})"
    
    def __str__(self):
        return f"{self.val}±{self.err}"
```


