---
title: "Notes: 34 Handoff Process"
date: "2023-11-19"
---

Final Presentations:

 - Our final exam block is Friday, December 15th, from 8-10:30am in this room.
 - We have two teams each giving 20 minute presentations, so I think we're safe
   starting at 9am.

Therefore:

 - Final presentations are On Friday, December 15th, from 9-10:30am.

The final presentation assignment is posted:

 - The assignment (and grading) is split into two parts: Team and Solo
 - For the solo portion you each person will take two minutes to present an
   interesting and challenging thing they did.


# Deployment Instructions

 - The README file in your repo should cover
 - Starting from a new Debian 12 VPS
 - How do you get a new instance of your app up and running

Example: Inkfish

 - https://github.com/NatTuck/inkfish
 - My README primarily has notes for setting up the dev environment
 - But we can figure out a sequence for a production setup

I spun up a new Debian 12 server on Linode yesterday and pointed a DNS
record at it: ironbeard.com

I recommend Linode for your customer's VPS. Why Linode?

 - Standard price for a 1GB VM: $5/month.
 - They offer a good backup service for an extra $2/month
   - 1 Daily + 2 Weekly Snapshots


Let's walk through the process of deploying, and see what would need to
go in a set of instructions.


# Details of the Handoff Process

**Customer Accounts**

The customer should have their own accounts for everything, and those
accounts should not be dependent on your accounts:

 - Github
 - Domain registrar
 - VPS provider

Making a new non-Fork Github repo:

 - Create new empty repo on the Customer account
 - Clone the existing repo to some machine
 - Delete the origin remote and add the new repo as the origin.
 
```bash
# The instructions that Github gives are almost good,
# just need to remove the existing origin first.
git remote remove origin
git remote add origin git@github.com:Customer/repo.git
git branch -M main
git push -u origin main
```

Once the customer has a non-fork repo, your team should rename their
repositories out of the way and fork the customer repository.

Domain registrar stuff to keep in mind:

 - A domain transfer can take a week
 - Requires access to both accounts
 - Make sure there's no "domain lock" enabled before attempting the
   transfer

VPS Provider:

 - Customer should make sure they are paying for the service personally.


**Customer Deployment**

Is this a clean deployment or a migration?

If migration:

 - You get easy mode on database migration - you can just
   stop the app service and copy over the DB file.
 - The DB is probably your only persistent state, but it's
   worth double checking that.

Either way:

 - Does any config stuff change?
 
 

