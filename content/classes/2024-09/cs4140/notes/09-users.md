---
title: "cs4140 Notes: 09 Add Users"
date: "2024-09-13"
---

## Adding More Features to Party Animal

 - Feature: Users
   - Add a Taiga story
     - Basic story layout
     - Users are externally identified by email address.
   - Use ```mix phx.gen.auth```
     - We'll use --no-live for a traditional web UI.
   - Add a migration to add ```user_id``` to the event.
 - Feature: Invites
   - Add a Taiga story
     - Specify fields: title, date, location, description. 
   - Scaffold it.
   - Etc.
 - Start doing workflow testing.
   - Generate new stories to fix the workflows.
   - Think about the workflow of users who recieve an invite.
   - Realize we need responses.
   - Generate lots of stories.

## Stories for Bad Date

 - As a user, I should be able to sign up.
   - Simple traits: Gender, Looking for gender, Birth Date, Zip Code
 - As a user, I should be able to see matches.
   - Matches should match the simple traits (requsted gender, +/- 5
     years, within 100 miles)
 - What other data do we need to collect to be able to optimize for bad matches
   while satisfying the simple traits?

Resources:

 - https://simplemaps.com/data/us-zips

