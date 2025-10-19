---
title: "cs4140 Notes: 10-20 Hangman Continued"
date: "2025-10-18"
---

## Hangman, pt4

We:

- Got our state into a shared gen-server, with a registry to
  find the right one.
- Hooked React <-> Channel <-> GenServer
- Added named games

More work to do:

- Let the user punch in a username.
- Figure out how multiplayer works.
- Implement that.
- Implement high scores in the DB.
- Deploy to gargoyle
