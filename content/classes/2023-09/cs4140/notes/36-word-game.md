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


## Game Rules

 - Hangman
 - Guess one letter per turn
 - Points for revealing letters - except vowels.
 - Multiplayer: Most points wins, multiple rounds
   - Multiple rounds lets differnet players go first.


## Base strategy to walk through changes:

Diff is here:

https://github.com/NatTuck/word-game/compare/main...01-single-player

