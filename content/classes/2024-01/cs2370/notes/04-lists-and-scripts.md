---
title: "cs2370 Notes: 04 Lists and Scripts"
date: "2024-01-25"
---

## Reminder: HW01

 - Due tonight
 - Submit on Inkfish, just like the lab


## Command Line

 - Modern desktop / laptop style computers provide two distinct
   ways to interact with them:
   - A Windows / Icons / Mouse / Pointer interface (or GUI)
   - A text-based interface (or CLI)
 - Graphical interfaces are more discoverable in simple cases
 - Text-based interfaces are more expressive and flexibile

Windows has at least two different text-based shells, but we'll focus
on the traditional one for now: CMD.EXE

 - To start the shell, run CMD.EXE
 - Prompt: Drive Letter, Path, ">"
 - Basic commands: cd, dir
 - Running a Python script: 
   - No args: ```python foo.py```
   - Command line args: ```python foo.py arg1 arg2 arg3```


## Command Line Arguments

```python
import sys

print(sys.argv)
```

When we run a program, we have the option of passing it zero or more
arguments. This is straightforward through a text interface, and
possible but less straightforward through a GUI.

This can be a good way to create one program that can do slightly
different things or operate on different stuff each time you run it.

```python
import sys

_, name = sys.argv
print(f"Hello, {name}")
```


## Lists

Wait, that argv thing is one name with multiple values in it.

It's a list, which is Python's default data type for storing a
collection of multiple items.

```
>>> xs = [1,2,3,4]
>>> len(xs)
>>> len("1234")
```


 - We can write list literals with square brackets.
 - The standard pattern for dealing with a list is a ```for``` loop.
 
```python
xs = [1,2,3,4]

for x in xs:
    print("item:", x)
```

Let's write a program that adds up a list of numbers.


```python
xs = [1,2,3,4]
sum = 0;

for x in xs:
    # sum = sum + x
    sum += x
    
print("sum =", sum)
```


## Command line args

Let's add up the command line args as integers:

```python

import sys

sum = 0

for arg in sys.argv:
    if arg.isdecimal():
        sum += int(arg)

print("sum =", sum)
```


```python

import sys

sum = 0

for arg in sys.argv[1:]:
    sum += int(arg)

print("sum =", sum)
```



## Text Files

nums.txt

```
1
2
3
4
```

read-file.py:

```python
ff = open("nums.txt")

for line in ff:
    print("line:", line.trim())
```

sum-file.py:

```python
ff = open("nums.txt")

sum = 0

for line in ff:
    sum += int(line)
    
print("sum =", sum)
```


## Practice Scripts

 - Print the even numbers from a text file
 - Print the longest command line argument
 - etc



