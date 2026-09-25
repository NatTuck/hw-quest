---
title: "cs4140 Notes: 09-25 User Stories and Workflows"
date: "2026-09-23"
---

## User Stories and Workflows

Our cast of characters (typical cryptographic protocol cast, alternating
gender).

- Alice the Admin
- Bob
- Carol
- Dave
- Frank the Farmer

We're building a web-based MMO farming game called Grange.

Each player manages a farm. They can ship farm produce into town to get money,
which lets them get money, which lets them buy more farming gear, which lets
them produce more farm produce.

## Learning Objectives

By the end of today you should be able to:

- Explain what a user story is and name its parts: the who / what / why plus
  acceptance criteria.
- Turn a vague wish ("make farming fun") into concrete, testable acceptance
  criteria.
- Split an epic into stories that each fit in a sprint.
- Estimate stories with story points and use those estimates to plan, not to
  make promises.
- Trace a story's acceptance criteria to the specific tests that prove it is
  done.

## Where We Are

This week we're working on getting minimal prototype of Grange standing up. But
broadly, we have to decide *exactly what to build*, in pieces small enough that
any one of us can finish one, deploy it, and have someone else confirm it works.

That unit of work is the **user story**. Getting good at writing them is the
difference between a team that makes steady progress and a team that argues
about what "done" means.

## What a User Story Is

A user story is a small thing that a user wants, written down so that:

- A developer can build it in roughly one sprint (a week for us).
- The result is something the customer can actually see, use, and confirm.

The standard shape:

```
As a [kind of user],
I want to [do an action],
So that [I get a benefit].

When I [do the action],
this happens: [the outcome].
```

The first three lines are the *who / what / why*. The last two lines are the
*acceptance criteria*: the specific, observable behavior that tells us the story
is actually done.

## Acceptance Criteria

Acceptance criteria are the whole point. They turn a wish ("I want farming")
into something we can build and test. A story without acceptance criteria is not
ready to work on.

The useful trick is to phrase them as concrete situations. Given/When/Then
works well:

```
Given [the starting situation],
When [the user does something],
Then [this observable result happens].
```

Acceptance criteria should cover:

- The happy path (the normal case).
- Edge cases and failure cases (empty inventory, no money, already occupied).
- What the user can see afterwards.

The one rule that matters most: **an acceptance criterion must be observable
from outside the program.** If you can't describe the thing you would check by
hand — in the running app, with specific inputs — then it isn't an acceptance
criterion. It's a wish.

### Common Pitfalls

- **Cramming several outcomes into one Then.** "Then the field is planted and
  my money drops and a toast appears and the leaderboard updates." Split those
  into separate criteria; each is separately testable and can fail on its own.
- **Describing *how* instead of *what*.** "Then the controller calls
  `Farm.plant/3`" is an implementation detail. A different implementation that
  still plants the seed should pass. Say what changes for the user, not which
  function ran.
- **Missing the failure case.** A story that only describes success is usually
  half a story. What happens with no seeds, no money, or an already-occupied
  field?
- **Vague quantities.** "Fast", "a few", "reasonable", "user-friendly" can't be
  tested. Pin down numbers or a visible state.
- **No way to see the result.** If the only way to know it worked is to query
  the database yourself, the user can't confirm it. Say what shows on screen.

### Non-Functional Criteria

Not everything is about a button. Performance and security are still testable,
and they belong in acceptance criteria:

```
Given 100 players have farms,
When the town leaderboard loads,
Then it responds in under 500ms.

Given Bob is not the owner of Carol's farm,
When Bob tries to edit it,
Then the action is refused and nothing changes.
```

A story about a performance or security property is still a user story; it
just has a narrower "what".

## Our Cast and Roles

Reuse the characters from earlier in the semester. The "kind of user" in each
story maps to one of these:

- Alice the Admin - runs the game, can see and fix anything.
- Bob, Carol, Dave - players, each with their own farm.
- Frank the Farmer - our stand-in for a brand-new player, who knows nothing
  about the game yet.

A story should name a role, not a person: "As a player", not "As Bob".

## Worked Example

Let's take one small story and follow it all the way to tests.

```
As a player,
I want to plant a seed in an empty field,
So that I can grow a crop to harvest later.

When I choose a seed from my inventory and an empty field,
this happens: the seed leaves my inventory and the field starts growing.
```

Acceptance criteria:

- Given Frank has at least one seed and an empty field, when he plants the seed,
  then that field contains a growing crop and his seed count drops by one.
- Given Frank has no seeds, when he tries to plant, then he sees an error and
  nothing changes.
