---
title: "cs4140 Notes: 08-29 Github Workflow"
date: "2025-08-27"
---

## Github Workflow

Github intro:

 - Create a user account for github.com
 - Github stores git repositories at github.com/{user}/{repo}

Github workflow, (to make a change in someone else's repo):

(demo with https://github.com/fogcloud/workflow-demo )

- Personal fork to your github account
- Clone to local workstation
- Feature branch
- Make the change
- (run any tests locally)
- Commit, push to your fork on Github
- Use github UI to make pull request to the main repo.
- A team member other than the one who created the pull
  request should review and merge it.

Setting up Taiga.io:

- http://taiga.io
- New Kanban project.
- What's our app called?
  - Let's ask Gemini
  - "What's a good name / codename for a web-based MUD that does cross-server
  federation? Preferably one reasonably short word."

## Let's start our project

- Github
- We've got a github org: https://github.com/psu-cs4140
- We're going to be using Elixir/Phoenix, so I'm going to make a new Phoenix
  app. We'll talk more about details there later.
- mix phx.new ... ; git init . ; git add -A . ; git commit -a -m 'new app'
- New repo; empty.
- Push to github.

## First Taiga Stories

- One story each to add each person's name to the CREDITS file.
- New teamset on Inkfish
  - These teams aren't for working together; they're code reviewer pairs.
  - Your teammate reviews and merges your work, and visa-versa.
- New assignment on Inkfish
  - Add your name to the credits file.
  - Follow our full workflow: assign card to you, move to in-progress, feature
    branch, pull request, partner does code review, merges the request, move
    to ready for test.
  - These should stay in ready for test until we confirm that the names are
    all in there in class.
- Send me a private message on Mattermost with your github email address and
username so I can add you to the project on both Github and Taiga.

## Setting up Aider

- This is going to work best with a Unix-style command line. If you're
  running Windows, this is a great time to do one or more of:
  - Install Linux instead.
  - Get refub Thinkpad (e.g. x13 gen 2) and install Linux on that.
  - Install WSL.
  - Set up a Linux VM in VirtualBox.
  - Buy a bottle of Tylenol and try to make it work in PowerShell.
- https://aider.chat/
- We need python first, as well as some basic dev tools.
  - ```sudo apt install python-is-python3 build-essential git```
- Then we need an OpenRouter API key.
- https://openrouter.ai
  - Credits
  - Key
- Might as well write a game and stick it on Github Pages.

