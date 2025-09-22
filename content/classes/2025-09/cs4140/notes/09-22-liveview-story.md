---
title: "cs4140 Notes: 09-12 LiveView Story"
date: "2025-09-20"
---

**Do A Real Deploy**

- Deploy the latest main on shard.homework.quest.
- Try to log in.


**Form -> LiveView Demo**

(demo was started with)

```
mix phx.new lvdemo --database sqlite3
cd lvdemo
mix ecto.setup
```

Let's look at the demo app from the scratch repo.


**Part 1: A Form**

In router:

- Path "/form" has a route for both get and post.
- We submit a form, the server can re-render the page.


**Part 2: A GenServer**

- CommentServer
- Note that it needs to get started from Application
- Demo it with `iex -S mix`

**Part 3: A Channel + JS**

- chan.html.heex
- comment_channel.js (user socket, app.js, etc)

**Part 4: A LiveView**

- Template, similar to a "dead view".
- Associated elixir module with callbacks.
- There's an implicit channel (which is a GenServer) here.
  - Page on client is kept in sync with state on server.
- We're using a .form / .input setup, which would be typical
  for a deadview too (e.g. it handles _csrf_token).
