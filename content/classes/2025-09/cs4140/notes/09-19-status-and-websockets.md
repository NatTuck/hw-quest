---
title: "cs4140 Notes: 09-19 Status, Websockets"
date: "2025-09-17"
---

**Deploy The Latest Thing**

- Deploy the latest main on shard.homework.quest
- Try to log in and try new functionality to bump stuff to
  done.



**Concepts: Statefullness, Cookies, Channels, LiveViews**


Stateless protocol:

- HTTP 1.0 was stateless
- No way to tell if two requests were from the same user.
- Idea: Unique session ID in every link.

Cookies:

- HTTP 1.1 added cookies, which let sessions be maintained
  across requests.
- Mechanism: Server sends a "set-cookie" header, browser sends
  back a "cookie" header with the same content.
- This adds state in the browser.

Server-side statelessness:

- Web apps are typically written to be stateless on the server,
  except for a database.
- That allows requests to be handled by separate processes or
  threads without worrying about locks / shared memory.
- A request spawns a new handling thread, the thread processes
  that request sequentially, then the thread terminates after
  sending the response.

AJAX / fetch:

- JavaScript in the browser can send HTTP requests without
  triggering a page reload.
- This is very powerful combined with in-brower rendering and
  partial page updates like with React.
- Problem: The server can't send a response without getting
  a request.

Channels:

- Websockets allow for a persistent, bidirectional connection
  between a browser and the server.
- This requires some longer-term server state.
- Phoenix Channels handle this nicely (demo).

LiveViews:

- Run an elixir process on the server as long as a page is open
  in the browser, hooked up by a channel.
- Send events to the server, do partial re-renders server side,
  send diffs to the browser.
- This is obviously a bad idea, but internet connections are frequently so fast
  and reliable that it works great.



