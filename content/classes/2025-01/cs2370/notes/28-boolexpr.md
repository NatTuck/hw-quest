---
title: "cs2370 Notes: 28 Boolean Expressions"
date: "2025-04-03"
---

Boolean Expression Review:

- Three operations
- Symbols: ab+b!c, parens

```python
class Expr:
    pass


class Var(Expr):
    def __init__(self, name):
        self.name = name

    def eval(self, bindings):
        return bindings[self.name]


def test_Var():
    v1 = Var("a")
    v2 = Var("b")
    assert v1.eval({"a": True, "b": False}) == True
    assert v2.eval({"a": True, "b": False}) == False


class And(Expr):
    def __init__(self, exprs):
        self.exprs = exprs

    def eval(self, bindings):
        for ex in exprs:
            if not ex.eval():
                return False
        return True


class Or(Expr):
    def __init__(self, exprs):
        self.exprs = exprs

    def eval(self, bindings):
        for ex in exprs:
            if ex.eval():
                return True
        return False


class Not(Expr):
    def __init__(self, expr):
        self.expr = exprs

    def eval(self, bindings):
        return not self.expr.eval()

    def __repr__(self):
        return f"!()"
```
