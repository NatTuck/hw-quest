---
title: "cs2370 Notes: 19 Classes and Methods"
date: "2024-03-14"
---

**Classes and Methods**

Calculating the area of a circle:

```python
from math import pi

def circle_area(radius):
    return pi * pow(self.radius, 2)

class Circle:
    def area(self):
        return pi * pow(self.radius, 2)
```

Constructor

```python
from math import pi

class Circle:
    def __init__(self, radius):
        self.radius = radius
    
    def area(self):
        return pi * pow(self.radius, 2)
```

