
# Practice Exam for CS2370 Spring 2024

Type your answers below the questions and submit the resulting file on
Inkfish.

## Part 1. Write down a literal value of each of the following types:

**String**

**Integer**

**Float**

**List of Floats**

**Set of Integers**

**A Tuple of an Integer and a String**


## Part 2. Design Recipe

Consider the following code and answer the questions below.

```python
def string_lengths(xs):
    ys = []
    for x in xs:
        ys.append(len(x)
    return ys

assert([3, 5] == string_lengths(["one", "seven"]))

# [Int] -> Int
# Sum all the even numbers in the list.
def sum_evens(xs):
    pass

assert(6 == sum_evens[1,2,3,4])
```

**What is the signature of ```string_lengths```?**


**What is an appropriate purpose statement for ```string_lengths```?**


**What is the standard pattern for ```sum_evens```?**


**What is the complete code for ```sum_evens```?**



# Part 3: Classes and Scopes

Consider the following code and answer the questions below.

```python
color = "blue"
rank = 2

class Bar:
    color = "red"
    rank = 6 

    def triple(self):
        return 3 * rank

def foo():
    color = "green"

    class Baz(Bar):
        def double(self):
            return 2 * self.rank

        def grape(self):
            global color

            return "My favorite color is " + color


    return Baz()

aa = foo()
bb = Bar()

print(aa.double())   # print #1
print(aa.triple())   # print #2
print(aa.grape())    # print #3
print(bb.triple())   # print #4
```

**What's the output from print #1?**


**What's the output from print #2?**


**What's the output from print #3?**


**What's the output from print #4?**



## Part 4. Regular Expressions

Hints:

 - ```\d``` is ```[0-9]```
 - ```\w``` is ```[a-zA-Z0-9_]```
 - ```\s``` is any whitespace character
 - ```.``` is any character
 - ```+``` means one or more
 - mm[0] is the whole match
 - mm[1] is the first group (set of parens)
 
Consider the following code and answer the questions below


```python
import re

alice = "Alice Anderson"
bob = "Robert C. Boulette"


pat = r'^(\w+)\s+(\w\.)\s+(\w+)'

mm = re.search(pat, alice)
if mm:
    print(mm[1]) # Print #1

mm = re.search(pat, bob)
if mm:
    print(mm[1]) # Print #2
```

**Does the pattern match ```alice```?**


**If so, what gets printed by print #1?**


**Does the pattern match ```bob```?**


**If so, what gets printed by print #2?**