- Given the field is already growing a crop, when Frank tries to plant there,
  then he sees an error and nothing changes.
- Given Frank plants a seed, when he looks at his farm, then he can see which
  field is growing and how long until it is ripe.

This story is now a specification for several different tests:

- A **unit test** of the pure rule "can this field be planted?" - no database,
  no browser, just inputs and outputs.
- A **context / database test** that planting a seed updates the field row and
  the player's inventory in one transaction.
- An **integration test** that performs the whole user action in the running
  app and checks that the field and inventory both changed.

This is the key idea: **a good user story is a spec for a set of tests**. If we
can't imagine the tests, the story is too vague.

## Live Demo 1: A Story Becomes a GitHub Issue

The story above isn't useful until it's in the place the team tracks work. In
this class that place is a GitHub issue on the project's project board.

Live walkthrough:

1. Open the Grange repo and go to the **Issues** tab, then **New issue**.
2. Title it like a story: *Plant a seed in an empty field*.
3. Paste the story and its acceptance criteria into the body. This is the
   important part — see our [standard workflow](../../workflow) which requires
   every issue to state how to confirm it is done.
4. Add labels (for example `feature`) and, if we're using them, a size label.
5. Add it to the project board and move it to **Ready** if it meets the
   readiness checklist below.
6. Assign it to the person who will work on it.

Two habits to build now:

- The issue is where the acceptance criteria live, so the reviewer (a
  *different* person) can check them off at the end.
- The branch and pull request will reference this issue number (`Closes #12`),
  so finishing the PR closes the story automatically.

## Grange Story Catalog

Here is a backlog of small, implementable, testable stories for Grange, grouped
by the game loop. Each one is meant to be finishable in about a week.

The point value next to each story is a rough relative size, not a number of
days. Where those numbers come from is the next section.

### Accounts

**1. Register an account** — 3 points

```
As a new player,
I want to create an account,
So that I have my own farm.

When I submit a name and password,
this happens: my account and my starting farm are created and I am logged in.
```

- Given a name that is not taken, when Frank registers, then he is logged in
  and owns exactly one new farm.
- Given a name that is already taken, when Frank registers, then he sees an
  error and no account is created.
- Given a new account, when Frank looks at his farm, then it has some starting
  money and no crops.

**2. Log in** — 1 point

```
As a returning player,
I want to log in,
So that I get back to the farm I already built.

When I submit my name and password,
this happens: I see my own farm, with the money and crops I left behind.
```

- Given Bob registered yesterday and planted a seed, when he logs in today,
  then his seed is still there.
- Given the wrong password, when Bob tries to log in, then he sees an error and
  is not logged in.

**3. Log out** — 1 point

```
As a player,
I want to log out,
So that someone else on my computer can use the game.

When I click log out,
this happens: I am returned to the login page and my farm is no longer visible.
```

- Given Bob is logged in, when he logs out and visits a farm page, then he is
  asked to log in.

### Farm

**4. View my farm** — 2 points

```
As a player,
I want to see my farm at a glance,
So that I know what I own and what is growing.

When I open my farm page,
this happens: I see my money, my inventory, and each field with its crop
and growth status.
```

- Given Frank has money, seeds, and one growing crop, when he opens the farm
  page, then all three are shown and the numbers match his saved state.

**5. Plant a seed** — 2 points. The worked example above.

**6. Harvest a ripe crop** — 3 points

```
As a player,
I want to harvest a crop that is ripe,
So that I get produce I can ship to town.

When I harvest a ripe field,
this happens: the field becomes empty and I gain the produce.
```

- Given a field is ripe, when Bob harvests it, then the produce is added to his
  inventory and the field is empty.
- Given a field is not yet ripe, when Bob tries to harvest, then he sees an
  error and nothing changes.

**7. Crops grow over time** — 5 points

```
As a player,
I want my crops to grow while I am away,
So that there is something to do when I come back.

When time passes after planting,
this happens: the crop goes from growing to ripe without any further action.
```

- Given a crop with a 10-minute grow time, when 10 minutes elapse, then the crop
  becomes ripe.
- Given the same crop, when only 5 minutes elapse, then it is still growing.
- This should be testable without waiting 10 real minutes (inject a clock or
  check against a stored "ripe at" timestamp).

### Economy

**8. Ship produce to town** — 2 points

```
As a player,
I want to ship produce to town,
So that I earn money for my farm.

When I ship produce,
this happens: the produce leaves my inventory and my money goes up by the
correct amount.
```

