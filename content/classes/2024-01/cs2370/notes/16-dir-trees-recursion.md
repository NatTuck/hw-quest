---
title: "cs2370 Notes: 16 Directory Trees and Recursion"
date: "2024-02-29"
---


Continuing on from last class.

**File Handles**

The ```open``` bif gives us a file object. By default files are opened
in text mode to read a series of characters, but they also can be opened
in binary mode to read a series of bytes.

Methods (on text file):

 - close - When we're done; open files are a limited resource.
 - readline - Read one line
 - write - write a string to the file
 - read - read the whole file

Do some examples, including writing to file.



**Directory Traversals**

Let's write a script that prints the path to all the .md files in a directory.

The first thing we need is to be able to list the stuff in a directory.

```python
from pathlib import Path

wd = Path.cwd()

for item in wd.iterdir():
    print(item)
```
