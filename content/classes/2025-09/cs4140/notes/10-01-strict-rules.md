---
title: "cs4140 Notes: 10-01 Stricter Rules"
date: "2025-09-29"
---

## The Problem

- We've got more than one developer.
- More than three even.
- Somehow we've got one file with a ton of our logic in it.
  - It's supposed to be our UI.
  - But it's also got a bunch of game logic.
- We've got rumors of features breaking from conflicting PRs.
  - Tests are supposed to help avoid that.

## It's time for more process and policy (yay!)

### Pull Request Review Checklist

- Does this PR have single, well defined topic?
- Do the changes seem like a reasonable way to accomplish
  what the PR is trying to do?
- Are the significant majority of the changes related to that
  topic (implementation, tests, refactoring to enable, etc.)?
- Are all existing tests preserved except for intentional,
  topic-related behavior changes?
- Are there new tests for any new intended behavior?
- Is the code formatting reasonable?
- Is all the code in the right places?
  - UI stuff in UI files.
  - UI broken into named components and appropriately separated
    out into not-too-big files.
  - Game logic stuff in game logic files.
  - Schemas in schema files.
  - etc.
- Will pulling this PR, as is, improve the codebase?


If there are any major checklist failures, send the PR back to the
submitter to get fixed. Fixing may be small changes, or it may
require splitting the PR into two or more separate PRs - that's okay,
even if making new branches and moving changes around is annoying.

It's also okay if there's more than one PR for a story or if you end
up adding and completing extra stories in order to get PRs through.


### Auto Formatting

We can apply standard formatting to the whole project with

```bash
$ mix format
```

In our tests, we can confirm that mix format was run with

```bash
$ mix format --check-formatted
```

This is probably worth doing just to make things cleaner.


### Code Coverage

```bash
$ mix test --cover
```

This shows us how many lines of code get executed when we run
the test suite for each module.

We also can run this from CI and it'll fail if coverage is
below a threshold.

We can configure the threshold in `mix.exs`:

```elixir
 def project do
    [
      ...
      test_coverage: [
        summary: [
          threshold: 20
        ]
      ]
    ]
  end
```

If we set a low threshold, we also should add an item to our
review checklist:

- If coverage threshold is below 80, did this PR increase
  the coverage threshold?
- 




