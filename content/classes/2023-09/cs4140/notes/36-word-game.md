---
title: "Notes: 36 Word Game"
date: "2023-11-28"
---

## App Plan

Overview:

 - Word game, vaguely like Wheel of Fortune
 - Going to walk through the construction process here.
 - Going to have DS students build client logic for it
   for their final assignment and see who can build the
   most effictive automatic player.

Construction plan:

 - Build the single player app using React / Redux.
 - Move the internal state to the server through a Phoenix Channel.
 - Modify to be multiplayer.


## Game Rules: Single Player

 - The puzzle consists of a set of random words (typically six words).
 - The Player can see the words, with the letters individually hidden.
 - The player starts with zero points.
 - Each turn, the player guesses a consonant (including "y") that hasn't
   previously been guessed.
 - If that letter occurs in the puzzle:
   - All instances of that letter are revealed.
   - The player gets one point for each occurance revealed.
   - Player can either:
     - Guess the words in the puzzle. If they get it exactly right,
       they win - their score is added to multi-game total.
     - Guess one additional consonant
     - Spend one point to guess a vowel and reveal all occurances
 - If at any point all the letters are revealed, the player loses.


