---
title: "cs2370 Notes: 05 Design, Functions on Tuples"
date: "2025-01-31"
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

First, check out: https://github.com/NatTuck/intro-py-sim

**Flying bat**

Stages:

 - Manually load sim.funs, demo image types.
 - Demo some functions on images, with img.show()
 - Build version with one number as state.
 - Build 2D version with click to teleport.
 - Show design recipe for each function (tests don't work yet for images).
 - Show version with namedtuple
 

```python
import sim
from sim.funs import *

# from collections import namedtuple
# Posn = namedtuple('Posn', ['x', 'y'])

def init():
    return (0, 0)
    #return Posn(0, 0)

bat = mirror(contain(load_image("bat.png"), (200, 200)))

def draw(state):
    (x, y) = state
    return place_at(empty_scene(), bat, x % 800, y % 600)


def tick(state):
    (x, y) = state
    return (x + 2, y + 4)


def mouse_click(state, x, y, btn):
    return (x, y)


if __name__ == '__main__':
    sim.run()
```
