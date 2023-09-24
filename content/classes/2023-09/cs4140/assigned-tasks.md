---
title: "cs4140 Fall 2023: Assigned Tasks"
date: "2023-09-14"
---

# Week 7:

**(future week) This list may not be complete / final**

 - Create and deploy minimal project demo.
 - Get first customer feedback.
 - Come up with several user stories.

# Week 6:

**(future week) This list may not be complete / final**

 - Use github actions or custom scripts on your VPS to
   continously deploy your quiz app.
 - Deploy final release of quiz app.
 - Complete initial customer meeting, produce on-paper notes and sketches
   for your customer's app.
 - Meet with customer, include meeting notes with Week 6 report.
 - Create Taiga.io Board for customer project; add team, customer,
   Prof. Tuck.

# Week 5:

Tasks due with week 5 report:

 - Deploy updates to VPS
 - Complete "full quiz workflow" from week 4.
 - Generate test coverage for server-side tests.
 - Set up Github actions to run your server-side tests.
 - Start: Get testing working for browser JS, with coverage.
 - Start: Set up Github actions to run your browser JS tests.
 - Discover and start new user stories for quiz app.
 - Contact real project customer, set up initial meeting.

# Week 4:

Tasks due with week 4 report:

 - Deploy your initial app to a team member's VPS
 - Using a CSS framework and your app framework's layout mechanism
   intentionally layout and style your gobal page header
 - Start and make progress on implementng the full quiz workflow up
   through a student getting a score on a set of true/false questions.
   This should involve:
    - RDB tables for: Question, Answer, Student 
    - Tables should be connected with integer keys
    - You can assume one teacher and one quiz
    - You should have web UI to manage students (just a name),
      manage questions, take the quiz, and show the results.
    - By the week 4 report, at least one resource should be fully
      CRUDable through the web UI.
 - Start and make progress on testing server-side logic using the
   standard test tools for your language / framework.
    - By the week 4 report, running the standard test command should
      run unit tests for models and pages, several of which should pass.
 - Use in-browser javascript to validate a form before submission.
   This should use a full asset pipeline.

# Week 3:

**All tasks worked on after Week 2 should be on your Taiga.io Kanban board**

Tasks due with the Week 3 report, all team tasks:

 - Use your selected web framework to create your initial 
   [Quiz App](../quiz-app)
   - Push it to a primary github repository
   - Set permissions so team members can merge PRs, manage issues
   - All other team members should fork on github
 - One team member should set up a Virtual Private Server
   - Using a commodity VPS provider like Digital Ocean, Vultr,
     Linode, Amazon Lightsail, etc
   - Debian Stable or Ubuntu LTS, at least 1GB of RAM
   - Point a public DNS record at it
   - Install nginx, get it to serve a page that says
     "This is [Name]'s server for cs4140, Fall 2023"

# Week 2:

Tasks due with the Week 2 report:

 - Sign up for Taiga.io, using your github account
 - Set your name and icon in Slack
 - (team) What web framework did you pick?
 - (team) Make sure you have a Slack channel for your team
 - (team) Create a project on Taiga.io and add your team and Prof.
   Tuck to it.
 - (team) Make sure a story has been assigned to each team member

# Week 1:

Tasks due with the Week 1 report:

 - Research persistent chat services, be ready to suggest one for the class
 - Research web frameworks, be ready to suggest one for your team
 - Sign up for a Github account with your university email address
