---
title: "gd2000 Notes: 10-14 Auto Battler"
date: "2026-10-13"
---

First, attendance code on Inkfish.

## Auto Battler

Today we're going to start working on an auto-battler game with physical cards.

### Initial design

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
- Upgrades: During the buy phase, when you could play a minion, you can instead
upgrade a minion by combining three minions of the same name. You can use
minions in play on your side and revealed from your hand. This makes a new
minion with the same cost and double the attack / health. If at least one
original minion was in play, the new one ends up in play in the same position.
- Fight phase: Each minion does damage equal to its attack to the thing in front
of it. If it's a minion, that minion's health is reduced by that amount (use
scratch paper). If there's no minion, the opposing player's health is reduced.
- If a minion's health is reduced to 0 it goes to the discard pile. When that
minion is reshuffled and redrawn it will be a new instance of that minion, so
it'll be at full health.
- If a player's health is reduced to 0, they lose and their opponent wins.

Initial deck:

- 5 minions with cost 1, attack 1, health 2, named A
- 5 minions with cost 1, attack 2, health 1, named B
- 5 minions with cost 2, attack 2, health 3, named C
- 5 minions with cost 2, attack 3, health 2, named D
- 5 minions with cost 3, attack 4, health 4, named E
- 3 minions with cost 3, attack 2, health 5, named F
- 2 minions with cost 4, attack 5, health 5, named G


### Design space

After trying this version, here's some design questions to ask:

- What's the basic game loop here? Can a slower or faster extra loop
be usefully added?
- Should there be one deck or two in each game?
- If each player gets their own deck, what should be the deck building rules?
- How many cards should be in the deck?
- Should there be card types other than minions?
- Is discarding as the cost to play cards good, or would it be better to track money / resources with tokens somehow?
- Is tracking damage to minions worth it? It certainly be simpler to just have every minion heal to full at the end of each round?
- Should there be ways to re-order minions.
- Is one row of minions on each team the right shape?
- Is there a value to having player hands be hidden?
- Should minions do stuff other than just smashing their heads together like
rams and seeing who dies first?
- If minions have abilities, how does that work? How many times can they use an
ability? If they use their ability, do they still deal damage this turn?
- Do the stats for the minions in the initial deck make any sense? Is there some
way that cost and attack/health should be related to make gameplay interesting?
- We want an upgrade mechanic. The stock mechanic good? Are the minion duplicate
counts good?
- This is a two player game. Would it be better with more players? How would
that work?

You should be able to come up with way more questions than that.


