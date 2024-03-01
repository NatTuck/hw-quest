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

Let's write a script that prints the path to all the .py files in a directory.

The first thing we need is to be able to list the stuff in a directory.

(Save this in scratch/cs2370/16/findpy.py. Run with python ../16/findpy.py)

```python
from pathlib import Path

wd = Path.cwd()

for item in wd.iterdir():
    print(item)
```

Running that just gets us the stuff in the current directory, mostly more
directories. We want to be able to look in those too. Let's add a function.


```python
from pathlib import Path

def search(path):
    for item in wd.iterdir():
        print(item)

wd = Path.cwd()
search(wd)
```

Now, if an item is a directory, we can search that too:

```python
def search(path):
    for item in path.iterdir():
        if item.is_dir():
            search(item)
        else:
            print(item)
```


Now we've got a function that calls itself, or a "recursive" function.
Functions like this come up a lot in programming and are extremely
useful and powerful, but they can be a bit tricky to reason about when
you're learning to program.

Key ideas about recursive functions:

 - A recursive function can't always call itself. That program would
   never finish.
 - The scenario when the function doesn't call itself again is the
   "base case". When you're thinking about a recursive function,
   you want to start thinking from the base case.
   - For search, this is when none of the items in the directory at
     ```path``` are a directory.
 - The scenario when the function does call itself is the "general
   case" or "recursive case".
   - For search, this when 
   
To figure out the general case of a recursive function:

 - First, identify the base case and make sure the function
   makes sense in that scenario.
 - Next, we'll look at the general case:
   - We checked the base case, so we assume that's good.
   - So let's look at a specific call to the function
     in the general case.

More steps:

 - Check if item is a .py file, and only print it then
 - Return a list instead of printing.
   - How to combine results?


More recursion examples:

 - Sum the numbers from 1..xx
 - Sum a list of lists of numbers


