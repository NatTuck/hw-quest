---
title: "cs2370 Notes: 19 Palindromes"
date: "2024-03-08"
---

```python
import gzip
import re

file = gzip.open("words.txt.gz", "rt")
words = list(map(lambda xx: xx.strip(), file))
file.close()

def reverse(xx):
    return ''.join(reversed(xx))

def normalize(xx):
    return re.sub(r'\s+', '', xx) 

def is_palindrome(st):
    return st == reverse(st)

def is_palindrome1(xx):
    for ii in range(0, len(xx)):
        if xx[ii] != xx[len(xx) - ii - 1]:
            return False
    return True

def is_palindrome2(xx):
    if len(xx) <= 1:
        return True

    if xx[0] != xx[-1]:
        return False

    return is_palindrome2(xx[1:-1])

    
#for w1 in words:
#    for w2 in words:
#        text = w1 + " " + w2
#        if is_palindrome(text):
#            print(text)


rwords = list(sorted(map(reverse, words)))


ii = 0
jj = 0

while ii < len(words) and jj < len(rwords):
    text = words[ii] + ' ' + reverse(rwords[jj])

    if is_palindrome(text):
        print(text)

    if words[ii] < rwords[jj]:
        ii += 1
    else:
        jj += 1
```
