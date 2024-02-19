---
title: "Design Recipe"
date: "2024-02-15"
---


## Recipe Steps

 1. Purpose statement
 2. Signature (e.g. int -> int)
 3. Examples
 4. Stub
 5. Standard pattern
 6. Write the body
 7. Tests


## Purpose Statement

This should be a one line comment stating the purpose of the function.

Examples:

```python
# Calculate the square root of a number.
def sqrt(xx):
    ...

# How many times does 1 appear in a list
def count_ones(xs):
    ...
```


## Signature

This should be a one line comment stating the type of each parameter
and the return type.

Examples:

```python

# number -> float
def sqrt(xx):
    ...
    
# [int] -> int
def count_ones(xs):
    ...
```

The ```sqrt``` function takes one argument which must be any number
(probably int or float) and returns an int.

The ```count_ones``` function takes one argument which must be a list
of int and returns an int.


## Examples

Try to come up with at least two examples of inputs and outputs
for your function. These will become tests later, so you can either
write them as comments now or write them directly as tests.

You can write them any way that's clear, although starting with '=='
makes it easier to translate into tests.

For example:

```python
def sqrt(xx):
    ...

# sqrt(9) -> 3.0
# sqrt(25) == 5.0


def count_ones(xs):
    ...

assert(1 == count_ones([2, 1])
assert(0 == count_ones([])
```


## Stub

The function stub is the "def" line, including the names of all the
parameters.

```python
def sqrt(xx):

def count_ones(xs):
```


## Standard Pattern

Based on the argument type or the return value, we can make a good
guess as to the general pattern the function is likely to follow.

These patterns combine in different ways, but we generally can guess
the most straightforward combination as a starting point.

A standard pattern may include "..." to indicate that it's not completed
code, or may not to allow the program to run while testing other code.

Not all fuctions look anything like a standard pattern, but if you're
not sure what to do the standard pattern is a good place to start.


### Patterns for Simple Values

Simple values include things like numbers, booleans, and strings if we
don't intend to manipulate individual characters.

**Standard pattern for a simple value argument**

```python
# int -> None
def process(xx):
    ... xx ...
```

If we have a simple value as an argument, we probably use it for something.


**Standard pattern for two simple value argument**

```python
# int -> None
def process2(xx, yy):
    ... xx ... yy ...
```

If we have simple values as arguments, we probably use them for something.


**Standard pattern for returning a simple value**

```python
# None -> int
def produce():
    return ... 5 ...
```

If we need to return a simple value, we probably return some value of that type.


**Combined pattern for a simple argument and a simple return type**

```python
# int -> int
def funkify(xx):
    return ... xx ...
```

If we have a simple value argument and we return a simple value, then the function
return value is probably a function of the input.


### Patterns for Lists

A string should use the standard pattern for a list if it's being treated
as a sequence of characters.


**Standard patterns for a list argument**

```python
# [int] -> None
def process(xs):
    for xx in xs:
       ... xx ... 
```

If we have a list of things, we want to loop through the list and do
something with each thing.

```python
# Change the elements of the list in place.
# [int] -> None
def mutate_list(xs):
    for ii in range(0, len(xs))
        xx = xs[ii]
        xs[ii] = ... xx ...
```

If you need to alter the elements an existing list, this pattern gives
you the list indices which are nesisary to do that.


**Standard pattern for returning a list**

```python
# None -> [int]
def produce():
    ys = []
    return ys
```

To return a list, we want to first build a list and then return it.


```python
# int -> [int]
def rabbit(xx):
    ys = []
    ys.append(xx)
    return ys
```

If we have an argument, we probably use that argument in producing the
list. If the argument is of the same type as the items in the list,
the simplest thing to do is to stick the argument on our return list.


**Standard pattern for list to list functions**

```python
# [int] -> [int]
def funkify(xs):
    ys = []
    for xx in xs:
        ys.append(... xx ...)
    return ys
```

A function that takes a list and return a list probably builds the new
list based on the elements of the old one.

### Patterns for tuples:

**Argument**

```python
# (str, str) -> None
def wumpus(name):
    (first, last) = name
```

If there's an input tuple, unpack it.


```python
# None -> (str, str)
def wumpus():
    return ('blue', 'jay')
```

If there's an output tuple, build it with appropriate values.




### Patterns for Dictionaries


**Standard patterns for a dictionary argument**

```python
# {str: str} -> None
def process(noises):
    ... noises['walrus'] ...
```

When we have a dictionary, the most obvious thing to do with it is to
look up one value by key.

```python
# {str: str} -> None
def process(noises):
    for key in noises.keys():
        ... noises[key] ...
```

Sometimes we want to process every element in a dictionary. The
standard pattern is to loop through the keys and then use them to look
up each associated value.


**Standard pattern for returning a dictionary**

```python
# None -> {str: str}
def produce():
    info = {}
    info['color'] = 'blue'
    return info
```

In a function that produces a dictionary, first we need to build the dictionary
then we can return it.


**Standard pattern for dictionary to dictionary functions**

```python
def giraffize(things):
    info = {}
    for key in things.keys():
        info[key] = things[key] 
    return info
```


### Mixing Patterns

**Take a list and produces a dictionary**

```python
# Takes a list
# [str] -> None
def process(xs):
    for xx in xs:
       ... xx ... 
```

```python
# Produces a dictionary
# None -> {str: str}
def produce():
    info = {}
    info['color'] = 'blue'
    return info
```

Combined

```python
# [str] -> {str: str}
def list_to_dict(xs):
    info = {}
    for xx in xs:
        info[xx] = xx
    return info
```


**Take two lists and produce a list**

A list-to-list function:

```python
# [int] -> [int]
def funkify(xs):
    ys = []
    for xx in xs:
        ys.append(... xx ...)
    return ys
```

Add a second list argument:

```python
# [int], [int] -> [int]
def funkify(xs):
    ys = []
    for xx in xs:
        ys.append(... xx ...)
    return ys
```


