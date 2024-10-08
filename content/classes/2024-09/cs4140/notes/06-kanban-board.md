---
title: "cs4140 Notes: 06 Taiga.io Kanban"
date: "2024-09-07"
---

## Kanban Board / Taiga.io

 - Go to Taiga.io
 - Sign in with Github
 - Start coming up with user stories for Party Animal app

### User Stories

Conceptually, a user story should be a description of something that
the customer wants that the developers can build.

 - A developer should be able to build one story reasonably quickly.
 - That work should be deployable, and the customer should be able
   to confirm that they got what they want.

Standard format:

<blockquote>
As a [what kind of user],<br>
I want to [action / task],<br>
So that [benefit]<br>
<br>
When I [action]<br>
This happens: [outcome]
</blockquote>

For our tools, there are some extra considerations:

 - Our tool, Taiga.io Kanban Board, calls everything we manage a user story.
 - To make a big story small enough to complete in a week or so, it may
   need to be split up into pieces too small to produce a user-visible
   deliverable.
 - Bugs produce github issues, which sometimes turn into only very
   simple are simple user stories ("as a user, I want the app to not
   break when I ...").

So when reasonable, stories **should** follow the standard format, but
not all stories will. Stories that start "as a developer" are broadly
discouraged but acceptable when appropriate.

### Kanban Board Columns

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
   - What will be tested
   - Who will test (preferably the customer)
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

### Prefer one story in progress per developer

 - If you're not working on a story, try to start one.
 - If you're already working on a story, try to finish it before
   starting another one.
 - If your first story is blocked, it may be appropriate to take a
   second story to have something to do.
 - Unblocking blocked stories should be high priority for everyone.
 - If your story is blocked by a story that isn't started, you might
   want to send the blocked story back to NEW and take the dependency
   instead. If it's in new, it doesn't need to be marked blocked.

# Example

## Create a Party Animal app with Phoenix

 - Show installing deps to get it to work.
 - Start up the app

## Walk through the whole change process

**Plan Feature in Taiga**

 - Go to https://tree.taiga.io

Add a story:

<blockquote>
As an event host,<br>
I want to create events,
So I can share them with my guests.
<br>
When I look at the home page,
I can get to the new event form.
</blockquote>

Edit in acceptance requirements:

 - Start with a student and a completed quiz.
 - Student visits the quiz page, score is visible and correct.

Mess with Kanban board:

 - Check criteria for ready, move to ready.
 - Assign story to me, move to started.

**Implement Feature in Code**

 - 

**Pull Request**

 - Push this branch back to my fork.
 - Use Github site to create pull request.

**Code Review**

**Deploy**

As correctly observed by [@stahnma
](https://twitter.com/stahnma/status/634849376343429120):

> Everybody has a testing environment. Some people are lucky enough
> enough to have a totally separate environment to run production in.

Our plan is low friction continuous deployment, so we'll intentionally
skip having our production environment seperate from our testing
environment.

I'm not ready to demo deployment, maybe next week.

**Acceptance Testing**

Someone tests the story on the live system, per the acceptance test 
criteria. 

 - Not the person who coded the story.
 - Optimally the person who requested the story tests it.

**Done**

Once it's been acceptence tested, it gets moved to DONE.


