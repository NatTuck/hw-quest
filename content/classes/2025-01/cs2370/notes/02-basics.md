---
title: "cs2370 Notes: 02 Programming"
date: "2025-01-24"
---

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

