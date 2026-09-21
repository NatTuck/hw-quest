---
title: "cs4140 Notes: 09-21 Database"
date: "2026-09-18"
---

## Database Schemas and CRUD

We talked about 4 kinds of state previously:

- Browser, Transient (e.g. React useState, browser JS vars)
- Browser, Persistent (localStorage)
- Server, Transient (e.g. server vars)
- Server, Persistent (database or files)

For your farm game, a significant amount of your application state is that last
category, and a lot of looks like conventional database records.

You're going to want user accounts, and they'll want to have the normal
properties that user accounts typically have.

Today, I want to design and build a quick game that has a bunch of the same
problems.

## The game: Clickboard

- Create a user account
- You get a button
- Clicking the button gets you a point
- There's a realtime leaderboard

We're going to build this entirely with
server-side persistent DB state.

## OpenCode

- Show openrouter
- Show local model Qwen 3.8

## Elixir / Phoenix

- Botbash was built on the simplest / most common web dev stack.
  - Need JS in browser.
  - Code on server can be JS/TS too, therefore it should be because then we only
  have one language.
  - So we use express for the server.
- We don't need to run JS on the server. We can run whatever toolchain we want,
  as long as it can be an HTTP server.
- So I'm going to do this demo with my personal favorite stack: Elixir/Phoenix
  - It gives good tools for database handling (migrations, schemas, etc)
  - It gives exceptional tools for efficiently managing transient server state
  while scaling to many users.

Steps:

- Set up deps.
- Create app.
- Mix phx.gen.auth
- Create schema and scaffolding for each table.
- Set up channel + react.


