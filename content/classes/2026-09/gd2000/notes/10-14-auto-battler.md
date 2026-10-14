---
title: "gd2000 Notes: 10-14 Auto Battler"
date: "2026-10-14"
---

First, attendance code on Inkfish.

## Auto Battler

Today we're going to start working on an auto-battler game with physical cards.


Initial design:

- Two players share a 30 card deck.
- Each player starts with 20 health.
- Each card in the deck is a minion, with three stats: cost, attack, and health.
- Turns have three phases in order: draw, buy, and fight.
- Draw phase: Each player draws three cards from the deck. Whoever lost the
previous fight draws first. If the deck is empty when trying to draw,
immediately reshuffle the discard pile to allow the draw.
- Buy phase: Each player can play a card to the board by discarding a number of
other cards equal to its cost or pass. Whoever drew first plays first, and this
repeats until both players pass. If the opponent has a minion with no matching
one of yours, your new minion must be played in front of it, otherwise a your
minion may be played on either end of your line of minions.
- Fight phase: Each minion does damage equal to its attack to the thing in front
of it. If it's a minion, that minion's health is reduced by that amount (use
scratch paper). If there's no minion, the opposing player's health is reduced.
- If a minion's health is reduced to 0 it goes to the discard pile. When that
minion is reshuffled and redrawn it will be a new instance of that minion, so
it'll be at full health.
- If a player's health is reduced to 0, they lose and their opponent wins.

Initial deck:

- 5 minions with cost 1, attack 1, health 2
- 5 minions with cost 1, attack 2, health 1
- 5 minions with cost 2, attack 2, health 3
- 5 minions with cost 2, attack 3, health 2
- 5 minions with cost 3, attack 4, health 4
- 3 minions with cost 3, attack 2, health 5
- 2 minions with cost 4, attack 5, health 5
