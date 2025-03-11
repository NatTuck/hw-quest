---
title: "cs2370 Notes: 17 Introducing Sets"
date: "2025-03-09"
---

First, let's try improving our prime number thing by
keeping a list of primes.

Then, today's actual thing:

--

So far we have one way to store a collection of items of unknown size:
lists.

Lists have a bunch of properties, but two noteworthy ones are:

 - Lists allow duplicates.
 - Lists have a specific order.

Sometimes we don't want either of those things.

Consider taking classroom attendence:

 - You're either here or not, having you be here twice on the same
   day makes no sense.
 - Attendence doesn't really have a concept of order: You're either
   here or not.

Imagine we're traking attendence with lists:

```python
day1 = ["Alice", "Bob", "Carol", "Dave"]
day2 = ["Bob", "Alice", "Carol", "Dave"]
```

Was the attendence the same on the two days?

They aren't equal. We'd have to normalize the order (e.g. sort them)
in order to get the comparison we want.

Mathematically, the thing we want is called a Set.

In python, it's called a set.


```python
day1 = {"Alice", "Bob", "Carol", "Dave"}
day2 = {"Bob", "Alice", "Carol", "Dave"}
day3 = {"Bob"}

print(day1 == day2)
print(day1 == day3)
```

How to deal with sets:

 - Construct empty with set() (not {}, show type({})).
 - Add items: aa.add(...)
 - Membership: x in set
 - union (&), intersection (|) methods
 - len() works on sets

https://docs.python.org/3/tutorial/datastructures.html#sets

Sets are a new type, so they get some new standard patterns.

 
```python
def foo(nums: set[int]) -> None:
    ... 5 in nums ...

def bar(nums: set[int]):
    for num in nums:
        ... num ...

def baz() -> set[int]:
    zz = set()
    zz.add(3)
    return zz
```

 - Function to find largest number in set: for loop
 - Function to determine which items in a list are
   contained in a set.


```python
import random


# Create a new 4 digit secret.
# None -> str
def new_secret():
    yy = ""
    for _ in range(0, 4):
        yy += str(random.randint(0,10))
    return yy


# Check if guess is valid.
# str -> bool
def valid_guess(gg):
    return len(gg) == 4 and gg.isdigit():


# str -> (int, int)
def score_guess(gg):
    return (0, 0)

# None -> None
def main():
    secret = new_secret()
    guess = ""

    while not guess == secret:
        print("")
        print("Guess a 4 digit number")
        guess = input("> ")
        if valid_guess(gg):
            print("Your guess:", guess)
            () = score_guess(guess)
        else:
            print("Bad guess")

    print("You win!")


if __name__ == '__main__':
    main()
```
