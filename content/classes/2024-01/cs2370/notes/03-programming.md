---
title: "cs2370 Notes: 03 Programming"
date: "2024-01-25"
---

## General Advice

 - Attendence is strongly recommended.
 - Also, eating and sleeping.


## Python: Parts of speech

 - Literals:
   - int   (```type(5)```)
   - float
   - string (in quotes)
   - boolean
 - Variable names
   - (no quotes)
   - starts with a letter, numbers and "_" allowed after
 - Operators
   - 3 + 7
 - Function calls
   - round(7.3555, 2)
 - Expressions:
   - An expression has a value.
   - Literals
   - Operations
   - Some function calls
     - In other languages, "function" may be seperated from
       "procedure" or "subroutine".

## Arithmetic

**Numbers**

```
>>> 1 + 2
>>> 2 - 4
>>> 3 * 7
>>> 5 / 3

>>> 5 // 3
>>> 5 % 3         # modulus, not remainder
```

**Strings**

```
>>> "zz" + "XX"
>>> "hello " * 3
```


## Making choices

Conditionals:

 - if
 - if / else

```python
print("one")

if True:   # False:
    print("two")
#else:
#    print("three")

print("four")
```

Boolean Expressions:

```
>>> True and True
>>> True and False
>>> True or True
>>> True or False
>>> not True
```

 - Write out the truth tables for those.

Example:

```
aa = int(input("aa = "))
bb = int(input("aa = "))

if aa > 10 and bb > 10:
   print("Both")

if aa > 10 or bb > 10:
   print("Either)
   
if aa <= 10 && bb <= 10:
    print("Neither")
```

Example 2:

```
word = input("enter word: ")

if word < "n":
    print(word.capitalize())
else:
    print(word)
```


While loops:

 - while
 - let's write a script that left-pads strings to 40 chars in
   a loop
