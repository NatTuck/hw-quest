---
title: "cs4140 Notes: 15 Automatic Deployment"
date: "2023-10-01"
---

Today: Continuous Deployment

Why?

 - Deploying manually requires human time, effort, and attention.
 - Automatic deployment enforces a norm that we always deploy what we have.

Deploy to where?

 - "Every project has a testing environment. Some projects also have a seprate 
    production environment."
 
Having a separate production environment allows for manual testing of
new releases on a test server before deploying to production, which
gives a chance for issues to be caught before exposing end users to
those issues.

If the app breaks for end users, is that bad? How bad?

If you delete the production database, how do you recover?

So we can do any of the following:

 - Automatically deploy to production
 - Automatically deploy to a testing server
 - neither, both

It's also possible to have slighty complicated automatic rules.

Example:

 - If CI tests pass, deploy to test server.
 - After a release is deployed to the test server for 48 hours, deploy
   to production.

Rules like this are useful becuase they incentivize getting work done.
If manual testing was supposed to happen and didn't we know who to
yell at.

How?

Options:

 - Github actions
 - Fully custom script on server (maybe a good use of Python)

## Deploying with Github Actions

**First, a working deploy script**

Before we can deploy from a Github action, we need to figure out the
steps nessiary to deploy.

Testing from a local machine is easier than testing by repeatedly
tweaking a github actions config, so the first step is to get a deploy
script working from a local Linux environment:

 - Github acitons uses Ubuntu
 - You can locally install Ubuntu on your machine
 - You can run it in a VM
 - You can use WSL on Windows
 - You can try developing natively on Mac, but that will require understanding
   the differences between Mac and Linux.

My example today:

 - The jokes-rails app
 - We'll check out from the github repo for remote deployment.
   - This means we can't deploy local changes.
   - Which is preferable for our process.

Basic plan:

 - Our ship script copies a deploy script to the server and runs it there.
 - We'll be able to translate the ship script into a github actions script
   later.

**Problem: Secrets**

There are some things we don't want to store in our Git repository,
but do need in order to deploy or run our app.

To deploy our rails app, we have three secrets:

 - An SSH key to connect to the server for deployment.
 - An SSH key for the server to connect to the git repostory.
 - The ``secret_key_base`` value for Rails.

Rails provides a mechanism to store secrets encrypted in the
repository, which potentially reduces the number of secrets that need
to be tracked. We'll use this by copying the key over from dev machine
during inital deployment.

Github provides a mechanism for managing secrets which are used in
Github Actions. We're going to try to use that for our SSH key.

In this case I'm going to a single SSH key for both roles for
simplicity. This does have a slight security cost - if you're not sure
about the security impact, it'd probably be better to use two separate
keys.

**Problem: Prepping the Server**

 - node is installed through apt
 - ruby is not - want a newer version - so it's installed through asdf
   on the server app account

**Rails Deploy Script**

mostly useless refs: 

 - https://www.ralfebert.com/tutorials/rails-deployment/
 - https://gorails.com/deploy/ubuntu/22.04


I'm going to do this as a multi-stage deploy script. There will be
four seperate scripts:

 - ship.sh will trigger a deployment from a dev machine and will copy
   secrets over for future deployments.
 - deploy.sh will live on the server outside the git repo, and will
   fetch the latest git version
 - build.sh do the work to build the code from git
 - the Github Actions script will trigger a deployment from there

Demos:

 - Show all four scripts.
 - Explain that bin/ship.sh will deploy even without a github action.

**Setting Up a Deploy Action**

ref: [Secrets for Github Actions](
https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions)

ref: [Deploying with Github Actions](
https://docs.github.com/en/actions/deployment/about-deployments/deploying-with-github-actions)

Show the workflow file.

Demo it:

 - create a feature branch
 - change index text
 - show current index
 - PR
 - merge PR
 - show process
 - show updated app
