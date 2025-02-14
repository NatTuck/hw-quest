---
title: "cs2370 Notes: 08 Eat Bugs"
date: "2025-02-13"
---

```python

import sim
from sim.funs import *

import math
from random import randint
from collections import namedtuple


Posn = namedtuple('Posn', ['x', 'y'])
World = namedtuple('World', ['bat', 'bugs'])


BAT = mirror(contain(load_image("bat.png"), (200, 200)))
MOS = mirror(contain(load_image("mosquito.png"), (75, 75)))


def init():
    return World(Posn(300, 400), [])


def draw(state):
    (bat, bugs) = state
    scene = empty_scene()
    for bug in bugs:
        scene = place_at(scene, MOS, bug.x, bug.y)
    return place_at(scene, BAT, bat.x, bat.y)


def clamp(xx, x0, x1):
    if xx < x0:
        return x0
    if xx > x1:
        return x1
    return xx


def dist(p0, p1):
    dx = p1.x - p0.x
    dy = p1.y - p0.y
    return math.sqrt(dx*dx + dy*dy)


def nearest_bug(bugs, bat):
    yy = bugs[0]
    for bug in bugs[1:]:
        if dist(bat, bug) < dist(bat, yy):
            yy = bug
    return yy


def move_bat(bugs, bat):
    if len(bugs) == 0:
        return bat
    bug0 = nearest_bug(bugs, bat)
    dd = math.atan2(bug0.y - bat.y, bug0.x - bat.x)
    return Posn(bat.x + math.cos(dd), bat.y + math.sin(dd))


def eat_bugs(bugs, bat):
    ys = []
    for bug in bugs:
        if dist(bat, bug) > 5.0:
            ys.append(bug);
    return ys


def move_bugs(bugs):
    ys = []
    for bug in bugs:
        bx = clamp(bug.x + randint(-2, 2), 0, 800)
        by = clamp(bug.y + randint(-2, 2), 0, 600)
        ys.append(Posn(bx, by))
    return ys

def tick(state):
    (bat, bugs) = state
    bat = move_bat(bugs, bat)
    bugs = eat_bugs(bugs, bat)
    bugs = move_bugs(bugs)
    return World(bat, bugs)


def mouse_click(state, x, y, btn):
    (bat, bugs) = state
    bugs.append(Posn(x, y))
    return  World(bat, bugs)


if __name__ == '__main__':
    sim.run()
```
