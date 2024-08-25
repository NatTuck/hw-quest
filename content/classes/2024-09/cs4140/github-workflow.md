---
title: "cs4140 Fall 2023: Github Workflow"
date: "2024-08-23"
---

This document describes a particular workflow using Github. This isn't
the only way to use Git or Github, but this is what we're doing in
this class.

A project lives in a primary repository on Github. For a larger
project this belong to Github organization, but for us it's fine if
this just belongs to any team member.

Every team member is a collaborator on the primary repository, with
sufficient permissions to perform tasks like merging pull requests and
managing issues.

Each team member (aside from the owner of the primary) should have a
fork of the primary repository on their Github account.

To get a local working copy:

 - Clone your personal fork to your local machine.
 - Add the primary repostory as an extra remote, good names for this
   remote are "upstream" or "primary".

To make a significant change to the repository contents.

 1. Work from your local working copy (cloned from your fork)
 1. Pull the latest version (of the "main" branch) from the primary
    repository and push that to your fork
 2. Create a local working branch
 3. Do your work in the local working branch
 4. Push to your personal fork on Github
 5. Use the github Web UI to make a pull request
    - This should run automated tests, fix any issues with those
 6. Have someone else code review your pull request
    - Reviewer suggests changes
    - Developer makes those changes
 7. When the reviewer is happy with the branch, they press the merge button
