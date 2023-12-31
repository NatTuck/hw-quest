---
title: "cs4140 Fall 2023: Assigned Tasks"
date: "2023-10-09"
---

# Week 16:

 - Present final presentations
 - Friday, Dec 15, 8:00 - 10:30am
   - I'm thinking 9-10:30am sounds better

# Week 15:

 - Set up customer infrastructure
 - Customer should have their own copy of the project on their github
   - Not a github fork:
     - customer creates new empty repo
     - clone project
     - replace remote in .git/config with new customer repo
     - push
   - Old main repo should be renamed
   - Team should re-fork from customer's repo
 - Customer should have own VPS: Recommend a Linode $5/month server + backups
 - Domain should be on customer's registrar account
   - Transfer if needed
   - Point domain to Customer's VPS
 - Deploy to customer VPS
 - Test Continous Deployment from customer Github to customer VPS when
   customer clicks the Merge PR button.

# Week 14:

 - Each team member should spin up a VPS and follow the deployment
   instructions to spin up your app.
 - Meet with the customer and make sure they have their own:
   - Github account
   - Domain registrar account
   - VPS account: Linode is recommended - they have better auto-backups
 - Start thinking about final presentations

# Week 13:

Deployment instructions:

The README in your Github repository should provide clear instructions to
deploy your app on a newly created Debian 12 VPS.

# Week 9:

 - Meet with customer and get more customer feedback.
 - Make sure forward progress is occuring towards what the customer wants.
 - Come up with user stories and move those stories across the Kanban board.
 - Write tests first.
 - Make, review, and approve pull requests and have them automatically
   deployed.
 - Generate test coverage reports.
 - Move towards 100% test coverage.
 - Make sure all team members have the opportunity to contribute to
   all aspects of the project.
 - Make sure each team member has written code, made a pull request,
   and had it approved that touches the server-side logic of the project.
 - Make sure each team member has written code, made a pull request,
   and had it approved that touches the browser-side logic of the project.
 - Make sure each team member has reviewed a pull request.
 - Make sure your project site isn't blocked on the campus network. If it is,
   email psu-helpdesk@plymouth.edu requesting that it be unblocked, cc me.

# Week 8:

 - Get CI and CD set up for project.
 - Set up TLS with Certbot for project.
 - Make sure you have the MIT license specified in your project repo.
 - Make and deploy project revisions.
 - Meet with customer and get more customer feedback.
 - Make sure forward progress is occuring towards what the customer wants.
 - Make sure all team members are contributing.
 - Each person should:
   - Author at least one pull request with non-test changes.
   - Author at least one pull request that creates or updates a test.
   - Review at least one pull request.

# Week 7:

 - Create and deploy minimal project demo.
 - Get first customer feedback.
 - Schedule short weekly meeting with customer.
 - Your minimal project demo should be in a github repository, all
   teammates should have access, and it should specifiy the MIT
   license.
 - Come up with several user stories.

# Week 6:

 - Use github actions or custom scripts on your VPS to
   continously deploy your quiz app.
 - Add an open source license to your Quiz app github repo. If you
   have a package.json file, make sure the license field is correct.
 - Deploy final release of quiz app.
 - Setup TLS for quiz app with Certbot.
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
