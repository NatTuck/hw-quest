---
title: "cs4140 Notes: 19 React, pt2"
date: "2024-10-08"
---

We've got a react component to load our invites and show
them.

Let's build a form to create new invites:

 - Need a select for user.
 - Need a select for event.
 - We need to preseed that data.
 - We need to send a POST request to the right path.
 - Once the item has been added, we need to either:
   - Fetch the list again.
   - Add our one new item to the list.

If all that works, next feature:

 - Introduce Phoenix Channels
 - Build per-event real-time ephemeral chat.
