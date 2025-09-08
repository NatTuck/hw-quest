---
title: "cs4140 Notes: 09-05 Basic Game Design"
date: "2025-09-02"
---

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

