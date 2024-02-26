---
title: "cs2370 Notes: 14 Baby Names"
date: "2024-02-25"
---


## More with Strings

Starting with [a file of baby names]( ../images/baby-names-2002.txt)
from the Social Security Administration, let's see what we can do.

How many names? Male, female, total?

Build a histogram per first letter.


## Introducing Regular Expressions

Write a function that extracts email addresses from text.

```python
import re

...

emailPat = re.compile(r'\w+@\w+\.\w+')
emailPat.findall("My email address is bob@example.com but yours is alice@example.com.")
```
