---
title: "cs4140 Notes: 11 We Have Customers"
date: "2023-09-21"
---

**Customers:**

Shawn Case, Math Prof [shawn.case@plymouth]

 - Something about an ice cream shop?
 - Multi-screen workflow, forms, database persistence.

Jason Charette, Political Science Prof [jason.charrette@plymouth]

 - Components of RISK-like games for in-classroom use.
 - Primarily single-screen, with light interaction / animation. 
 - Possible DB persistence: students / teams.

That's what they told me they wanted - they may tell you something different.

## Initial Customer Meeting

First, set up an in person meeting with the customer. 

 - No later than October 6th.
 - In person, no Zoom nonsense.
 - Customer and whole team.
 - In a room with a whiteboard.
 - Try to schedule an hour or so.

Meeting notes will be due with the Week 6 Team Report.

Outline the project constraints.

 - You're a small team.
 - You've got about 8 weeks to work on the project.
 - You'll be slowed down a little by process requirements.
 - So you'll be able to build something non-trivial, but not
   huge.
 - Start with the minimum version of the app that can be demoed.
   - i.e. One step past a web page with the words "coming soon".
 - Iterate into something more complicated.

Get the customer's description of the project.

 - Take notes.
 - Try to understand what they're describing.
 - Pay attention to clues from how they describe it and what they're
   assumptions are.

Ask questions in support of design:

 - Design from front to back end, UI focused.
 - Design from back to front end, DB-schema focused.
 - Draw / write one whiteboard. Use cell phone camera to save.

**Design from Screens**

What does the user see when they visit the app site?

What "screens" does the app have?

Example: Minimal Web Based Email Client

 - Login screen
   - A HTML form
   - Email, password, submit
   - Register link? Registration screen?
 - Message list screen
   - Table of messages by From and Subject
   - Clicking a message shows it
   - Folders?
 - Show message screen
   - From
   - Subject
   - Body
 - Compose message screen
   - Another HTML form
   - To
   - Subject
   - Body
   - Send Button

**Design from DB Schema**

What DB tables does the app have?

What are the relations between them?

Example: Minimal web-based email client

 - Users table
   - Email
   - Password hash
 - Messages table
   - Subject
   - To
   - From
   - Body
   - A message belongs to a user
   - Duplicates?
 - Folders table
   - A folder belongs to a user
   - A message belongs to a folder

**Where are we going?**

 - What does the minimum thing to demo look like?
 - What's the minimum viable product?
 - What to improve after that?
