---
title: "cs4140 Notes: 08-02 Web Dev"
date: "2026-08-31"
---

## Web Development

Initial concept:

- Web pages / web sites.
- Server just sends files via HTTP protocol.
- Browser displays non-interactive pages.

Expansions:

- Multimedia
- JavaScript
- The server doesn't need to just send files.
- The client doesn't need to be a browser.

Observations:

- Browsers natively run JavaScript. So writing in-browser code in JS
is easiest.
- Server code runs on our server and just needs to output valid HTTP,
HTML, etc. So it can be any language, although FORTRAN is probably wrong.

## A Multi-Player Web Game

Two separate computer programs:

- A "client", with code that runs in the browser on the user's device.
- A "server", with code that runs on a computer acting as a (hardware) server.
Preferably connected to the internet 24/7 with a public IP, typically in a
data center.

For a single-player game, we might be able to write only the browser code. For a
multi-player game, we need to manage logic outside of one user's browser tab.

Let's look at the example, BotBash:

- This is a webapp using the Vite dev environment and a bunch of standard JS
(or, in this case, TS) frontend libraries. 
- It's also a server-side TS app using the Express web server.


## Browser Logic

- It's a webpage. Start at index.html
- src/main.tsx
  - Typescript, embedded XML
  - Modern JS style modules
- src/App.tsx
  - Three routes, three different screens.
- src/routes/Login.tsx
  - Two kinds of state
  - Component state (useState, local to component)
  - Store state (useGameStore, global to the browser tab)
  - One more: localStorage (survives if tab is closed, specific to site hostname)
  - emitLogin: Sends message to server, calls function on reply.

Let take a look at the server and see where that emitLogin goes.

## Server logic

- It's a node app. Starts at server/index.ts
- In server/index.ts, we handle three different things (kinds of request):
  - GET / needs to send the Vite browser code so the user/browser can run their side of
  the app.
  - GET /api/... needs to call API handlers. We aren't using that much.
  - We create and handle websocket connections, which is how most of the
  browser<->server communication works.
- Most of the logic is in server/sockets.ts
  - emitLogin is handled by on("connection") ... on("login")
  - It calls getOrCreatePlayer
  - That modifies "state"
  - Which came from state.tsx
- state.tsx
  - Just defines one global variable, with a list of players and a map of games.

## Let's think about game state a bit:

- Every game has one current state:
  - Each player's game board
  - Each player's hand
  - Each player's deck
  - The scrap pile
- Some of that information is known to everyone (the board)
- Some of that information is known only to one player (their hand)
- Some of that information exists, but is known exactly by neither player (the
shuffled decks)

We have code running in three places:

- The server
- Player A's browser
- Player B's browser

A browser runs on a user's computer. Innately, that means that they get to
decide what it actually does. If we send secret info (e.g. opponent's hand) to
the browser and then have our code hide that from the user, the user can just
edit the code and see the info. 

In contrast, for a deployed web app, the server code runs on a server controlled
by the developers. That means we can trust that the code we write for the server
is the code that runs on the server.

So: 

- The server can know the full current state.
- Each browser must only be sent a restricted view of that state, with only
the information that we intend to reveal to the corresponding player.
- The server is the single source of truth. The players send updates to the
server and get back new views.

## State management is the key question of software design

- What data do we need to track?
- Where does that data need to be?
- If there are multiple copies / views of the data, which one is correct?
- If more than one is (or could be) correct in a way that could lead to
conflicts, then you need to do conflict resolution. May the odds be ever in your
favor.

## Core problems with Bot Bash

There's lots of things wrong with Bot Bash. But what I want to complain about,
and what I want you to think about when working both on Bot Bash and your
project are:

- Game state lives in a single, shared variable in the server process. If the
server dies it's gone, when the server restarts, we start over.
- Game state lives in a single, shared variable in the server process. If two
games update their states, they're updating (different keys) in the same single
Map object. It should work, but it's ugly for both performance and isolation.

We should add:

- A database, for persistent state. This is straightforward.
- A mechanism to isolate separate games. This is transient shared state, which
JS servers are bad at. We either want to pull in something like redis, or switch
to a backend platform that's good at this (I like elixir / the beam).

## More topic

- How to use OpenCode to explore a codebase.
- How to add a card.
