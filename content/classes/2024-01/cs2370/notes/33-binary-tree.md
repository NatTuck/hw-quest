---
title: "cs2370 Notes: 33 Binary Tree"
date: "2024-04-22"
---

**Make Up Opportunities**

Next week's lab will be an opportunity to resubmit a previous lab.

Next week's homework will be the opportunity to resubmit a previous
homework. 

If you have a bunch of bad homework grades, you can resubmit some
extra homeworks - not to exceed 1 in 3 homeworks that have scores
below 50%.


**ConsList**

```python
class Leaf():
    # ConsList -> String
    def __str__(self):
        return "()"

    # ConsList -> boolean
    def isLeaf(self):
        return True

leaf = Empty()


class Branch:
    # constructor
    def __init__(self, left, data, right):
        self.left = left
        self.data = data
        self.right = right

    # ConsList -> String
    def __str__(self):
        return f"({self.left} {self.data} {self.right})"

    # ConsList -> boolean
    def isEmpty(self):
        return False


def add1_to_all(xs):
    if xs.isEmpty():
        return empty
    else:
        return Cons(2 * xs.first, add1_to_all(xs.rest))

# Map example


# Filter example


# Reduce example


# Map from reduce


    
# (ConsList of Number) -> Number
def sum(xs):
    if xs.isEmpty():
        return 0
    else:
        return xs.first + sum(xs.rest)


# ConsList -> Number
def length(xs):
    if xs.isEmpty():
        return 0
    else:
        return 1 + length(xs.rest)




if __name__ == '__main__':
    xs = Cons(1, Cons(2, Cons(3, empty)))
    ys = list(1, 2, 3)
    print(ys)
    print(sum(ys))
```
