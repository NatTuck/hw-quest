---
title: "cs2370 Notes: 24 Dictionary Examples"
date: "2025-03-24"
---

With an alist

```python
def get(xs, key):
    for (k, v) in xs:
        if k == key:
            return v
    return 0

def put(xs, key, val):
    ys = []
    seen = False
    for (k, v) in xs:
        if k == key:
            v = val
            seen = True
        ys.append((k, v))
    if not seen:
        ys.append((key, val))
    return ys
            
counts = []

with open("/usr/share/dict/words") as fh:
    for word in fh:
        word = word.strip()
        for letter in word:
            x = get(counts, letter)
            counts = put(counts, letter, x + 1)

print(counts)
```

```bash
$ time script.py
```

With a dictionary:

```python
counts = {}

with open("/usr/share/dict/words") as fh:
    for word in fh:
        word = word.strip()
        for letter in word:
            x = counts.get(letter, 0)
            counts[letter] = x + 1

print(counts)
```



TODO: Fix this, maybe with a table example, maybe just with the review stuff.
