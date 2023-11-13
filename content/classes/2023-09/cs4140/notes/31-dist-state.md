---
title: "Notes: 31 Distributed State"
date: "2023-11-12"
---

## Byzantine Generals

Let's say Byzantium having a war with Persia.

Four Byzantine Generals, each leading an army of 10 thousand men, have
surrounded a Persian army of 30,000.

If the four Generals attack at the same time, they'll probably win. If
3/4 attack, it's an even fight. If less than 3/4 attack, the Persians
will probably win. So if any single general thinks that all the other
generals won't attack, he's probably best off not attacking so his troops won't 

The ranking general plans to attack at dawn. He sends a messenger to
each of the other generals detailing his plan. Dawn comes. 

 - Should he attack?
 - What if a messenger was killed? Two messengers?

Ok, new plan.

 - The head general sends a messenger to each of the other generals with
   instructions to attack at dawn and to send a return messenger
   confirming that the message got through.
 - He gets back a confirmation from each other general.
 - Should he attack?
 - Should General #2 attack? What if a confirmation messenger was killed?

Solution: Three-way Handshake

 - command 1 -> 2
 - confirm 2 -> 1
 - ackconf 1 -> 2
 - request resends if you don't get expected messages
 - Once the last message has been recieved and it's been a reasonable
   amount of time without a resend request, both parties can be pretty sure
   the command has been recieved and acknowledged

Now let's make it worse:

 - There are only 20,000 Persians.
 - You are General #2.
 - You recieve a message from General #1, saying "I propose we attack
   at dawn as long as 3/4 of us agree."
 - Is there some series of messages that the generals can send each other
   to try to get agreement from 3/4?
 
Now let's make it even worse:

 - What if one of the Generals has been bribed by the Persians to not
   attack himself but to try to get exactly two other generals to attack.

Conclusions:

 - In the general case, forming distributed consensus is impossible.
 - With some constraints and assumptions, it's possible to form a
   useful distributed consensus in practice.
 - But the possibility of lying traitors makes it difficult.

refs: 

 - https://lamport.azurewebsites.net/pubs/byz.pdf
 - https://www.youtube.com/watch?v=vYp4LYbnnW8

## Why do we care about Byzantine Generals?

Every web application is:

 - A distributed system.
 - With at least one untrusted node.

We don't usually have exactly one of the Byzantine Generals scenarios,
but we've got a bunch of other scenarios with similar concerns.

Let's look at an example problem:


**Online Slot Machine**

App server stores:

 - User's token balance
 - Slot machine jackpot quantity
 - Result of latest spin

Browser stores:

 - User's token balance
 - Slot machine jackpot quantity
 - Current visual / interactive state of machine:
   - Between spins
   - Wheel positions
   - Result

Concepts:

 - App server is in charge.
   - Browser is untrusted
   - We don't want it changing token balances 
   - We don't want it picking play results
 - Single source of truth: App Server
   - Significant data on client is a copy of server data.
   - Browser token balance / jackpot quantity never update locally, only as
     a push from the app server
   - Any other data on client is not significant (e.g. visual position of
     slot machine wheel)

What if app server goes down? 

 - App doesn't work.
 - There's no way to allow spins without the server.


**Online Poker Game**

Hold'em, obviously. 

App server stores:

 - Deck order
 - Hole cards for each player
 - Shared cards

Browsers store:

 - Hole cards for current player
 - Shared cards

Again, no local updates - the data in the browser is basically a cache of
data on the server for ease of rendering. Actions go to the server, update messages
come back to the browser.

Note that you can build distributed p2p poker: 
https://crypto.stanford.edu/~pgolle/papers/poker.pdf


**Online Store + Cart**

App server stores:

 - Products (name, description, price)
 - Stock levels

Let's try storing shopping carts in the browser, in a single-page app.

Browser stores:

 - Cache of product info, stock levels.
 - Shopping cart.

... TODO: Think through implications more

**Rules of Thumb for Browser State**

 - Make state explicit. Using tools like React's ```useState``` make state in
   your app really obvious, which helps avoid bugs.
 - Have a single source of local truth. You don't want to store the same information
   in two places because
   
