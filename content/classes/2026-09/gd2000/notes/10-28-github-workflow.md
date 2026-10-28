---
title: "gd2000 Notes: 10-28 Github Workflow"
date: "2026-10-28"
---

First, attendance code on Inkfish.

## The Multi-Developer Github Workflow

**Setup**

- Initial state: We have a primary git repository
- Each developer has a personal fork of that repository
- The fork is then cloned locally.

**Work Loop (Like A Game Loop)**

- An issue is created and assigned to a developer.
- The developer creates a feature branch (`git checkout -b some-feature-branch`)
- Then the developer fixes the issue.
- Then the developer commits their changes and pushes to their local branch:
  `git add -A .; git commit -a -m 'some message'; git push`
- Then they create a PR from the feature branch to the main fork.
- Then *someone else* reviews the PR and either provides comments or merges it.
- Repeat.
