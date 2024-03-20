---
title: "cs2370 Notes: 21 Flappy Bat"
date: "2024-03-19"
---

**Classes and Methods**

Inheritence

```python
from math import pi

class LawnShape:
    def area(self):
        raise Exception("not implemented")
    
    def cost(self, grassPrice):
        return self.area() * grassPrice

class Circle(LawnShape):
    def __init__(self, radius, cost):
        self.radius = radius
    
    def area(self):
        return pi * pow(self.radius, 2)
```


Example:

[flappy bat v2](../code/flappy-bat-v2.py)
