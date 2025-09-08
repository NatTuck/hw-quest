---
title: "cs4140 Notes: 09-08 Elixir and Phoenix"
date: "2025-09-06"
---

## Really quick rundown of Elixir

- start with `mix new demo`
- A collection of modules, typically one per file.
- Each module has functions.
  - Show syntax, including exprs and implicit returns.
  - Show pattern matching
- Language is impurely functional: No mutation, but side effects
  are allowed.
- No mutation forces explicit state management. That's a good thing
  for reliability when stuff might break.
- Compiled like Java.
- .exs scripts


## Quick Run through Phoenix Structure

(Shard)

- App starts at application.ex, that launches endpoint, which does HTTP
- Remember: HTTP Request -> Processing -> HTTP Response
- %Conn{} structure
- Router
- Controller
- Template

(Pull up Inkfish)

- Contexts


## Resources and Generators

(shard - add-goats branch)

- Run ```mix phx.gen.html``` to show help.
- Create resource: ```mix phx.gen.html Goats Goat goats name:string color:string  number_of_horns:integer```
- Open ```...create_goats.exs``` to fix schema.
  - Name and color are ```null: false```
  - Number of horns is `default: 2`
- Add to router.
- Run migration.
- Show the /goats path and the CRUD interface.


## Add Users

(story)

```
As a user
I want to be able register and log in
So I can do stuff specific to my user account

Acceptance: Users can register and log in.
```


(shard - add-users branch)

Run ```mix phx.gen.auth``` to show help.


