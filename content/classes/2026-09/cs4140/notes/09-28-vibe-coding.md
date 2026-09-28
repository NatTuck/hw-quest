---
title: "cs4140 Notes: 09-28 Vibe Coding"
date: "2026-09-26"
---

## Vibe Coding

- Let's go through the vibe coding workflow.


**Workflow**

- Start with an issue and a personal fork
- Check out personal fork to local machine
- Open OpenCode in checkout directory
- Give OpenCode the github issue in plan mode
- Discuss approach
- Switch to build mode.
- Execute
- Manually verify
- Commit
- PR

We'll work with issues on NatTuck/grange

## Feature 1: Minimal Farming Game

Let's transform Grange from just reskinned Botbash to be a minimal farming game.

Really minimal

- Remove games, create farms
- Two text lists: field and barn (inventory)
- Can plant seeds in field
- Can grow seeds -> tomato plants
- Can harvest tomatoes


## Feature 2: Port Backend to Elixir / Phoenix

- Yay!

## Feature 3: DB Persistence

- A user has many farms
- A farm has many items (in the barn).
- A farm has many planted_crops (type, state, etc)

