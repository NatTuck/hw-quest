---
title: "cs4140 Notes: 08-03 Elixir and Basic Design"
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

## Game Design

Let's pull up [genesismud.org](genesismud.org).

- This is a traditional mud.
- The game style predates the web. 
- This one has been around for 30 years.
- When it first launched, you connected with telnet; you probably still can.

Basics:

- Rooms
- Textual descriptions
- Exits
- Automatic mapping
- Interacting with items
- Mobs: Attacks, stats
- Textual commands

Compare to an MMO, like WoW:

- View world directly.
- Continuous position rather than rooms, but still have zones and
  instances.
- Interface provides direct keybinds / on screen buttons for
  movement and actions.
- Text interface is retained for chat and some special commands.

Improvements for a web-native MUD:

- We can have a screen per room. Start with text desciptions,
  maybe add AI generated illustrations.
- We can expose actions directly with buttons and keybinds.
  - Full text commands can be optionally retained, especially for
    "secrets".
- UI and gameplay in general should end up as a mix between a classic
  MUD and a more modern multiplyer RPG.

Basic data design:

- Do you log in as a character, or as a user with potentially
  multiple characters.
- Rooms are the basic world element. Grouped into zones?
- Characters / Mobs
- Items

State:

- What data needs to survive a server reboot? That goes in the DB.
- What data can be transient? We have other ways of handling that.
- What data gets sent to the client? What data is stored on the client?

That's complicated. What's the simplest reasonable version of this
we can build to start with?



