---
title: "cs4140 Notes: 21 Hangman"
date: "2024-10-12"
---

Today: Phoenix / React Hangman Game

Steps:

 - Model Hangman by defining a data representation and a module
   with a set of simple functions (e.g. new, guess, legal_moves, etc)
 - Create a React component for the UI
 - Hook them together with a Phoenix Channel
   - Initially, state goes in the channel
 - Create a GenServer
   - Make it multiplayer
