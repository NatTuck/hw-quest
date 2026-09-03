---
title: "cs4140 Notes: 08-04 Core Workflow"
date: "2026-09-01"
---

- Issue
  - Clear Description
  - Acceptance Criteria (how to manually confirm resolution)
- Do the work
  - Issue assigned to Alice
  - Personal fork
  - Local clone
  - Feature branch
  - Work on feature branch locally
  - Automatic tests first, initially failing due to the issue
  - Write code to solve the problem
  - Automatic tests pass now
  - Manual testing confirms acceptance criteria met
  - Push branch to personal fork on Github
  - Create PR from branch to main repo
- Review
  - The PR is a new issue
  - It gets assigned to someone else, Bob (Bob is not Alice)
  - Bob confirms that tests are passing (optimally in CI)
  - Bob reads the issue, pulls the feature branch down locally,
    manually tests for the acceptance criteria
  - Bob hits the code review button on Github
    - Read every line of modified code
    - Are the changes related to the issue?
    - Are the changes reasonable? (style, approach, efficiency, security, etc)
    - Problems: Comments in Github UI, ping to Alice
  - Once the PR is good, bob hits "Squash and Merge"
  - After the merge, Bob confirms that CI still passes. If not, revert.

We'll walk through this for adding a new card.

- The card list lives in shared/cards.ts
  - The list itself is just a single immutable global, `cards`
  - Currently we build a list of 60 unique cards out of a pool
  of two, so we generate a bunch of distinctly named copies.
  - To add a new card, we add it to the list.
- We're going to add "zap", which does one damage to an opposing bot.

```ts
const zap: Omit<Card, "name"> = {
	type: "action",
	atk: 0,
	hp: { current: 0, max: 0 },
	status: [],
	effect: { kind: "damage", amount: 1 },
};

/** The master list of all cards in the game. Never mutated at runtime. */
export const cards: Card[] = [
	...range(10).map((n) => ({ ...duck, name: `Robot Duck ${n}` })),
	...range(30).map((n) => ({ ...repair, name: `Light Repair ${n}` })),
	...range(20).map((n) => ({ ...zap, name: `Zap ${n}` })),
];
```

That gives us a type error, saying "damage" is not assignable. We've got
to go look in shared/types.ts

Looking at the CardEffect type, damage sounds like it's structurally similar
to repair, so:

```ts
export type CardEffect = 
  | { kind: "repair"; amount: number }
  | { kind: "damage"; amount: number };
```

That fixes the type issue.

Then we need to actually implement the effect in server/gameplay.ts:

```ts
function applyEffect(
	effect: NonNullable<GameCard["effect"]>,
	boardOwner: GamePlayer,
	slot: number,
): void {
	const bot = boardOwner.board[slot];
	if (!bot) return;
	if (effect.kind === "repair") {
		bot.hp.current = Math.min(bot.hp.max, bot.hp.current + effect.amount);
	}
	if (effect.kind === "damage") {
		bot.hp.current = Math.max(0, bot.hp.current - effect.amount);
	}
}
```

That'll stop being good style quickly once we have a couple more effects, 
but this works for now.

[Zap Illustration](../zap-illustration.jpg)

Picture goes in public/images

Then we've got to hook up the browser logic:

- src/cardImages.ts, add to the map.

That should be everything. `pnpm dev` to test it.

Once it seems to work:

```
git add -A .
git status # check what we added, only the files we meant to add
git commit -a -m 'add zap'
git push
```

On Github:

- Create PR

Now, *a different person* needs to do the next step:

- Read every line of modified code
- Are the changes related to the issue?
- Are the changes reasonable? (style, approach, efficiency, security, etc)
- Problems: Comments in Github UI


## How do we figure out where stuff is if we really have no idea?

Introduce OpenCode
