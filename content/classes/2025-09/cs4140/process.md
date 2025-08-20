---
title: "cs4140 Fall 2025: Process Notes"
date: "2025-08-16"
---

Here are some notes documenting processes we will be following for the class.


## The Standard Github Workflow, with TDD

**Creating an Issue**

 - We start with an issue on the main project Github repo.
   - This may be a bug, a feature request, or just something that needs to get
     done (e.g. a "housekeeping task").
   - The issue should clearly state acceptance criteria (how to manually confirm
     that the issue has been resolved).

**Doing the Work**

 - The issue gets assigned to Alice.
 - Alice has a personal fork of the main repo on Github.
 - Alice has cloned her personal repo to her local workstation.
 - Alice locally creates a feature branch to work on the issue.
 - Alice writes tests that initially fail, but will pass when the issue is
   resolved.
   - Alice locally runs the test suite and confirms that the new tests fail.
   - Alice does a local commit with the tests.
   - Tests can be skipped if no new code will be written (e.g. documentation tasks)
 - Alice writes code for the issue.
   - Alice locally runs the test suite and confirms that the new tests pass.
   - Alice locally runs the app and manually tests the new code.
   - Alice explicitly checks that the acceptance criteria for the issue has been
     met.
 - Alice makes sure her new branch is pushed to Github.
 - Alice makes a pull request from her new branch to the main repo.
 - Github should automatically run the test suite. Alice should push any
   necessary fixes.

**Review and Pull**

 - The PR issue gets assigned to Bob.
   - Critically, Bob is a different person than Alice.
 - Bob confirms that the tests are passing for the PR in CI.
 - Bob reads the initial issue, pulls down the feature branch,
   runs the code locally, and:
   - Confirms the acceptance criteria are met.
   - Confirms that there's no obviously broken behavior.
 - Bob hits the code review button on Github and reads every line
   of modified code.
   - Are the changes all related to the issue?
   - Are the changes reasonable (style, approach, efficiency, security, etc)?
 - If there are any problems with the code, Bob comments in the Github UI
   and pings Alice to fix them.
 - Repeat until the PR is good.
 - Once the PR is good, Bob presses the "squash and merge" button.
 - Bob double checks that the tests still pass after the merge. If not
   Bob reverts the merge and asks Alice to fix it.


## Kanban Board Sequence

**NEW**

 - Story is created in NEW column.
 - Optimally, in user story format.

**READY**

For a story to transition from NEW to READY, it must:

 - Be clearly written.
 - Be estimated, and possible to complete in one week.
 - Not be blocked on anything; work can start immediately.
 - Have acceptance criteria.

**IN PROGRESS**

For a story to transition from READY to IN PROGRESS, it must:

 - Be assigned to someone who has no other IN PROGRESS stories
   as the developer.
 - Someone can be assigned to two IN PROGRESS stories at once, one
   as developer, one as reviewer.

**READY FOR TEST**

For a story to transition from IN PROGRESS to READY FOR TEST, it must:

 - Be done. A PR has been made, reviewed, and merged.
 - Be reassigned to the manual tester.

**DONE**

For a story to transition from READY FOR TEST to DONE, it must:

 - Have been deployed and manually tested.

**ARCHIVED**

Stories get archived when they've been done for a week without any
related problems being discovered.