- Given Bob has 3 bushels worth 5 money each, when he ships them, then he has
  0 bushels and 15 more money.
- Given Bob has no produce, when he ships, then he sees an error and his money
  is unchanged.

**9. Buy seeds and gear** — 3 points

```
As a player,
I want to buy seeds and tools with my money,
So that I can plant more and grow a bigger farm.

When I buy an item,
this happens: my money goes down by its price and the item appears in my
inventory.
```

- Given Bob has enough money, when he buys a seed, then his money drops by the
  price and his seed count goes up by one.
- Given an item with a price, when Bob buys it, then he never pays more or less
  than that price.

**10. Never go negative** — 3 points

```
As a player,
I want the game to stop me from spending money I do not have,
So that I cannot get stuck with a broken farm.

When I try to buy something I cannot afford,
this happens: the purchase is refused and my money is unchanged.
```

- Given Bob has 4 money and an item costs 5, when he tries to buy it, then he
  sees an error, his money stays 4, and his inventory is unchanged.
- No sequence of actions should ever leave a player with a negative balance.

### Multiplayer

**11. Town leaderboard** — 3 points

```
As a player,
I want to see a leaderboard of farms by money,
So that I know how I am doing compared to everyone else.

When I open the town page,
this happens: I see players ranked by money, highest first.
```

- Given Bob has 100 and Carol has 250 money, when either opens the town page,
  then Carol is listed above Bob.
- Given a player with no money, when the board loads, then that player still
  appears at the bottom.

**12. Visit another player's farm** — 3 points

```
As a player,
I want to visit someone else's farm,
So that I can see what they are growing and get ideas.

When I visit another farm,
this happens: I can see their fields and crops, but I cannot change anything.
```

- Given Bob is logged in, when he visits Carol's farm, then he sees her crops.
- Given Bob is viewing Carol's farm, when he tries to plant or harvest, then the
  action is refused because it is not his farm.

### Admin

**13. Adjust a player's money** — 2 points

```
As an admin,
I want to add or remove money from a player,
So that I can fix mistakes and reward players.

When I set a player's money,
this happens: that player's balance becomes the value I entered.
```

- Given Alice is logged in as an admin, when she sets Bob's money to 500, then
  Bob sees 500 the next time he looks.
- Given a normal player, when Bob tries to visit the admin page, then he is
  refused.

**14. Ban a player** — 3 points

```
As an admin,
I want to ban a player,
So that I can remove someone who is breaking the rules.

When I ban a player,
this happens: that player can no longer log in or touch their farm.
```

- Given Alice bans Bob, when Bob tries to log in, then he is refused.
- Given Alice bans Bob, when Alice unbans him, then Bob can log in again and his
  farm is unchanged.

## Estimation and Story Points

We just put a number next to every story. Why bother, and what do the numbers
mean?

**Why estimate at all.** Not to predict the future exactly. Estimates let us:

- Decide how much work fits in a sprint (a week for us).
- Notice when a story is much bigger than the others.
- Communicate size to each other without arguing about hours.
- Plan what to do first, and what to leave for later.

**An estimate is not a promise.** It's a guess about *relative size* made with
the information we have now. It will be wrong sometimes, and that's fine as
long as it's consistently wrong in the same direction.

### Relative, not absolute

Story points are unitless. "This story is a 3" doesn't mean three hours or
three days; it means *about as big as our other 3-point stories*. To make that
work, the team agrees on a **reference story** and sizes everything else
against it. For Grange we might say:

- *Log in* is a 1 — small, well understood, one screen and one check.
- *Plant a seed* is a 2 — a form, a rule, and a couple of state changes.
- *Crops grow over time* is a 5 — a clock, background behavior, and
  time-dependent tests.

Everything else is "bigger or smaller than these". Notice that a different team
would pick different numbers. That's expected: points are relative to *this*
team, not comparable across teams.

### The Fibonacci scale

The values we use are roughly Fibonacci: **1, 2, 3, 5, 8, 13, 21**. The gaps
get wider on purpose. It's easy to tell a 2 from a 5; nobody can reliably tell
a 9 from a 10. Forcing a choice between 8 and 13 stops us from pretending we
have precision we don't have. If a story lands at 13 or 21, the answer usually
isn't "estimate harder" — it's **split the story**.

### Planning poker

The usual way to estimate as a group:

1. The person who wrote the story reads it and its acceptance criteria.
2. Everyone picks a card and reveals at the same time.
3. If everyone agrees, done. If not, the high and low estimators explain their
   reasoning.
4. Estimate again. Repeat until the team converges.

