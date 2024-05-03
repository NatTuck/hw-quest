---
title: "cs2370 Notes: 38 Semester Review"
date: "2024-05-02"
---

"Intro to Programming"

 - Programming is writing computer programs
 - A computer program is typically text written in a programming
   language.
 - This semester we've written code in Python.

# Example 1:

```python
print("Input x")
text = input("> ")
x = int(text)
print("x + 4 =", x + 4)
```

 - Write the code in IDLE
 - We need to save it before we can run it.
 - That means we care about local files and directories.
 - This is a plain text file.
   - We can open it in Windows Notepad
   - A program like Microsoft Word won't work.
 - We can run it by:
   - Clicking "run" in the run menu.
   - Pressing F5.
   - Opening up a command line window and running it with the python command.
 - A Python program is a series of statements (think "commands")
 - The Python interpreter (a program called "python") executes the
   program in such a way that it looks like the statements run in
   order.
   
# Flow control

```python
print("Input x")
x = 10
while x > 0:
    text = input("> ")
    x = int(text)
    if x % 2 == 0:
        print("x + 4 =", x + 4)
```

# Data types:

 - Numbers: int, float
 - Strings
 - Collections: list, tuple, dict, set

# Functions

```python
def add2(xx):
    return xx + 2
```

We spent most of the semester designing functions, but writing code
has the same basic problem as writing prose: It's hard to know where
to start.

So this semester we used a design recipe:

 - Purpose statement
 - Signature (e.g. int -> int)
 - Tests
 - Stub
 - Standard pattern
 - Write the body

# Design with lists

Insertion sort:

```python
# [number] -> [number]
def sort(xs):
    ys = []
    
    for x in xs:
        ys = insert(ys, x)

    return ys

# We need a helper

# [number], number -> [number]
def insert(xs, y):
    lt = []
    gt = []
   
    for x in xs:
        if x <= y:
            lt.append(x)
        elif x > y:
            gt.append(x)
    
    return lt + [y] + gt
```


# Design with Dictionaries

Design a method that takes a list of numbers and returns a list of how
many times the number in that position appeared in the lsit.

Example: [7, 7, 1, 7, 2, 2, 7, 1, 3] -> [4, 4, 2, 4, 2, 2, 4, 2, 1]

    version 1: nested loop
    version 2: two loops and a dictionary

How many times through a loop in each case?


# Directory Trees and Recursion

```python
from pathlib import Path

def search(path):
    for item in path.iterdir():
        if item.is_dir():
            search(item)
        else:
            print(item)

wd = Path.cwd()
search(wd)
```


# Web Scraping

 - Vault example
 - Show latest versions


# ConsList / Binary Trees

 - Recursive data
 

# AI, Word Game

 - Generating pictures was fun.
 - The Intermediate Programing are done, so now it's time
   to beat them. The highest real name on the leaderboard 
   is Job Bonestoppel...



