---
title: "cs4140 Notes: 12 Phoenix Change Example"
date: "2024-09-18"
---

I've added all the deploy related files to the party animal repo:

https://github.com/NatTuck/party_animal


# Today: Add some more features

 * As a non-logged-in user, I shouldn't be able to create an event.
 * As a logged-in user, I should be able to create an event and it
   should be associated with my account.
 * As a user, the home page should show me events I've created, events
   I've been invited to, no other events, and a button to create an
   event.

# Today: Introducing testing

 * The auto-generated code has created some tests, and we've made some
   changes since. Let's get our tests up to date with our app
   functionality.
 * Every story we implement should have at least one automated test
   that confirms that we've done something (at least if possible).
