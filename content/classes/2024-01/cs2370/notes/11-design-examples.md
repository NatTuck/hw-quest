---
title: "cs2370 Notes: 11 Sets, Bulls, and Pigs"
date: "2024-02-18"
---


## Working on Linux

Today I'm using a refurbished laptop with a reasonably clean Linux
Mint install on it.

 - This laptop cost me $80 on eBay, including shipping.
 - It's a bit old, but still sufficient for most college courses with Linux.

Setup:

 - ```sudo apt install python3.11-full python-is-python3```


## New Type: Sets

This is one built-in type that's not covered in the textbook.

A set in Python is like a mathematical set. It's an unordered
collection of items with no duplicates.

The keys of a dictionary are a set.

Simple example:

```python
>>> aa = {1, 2, 3, 4}
>>> bb = {2, 4, 6, 8}
>>> cc = {4, 3, 2, 1}
>>> aa == cc
>>> aa == bb
>>> 3 in aa
>>> 3 in bb
>>> aa & bb
>>> aa | bb
>>> aa - bb
>>> bb - aa
```

Note: {} is an empty dictionary, so you need set() for an empty set.


Standard patterns:

```python
# {int} -> None
def foo(nums):
    ... 5 in nums ...
```

```python
# {int} -> None
def foo(nums):
    for num in nums:
        ... num ...
```


## Design with a Set

 - Design a function that takes a list and a set of ints and returns the
   number in the set that appears the most times in the list.
 - Given a set of ints, produce a set of ints that are twice the numbers
   in the input set.



## Design a Game

Bulls and Pigs:

 - The computer generates a random 4 digit secret.
 - The user repeatedly guesses a random four digit sequence.
 - After each guess, the computer scores the guess:
   - One bull for each digit in the guess that appears in the secret
     in the same position. 
   - One pig for each digit in the guess that appears in the secret
     in a different position.
 - When the user correctly guesses the secret, they win.
 - The goal is to win in the fewest guesses.
 
 
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
