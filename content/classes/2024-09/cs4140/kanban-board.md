---
title: "cs4140 Fall 2024: Kanban Board"
date: "2024-08-21"
---

To manage our projects, we'll use a Kanban board, as provided by [taiga.io](
https://taiga.io).

## What goes on the board?

Optimally, all work towards the project that involves technical
changes should go on the board as a story.

**User Stories**

[User stories](./user-stories) are things the customer wants that the
team can build for them.

**Developer Stories**

It's preferable to describe stories in terms of benefit to the
customer, but sometimes splitting a story down to small enough pieces
leaves you with an infrastructure goal that doesn't really get the
customer anything (yet).

In those cases it's OK to write a developer story, which is a user
story where the user category is "developer" (or "manager").

**Issues**

Issues come in on Github and describe a bug or feature request.

Issues should be translated into a user story linking to the issue.

For simple bugs, the standard description template is overkill, so
something like this is fine to start with:

> As a user I want to register without getting an internal server error.
>
> See github issue #37 (link)

## What doesn't go on the board?

Administrative overhead, like writing stories or reports, doesn't go
on the board.

## Where do they go?

**NEW**

New stories go in NEW.

Stories that aren't actively being worked on and don't meet the
requirements for READY go back in NEW.

**READY**

A story is READY if someone could start working on it but has not yet
done so.

The critera for ready are:

 - There is a benefit to actually doing this now
 - It has clear Acceptance Criteria
 - External dependencies defined and met
 - Points are estimated (when in doubt, try [Planning Poker](
   https://en.wikipedia.org/wiki/Planning_poker))

**IN PROGRESS**

Someone is actively working on this story.

**READY FOR TEST**

The assigned developer thinks this task is complete and deployed and
it is ready for acceptance testing.

Acceptance testing must be done by someone other than the assigned
developer.

 - Optimally, the customer
 - If not the customer, then by another team member

A developer story is always acceptance tested by a developer who is
blocked by that story.

When a story moves to READY FOR TEST, make sure to add a comment
linking to the pull request for this story.

**DONE**

The task has been recently completed and accepted.

**ARCHIVE**

The task has been done for a while and doesn't need to be visible on
the board for a while.

If there's no more important consideration, it's reasonable to archive
a story if it's been done for a full week.

## Other Notes

**Prefer One Story Per Developer**

 - If you're not working on a story, try to start one.
 - If you're already working on a story, try to finish it before
   starting another one.
 - If your first story is blocked, it may be appropriate to take a
   second story to have something to do.
 - Unblocking blocked stories should be high priority for everyone.
 - If your story is blocked by a story that isn't started, you might
   want to send the blocked story back to NEW and take the dependency
   instead. If it's in new, it doesn't need to be marked blocked.
