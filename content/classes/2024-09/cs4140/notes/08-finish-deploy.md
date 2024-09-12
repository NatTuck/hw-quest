---
title: "cs4140 Notes: 08 Finish Deploy"
date: "2024-09-11"
---

Last time we started deploying Party Animal.

 - Finish deploy
 - We're just going to run the app in dev mode
 - We still need a user service.
   - https://wiki.archlinux.org/title/Systemd/User
   - Remember enable-linger
 - We need a start script to run.
 

# Team Meeting

Practice App:

 - Our practice app is going to be "Bad Date", a dating app that does an
   intentionally bad job at suggesting matches while trying to avoid
   being too obvious about it.

Right now:

 - Everyone should be on https://cs4140.party
   - Create a channel for your team.
 - Create a Taiga.io account
   - Create a Bad Date project for your team.
   - Add all team members and Prof. Tuck to the project.
 - Github:
   - Create an organization for your team.
   - Give all team members permissions to manage the repos.
 - New Project
   - Someone on your team get the Phoenix Framework set up,
     create a new bad_date project, and push it to a repo under
     your org account.
 - Create stories for adding each team member's name to the project
   README, assign those tasks to those project members.
 - Make sure git and an editor is installed on each team member's machine.
 - Go through the full process (again) of fork, clone, edit, commit, push,
   pull request, etc to complete the stories.
 - Leave the stories in "in progress", since it's not yet feasible to deploy.
 - Discuss which team member will register the first virtual server and
   domain for the test app, and what the domain should be.
