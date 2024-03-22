---
title: "cs2370 Notes: 22 Going too Far with Objects"
date: "2024-03-19"
---

**Interfaces vs Inheritence**

Animals:


```python
class Bat:
    image = "bat.png"
    
    def __init__(self):
        self.sprite = ... construct sprite
    
    def moveTo(self, x, y):
        self.sprite.update(...)

    def draw(self):
        self.sprite.draw()
    
    def hit(self, x, y):
        # circle as bounding box
    
    def tick(self, x, y):
        pass
```




