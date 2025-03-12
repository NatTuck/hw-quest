---
title: "cs2370 Notes: 21 Set Efficiency"
date: "2025-03-11"
---

Problem: Determine how many words appear in both of two books.

Sample books:
 
 - King James Bible
 - Paradise Lost

Problems:

 - Open file and split words


v2

```
def words_from(path):
    words = set()
    with open(path) as fh:
        for line in fh:
            words |= split_words(line)
    return words

def split_words(line):
    return set(line.split())

xs = words_from("kjb.txt")
ys = words_from("plost.txt")

zs = set()

for aa in xs:
    if (aa in ys) and (aa not in zs):
        zs.add(aa)

print(len(zs))
```

Problem: The words are silly.

Solution: Filter for real looking words.

https://docs.python.org/3/howto/regex.html