Revealing at the same time matters: it stops the loudest or most senior person
from anchoring everyone else. The *disagreement* is the useful part — it's
usually a hidden requirement or a different assumption about scope.

### Velocity

Over a few sprints, add up the points actually finished. That average is the
team's **velocity** — say 12 points per week. Next week, don't plan more than
about 12 points of stories. Velocity is a planning tool for the team as a
whole. It is **not** a productivity score for individuals; the moment you
compare people by points, people start gaming the numbers and the estimates
stop being honest.

### Points vs. hours

Why not just say "this takes four hours"? Because hours invite false precision
and pressure: if you say four hours and it takes six, you look slow, even though
the estimate was reasonable. Points are deliberately abstract, so the
conversation stays about the size of the work rather than about how fast
someone is. Points also age better — the same team's points stay comparable
even as tooling and skill change the actual clock time.

### Spikes

Sometimes we can't estimate because we genuinely don't know how something
works, or whether it's even possible. Don't guess. Timebox a **spike**: a small
research task whose deliverable is knowledge (a write-up, a throwaway
prototype), not a feature. At the end of the spike, we can estimate the real
story.

### Estimating the Grange catalog

Look back at the catalog:

- The account stories are small: log in and log out are 1s, register is a 3
  because it also creates the starting farm.
- The core farm loop — plant (2), grow (5), harvest (3), view (2) — is where
  most of the size is. *Grow over time* is the biggest single item because of
  the clock and time-dependent tests.
- The economy stories are mostly 2s and 3s; *never go negative* is a 3 because
  it's a rule that has to hold across every purchase, not just one screen.
- The multiplayer and admin stories are 2s and 3s — they reuse the account and
  farm machinery we already built.

The whole backlog is roughly 35 points. With a velocity of about 12, that's
three weeks of work for the team *if* nothing changes — which, of course, it
will.

## Epics and Splitting

An **epic** is a story that is too big to finish in one sprint. "Crop growing"
is an epic. We split it into the smaller stories above:

- Plant a seed.
- Crops grow over time.
- Harvest a ripe crop.
- View my farm and see growth status.

Why split? Because a 13-point epic can't be finished in a week, can't be
deployed as a useful increment, and can't be tested until it's all done. Each
of the four pieces above, by contrast, can be built, deployed, and confirmed on
its own.

Ways to split a big story, with Grange examples:

- **By workflow step:** planting, growing, harvesting, shipping. Each step is a
  story even though they're parts of one loop.
- **By data:** seeds, crops, inventory, money. Get one kind of thing fully
  working before adding the next.
- **By rule:** the happy path first, then edge cases like "not enough money".
  Ship *buy a seed* before *never go negative*.
- **By role:** the player view first, then the admin view. *Visit a farm* is
  read-only; *edit your farm* comes later.
- **By interface:** the server logic first, then the fancy UI. A plain page
  that works beats a pretty page that doesn't.

A story that is too big to estimate or test is a sign it should be split.

### A checklist for a good story: INVEST

- **I**ndependent — can be worked on without waiting on another story.
- **N**egotiable — the details can change as we learn.
- **V**aluable — someone actually benefits, even if it's just "the game can
  boot".
- **E**stimable — the team can put a number on it.
- **S**mall — fits comfortably in a sprint.
- **T**estable — the acceptance criteria tell us how to prove it's done.

If a story fails several of these, fix the story before writing code.

## Good vs. Bad Stories

**Bad:**

```
As a player,
I want the game to be fun,
So that I keep playing.
```

Why: nobody can build this, estimate it, or test it. There is no observable
outcome.

**Better:**

```
As a player,
I want a crop to take a few minutes to ripen,
So that checking my farm feels rewarding.
```

Even this is fuzzy. The testable version pins down the numbers and the
behavior:

```
Given a crop with a 5-minute grow time,
When 5 minutes pass,
Then the crop is ripe and can be harvested.
```

A quick checklist before a story is ready:

- It names a role and a benefit.
- It is small enough for one sprint.
- It has clear acceptance criteria.
- It is not blocked by other work.
- We can imagine the tests that prove it is done.

## Live Demo 2: Stories Drive Tests

The payoff of a well-written story is that it tells us exactly what to test. The
kinds of tests from the testing notes line up with the parts of a story:

- **Unit tests** cover the pure rules: growth math, prices, "can this field be
  planted?".
- **Context / database tests** cover the state changes: planting updates the
  field and inventory together, money is never negative.
- **Controller / LiveView tests** cover a single user action: submitting the
  plant form, seeing the error when there is no seed.
