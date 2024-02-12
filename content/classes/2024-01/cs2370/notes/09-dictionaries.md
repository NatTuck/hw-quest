---
title: "cs2370 Notes: 09 Dictionaries"
date: "2024-02-11"
---

## Designing a function

 - Purpose statement
 - Signature (e.g. int -> int)
 - Examples
 - Stub
 - Standard pattern
 - Write the body
 - Asserts


## New data type: Dictionaries

```python
legs = {
    'dog': 4,
    'chicken': 2,
    'cat': 4,
    'spider': 8,
}

print(legs['dog'])

legs.keys())
legs.values()
'dog' in legs
'giraffe' in legs
legs.get('giraffe', 4)
legs.get('lobster', 4)
```

Note: Dictionary keys may print in insertion order, but generally it's
best to think of dictionaries as being unordered.


Not a new capacity:

```python
legs_list = [
  ('dog', 4),
  ('chicken', 2),
  ('cat', 4),
  ('spider', 8),
]

def get(xs, key):
    for (kk, vv) in xs:
        if kk == key:
            return vv
    raise Exception("key not found")

print(get(legs_list, 'dog'))
```

How many steps does it take to look up a key in the list?

Dictionaries give us two benefits over association lists:

 - Nicer syntax
 - Faster (can lookup in 1 step rather than having to loop)


## Repeats

Design a method that takes a list of numbers and returns a list of how
many times the number in that position appeared in the lsit.

Example: [7, 7, 1, 7, 2, 2, 7, 1, 3] -> [4, 4, 2, 4, 2, 2, 4, 2, 1]

 - version 1: nested loop
 - version 2: two loops and a dictionary

How many times through a loop in each case?


Next example:

 - Calculate a recipt total for a list of (item, count, price each) tuples.
