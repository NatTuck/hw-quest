---
title: "cs4140 Notes: 08-03 Web Dev"
date: "2025-09-01"
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


## Elixir and Phoenix

What makes a good server-side language:

- Fast I/O.
- Good error handling.
- Handles concurrency well.

**Elixir**

Elixir runs on the Erlang VM. Erlang was designed for telecom switches,
where the goal was zero downtime. To get zero downtime in the face of hardware
failure, you need redundant hardware. That means the software has to deal
with being a distributed system.

All of that's good for web apps, especially ones with real time communication.

## Let's Run Our New App

**Setting Up Deps**

- Our app uses a PostgreSQL DB, which is a sane modern default for a
  RDBMS.
- But it takes a little bit of setup.
- Let's do that - see the REAMDE for he pg-dev-db branch.
  - Install a bunch of deps.
  - Install Erlang / Elixir / NodeJS with ASDF.
  - Enable pg localhost connections with password auth.
  - Create the pg user.
- Then we can do `mix ecto.setup` to create our DB.
- And `mix test` will work.

