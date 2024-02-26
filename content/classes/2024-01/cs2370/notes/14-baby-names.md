---
title: "cs2370 Notes: 14 Baby Names"
date: "2024-02-25"
---


## More with Strings

Starting with [a file of baby names]( ../images/baby-names-2002.txt)
from the Social Security Administration, let's see what we can do.

How many names? Male, female, total?

Build a histogram per first letter.

Hints:

 - split
 - strip
 - replace


## Introducing Regular Expressions

```python
import re

text = "abc123"
re.match(r'a', text)
re.match(r'1', text)
re.match(r'[a-z]', text)
re.match(r'[a-z]+', text)
re.match(r'[a-z]*', text)
re.match(r'[0-9]+', text)
re.match(r'[0-9]*', text)
re.match(r'[a-z]+[0-9]+', text)
re.match(r'\D+\d+', text)


phone = '(603) 555-1212'
pat = r'\(\d{3}\)\s\d{3}-\d{4}'
# Does that look like a phone number?
re.match(pat, phone)
re.fullmatch(pat, phone)

tmpl = '''
Dear {name},

The warranty on your {year} {make} {model} is about to 
expire. This is your last chance to purchase extended
warantee coverage to avoid {disaster1} and {disaster2}.

Please call us at {phone} today!

{sender_name}
The Very Real Waranty Company.
'''

# Find the first template slot.
mm = re.search(r'{[a-z]+}', tmpl)

# That gives us a match object.
mm[0]   # Text of the match

# Group
mm = re.search(r'{([a-z]+)}', tmpl)
mm[0]   # Text of the match
mm[1]   # First group

re.findall(r'{[a-z]+}', tmpl)
re.findall(r'{\w+}', tmpl)
re.findall(r'{(\w+)}', tmpl)

for mm in re.finditer(r'{(\w+)}', tmpl:
    print(mm[0], mm[1])

text1 = re.sub(r'{\w+}', "BOOM", tmpl)
text1 = re.sub(r'{(\w+)}', r"[\1]", tmpl)

def cap(st):
    return st[1].capitalize()

text1 = re.sub(r'{(\w+)}', cap, tmpl)
```

