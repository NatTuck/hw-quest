---
title: "cs2370 Notes: 13 Bulls, and Pigs"
date: "2024-02-23"
---

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
def score_guess(secret, gg):
    bulls = 0
    pigs = 0
    for ii in range(0, gg):
       pass 
    return (bulls, pigs)

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
            (bulls, pigs) = score_guess(secret, guess)
        else:
            print("Bad guess")

    print("You win!")


if __name__ == '__main__':
    main()
```


## More with Strings

Starting with a file of baby names from the Social Security
Administration, let's see what we can do.

How many names? Male, female, total?

Build a count-chart per first letter.

