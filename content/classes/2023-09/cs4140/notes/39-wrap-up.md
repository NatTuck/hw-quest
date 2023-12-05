---
title: "Notes: 39 Semester Wrap-Up"
date: "2023-12-05"
---


Last moving parts in Word Game:

 - Pull up https://words.homework.quest/
 - Get students to join.
 - Show code for multiple games.
 - Show code for Eggman
 - This pattern should scale OK with multiple cores to
   many concurrent users across many games.
 - Bottleneck is probably the registry process - if there's really
   very little compute involved, we'd want to add PID caching for RPCs.
 - What if a process crashes?

Quick check:

 - How's project going?

The syllabus says:

> To encourage more responses, each class has the chance to earn a 1%
> bonus to everyone’s final grade. This bonus applies if at least 75%
> of the students complete their evaluations by 10am on the Monday of
> finals week.

What did we cover this semester?

 - Agile Process
   - Talk to actual customer
   - Get working program
   - Move from working program to better working program, incrementally.
 - Github Workflow
   - Forks
   - Feature Branches
   - Pull Requests
 - Different Frameworks
   - You ended up using Rails, NextJS
   - Checkout other frameworks too - now that you've seen the basic
     pattern, it's useful to see how different developers vary it.
 - Automated Testing
   - Why? 
   - TDD
   - Coverage
 - Continuous Integration
   - Kinds of test: Unit, Request, End-to-End
   - Github Actions
 - Manual Deployment
 - External Depenencies
   - Package tools
   - Licensing
   - Supply chain risk
 - Continous Deployment
   - Automating with Github Actions
   - Why?
 - Security
   - TLS / HTTPS
   - Authentication / Sessions 
   - Passwords
   - Common web app vulnerabilities (XSS, XSRF, Injections, etc)
 - Modern Frontend Stuff
   - React
   - Redux
   - Tailwind
   - JS Deps
 - Distributed State
 - Vendor Risk
 - Customer Handoff

Stuff

  - Last meeting Friday
  - Final Presentations