- **Integration tests** cover a whole workflow described by a story: register,
  plant, wait, harvest, ship, and buy, all in order.

Let's take the *plant a seed* story and write the tests its acceptance criteria
imply. We follow the [standard workflow](../../workflow): write the failing test
first, then make it pass.

### The pure rule gets a unit test

Given Frank has at least one seed and an empty field, when he plants the seed,
then that field contains a growing crop and his seed count drops by one. The
"is this allowed?" part is pure logic — no database, no browser:

```elixir
defmodule Grange.Farm.PlantingTest do
  use ExUnit.Case, async: true

  alias Grange.Farm

  test "an empty field can be planted" do
    assert Farm.can_plant?(%{crop: nil}, seed_count: 1)
  end

  test "a field that is already growing cannot be planted" do
    refute Farm.can_plant?(%{crop: %{kind: :wheat}}, seed_count: 1)
  end

  test "planting without a seed is not allowed" do
    refute Farm.can_plant?(%{crop: nil}, seed_count: 0)
  end
end
```

### The state change gets a context test

Planting has to move a seed *out* of the inventory and put a crop *into* the
field, and it has to do both or neither:

```elixir
test "planting moves a seed from inventory into the field" do
  player = player_fixture(seeds: 1)
  field = field_fixture(player, crop: nil)

  {:ok, field} = Farm.plant(player, field, :wheat)

  assert field.crop == :wheat
  assert Farm.get_player!(player.id).seeds == 0
end
```

### The user action gets a LiveView test

Given Frank has no seeds, when he tries to plant, then he sees an error and
nothing changes:

```elixir
test "planting with no seed shows an error", %{conn: conn, field: field} do
  {:ok, view, _html} = live(conn, ~p"/farm")

  view
  |> element("#plant-#{field.id}")
  |> render_click()

  assert render(view) =~ "You have no seeds"
end
```

### The whole workflow gets an integration test

Finally, the acceptance criteria that only make sense as a sequence — register,
plant, wait for it to ripen, harvest, ship — become one integration test that
drives the public interface end to end.

### Mapping criteria to tests

| Acceptance criterion | Test type |
| --- | --- |
| Empty field can be planted | Unit (pure rule) |
| No seed → error, nothing changes | LiveView / controller |
| Already-growing field → error | Unit |
| Planting updates field and inventory together | Context / DB |
| Player sees which field is growing and how long until ripe | LiveView |
| Register → plant → harvest → ship all work | Integration |

So when we pick up a story, the acceptance criteria tell us exactly which tests
to write, and those tests are how we know the story is really done. If a piece
of an acceptance criterion doesn't map to any test, either the criterion is
untestable or we're missing a test.

## Definition of Ready (Overflow)

That readiness checklist is a rough version of our **definition of ready** —
the bar a story has to clear before anyone starts it. In our board terms:

- **New:** a story nobody has checked yet. Not ready.
- **Ready:** someone could start this right now. To be ready it needs a clear
  benefit, acceptance criteria, no unmet dependencies, and an estimate.
- **In progress:** someone is actively working on it.
- **Ready for test:** the author thinks it's done and deployed, and it's waiting
  for someone else to confirm the acceptance criteria. Critically, the tester is
  **not the author**.
- **Done:** it passed acceptance testing.

Two more rules of thumb:

- Keep to **one story in progress per developer**. Finishing beats starting.
- If your story is blocked by a story that hasn't started, send your story back
  to New and take the blocker instead.

## Developer Stories, Bugs, and Housekeeping (Overflow)

Not every issue is a feature. Two other common cases:

- **Bugs.** A bug still becomes an issue, and it still needs a way to confirm
  the fix. The confirmation is often just a simple story: *"As a player, I want
  the game not to crash when I plant with an empty inventory, so that I don't
  lose my farm."*
- **Housekeeping.** Upgrading dependencies, setting up CI, adding a linter.
  These are "developer stories" — *"As a developer, I want the test suite to run
  on every pull request, so that broken code doesn't reach main."*

Stories that start "as a developer" are broadly discouraged, because they don't
describe value a user can see. But they're acceptable when there genuinely is
no user-facing framing. Don't force a fake user story onto a plumbing task.

## Follow Up

For next time:

- Pick a handful of stories from the catalog (or write your own) and turn them
  into GitHub issues for Grange.
  - State the acceptance criteria in the issue body.
  - Add them to the project board.
  - Estimate them — as a team, using planning poker if you can.
- Remember the test habit: a story isn't done until the tests for its
  acceptance criteria pass and someone else has confirmed them.

