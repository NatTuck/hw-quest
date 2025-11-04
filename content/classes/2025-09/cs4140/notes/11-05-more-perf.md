---
title: "cs4140 Notes: 11-05 More Perf"
date: "2025-11-03"
---

## Measuring page load time

Examples:

- Show <https://homework.quest/> (Simple-ish static page; best case)
- Show <https://inkfish.homework.quest/> (Not as optimized)

Tools:

- Render time: Network tab in Firefox or Chrome dev tools.
  - Note the "Disable cache" button.
  - Note DOMContentLoaded time.
- Raw response time: <https://tools.keycdn.com>
  - TTFB is Time to First Byte (in response)
  - Multiple locations
- Google Pagespeed: <https://pagespeed.web.dev/>

Links:

- Windows TCP algo: <https://en.wikipedia.org/wiki/Compound_TCP>
- Linux TCP algo: <https://en.wikipedia.org/wiki/CUBIC_TCP>

# In-browser Performance

Two issues:

- JS execution time during page load
- Performance of long-running JS

This is a standard code optimization issue.

JS execution during page load is usually only an issue with very
inefficient code.

For long-running code in browser, suggestions:

- Try to avoid CPU heavy stuff; you can do a lot with just
   fast-running event handlers.
- If you have heavy JS code, make sure to test on the lowest-specced
   machine you'll be running on.
- Keep in mind that phones can be much slower than a development
   laptop.

If nessisary, it's possible to get really crazy with things like Web
Assembly, web workers, or WebGPU.

# Server response time

Your app server needs to take an HTTP request as input and send the
appropriate HTTP response. If that's just filling in a template, it's
reasonable for it to take a couple of microseconds.

Things slow down when your app server depends on external resources:

- Even a fast DB request can take 100 microseconds.
- Frequently applications are designed to make requests to external
   HTTP APIs; making multiple HTTP requests can slow things down fast.
- There end up being tradeoffs between raw speed and scalability in
   the presence of various forms of shared state.

The thing that makes server performance complicated is that servers
need to handle multiple concurrent requests.

- A fast DB query might take 100 microseconds.
- A slow one might take a full second.
- What happens if the request that depends on the fast query comes in
   after the slow query already started?
