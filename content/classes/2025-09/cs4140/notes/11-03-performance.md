---
title: "cs4140 Notes: 11-03 Performance"
date: "2024-11-01"
---

## Prologue: Midterm Reports

- Nobody's claiming to be entirely comfortable with Elixir.
- The maximum anyone's claimed to spend on OpenRouter credits is $55. That's a
little crazy - I don't think I spent that much over the summer when I wrote a
bunch of programs and a 30 page novella with it.
- A couple students have spent $0 on OpenRouter. That's probably a mistake both
educationally and for productivity. If nothing else Aider is great for puking up
boilerplate tests.
- A couple of students have spent less than $5 and are doing great with free
models.
- Only two students seem to think that 4 hours studying elixir would pay for
itself in time over the rest of the semester. I need to do a lecture on the
studies about the illusion of LLM-assisted coding productivity.
- There's a correlation between money spent and features completed, but only in
that productive students are making good use of Aider. Among productive
students, some are making much more price-efficient use of API calls.
- Got a bunch of good lecture topic recommendations. I definitely want to do
some of them.

## Today: Performance

When looking at app performance, we can consider three or four issues:

- Page load time
- In-browser peformance (first render; interactive stuff)
- Server response time (network; compute time)
- Scaling with load (more next lecture)

# Page Load Time

When a user visits your site, how long does it take to load:

- Landing page
- Heaviest page
- First load vs. cached

Let's assume someone clicked a link to your app (from search, blog
post, or something). If the landing page takes

- 0.2 seconds, that's a noticble delay but still feels fast
- 1 second, that's kind of slow
- 5 seconds, the user may close the tab and do something else instead
   without ever seeing your site

Loading screens:

- For some kinds of app, you can get away with a loading screen / progress bar.
- The loading screen itself needs to load fast.
- It might slow down the user from giving up to 15 seconds instead of 5 seconds.

Conceputalizing page load time:

- Time zero: User clicks link
- DNS request/response: This is UDP, and takes one RTT
- HTTP request for HTML document: ...
- More HTTP requests for CSS, JS, images, etc.

HTTP happens over TCP, so it matters how a TCP request works.

**Quick Review of TCP**

- TCP is a connection-oriented, reliable network protocol.
- So a connection needs to be set up before messages can be sent.
- Once a connection is established, it acts like an in-order stream
   in each direction.

Setup: Three-way Handshake

- SYN: client -> server
- SYN/ACK: server -> client
- ACK: client -> server
- Client can start sending after first ACK, so setup takes one RTT

Slow-start:

- When a connection is established, the ends don't know how fast
   the network connection is.
- If they send too much data at once, it'll get dropped and the whole
   works will be clogged up with resends.
- So they start by guessing a small "window size" (e.g. 16k -
   although modern systems may use bigger values), and then sending
   that much data at once.
- When a full window worth of sent data is acknowledged, then the
   window size is doubled for the next batch of data.
- When packets start getting dropped, the window size is cut in half,
   and is increased linearly from there to find the optimal
   transmission rate.

Conclusions:

- Sending even one byte of data over TCP requires 2 RTTs.
- Sending more than the default window size requires at least 3 RTTs.
- Only sometime after that does link speed matter.

**Physical Layer Considerations**

- The physical layer (e.g. Ethernet or WiFi) can matter too.
- Typically, Ethernet packets are 1560 bytes.
- Taking overheads into account, messages under 1k will be
   as fast as anything can be.

**How to Optimize for TCP**

- HTTP requests for pages (GETs) are small enough.
- Optimally, HTTP responses should be under 16k.
  - Up to ~100k or so, power of two thresholds matter more than exact size.
- Once the browser knows what to get, it can request multiple things
   in parallel.
  - For HTTP/1.1, typically up to 6 per hostname.
  - Yes, that means that using multple hostnames can sometimes be an
     optimization.
- Browsers can parse partial HTML documents, so it matters where in the
   initial HTML document external resources are referenced.

Concrete points:

- Mandatory resources should be referenced in the first 16kB of the HTML.
  - Even better would be the first 1k, but definitely no benefit to going
     smaller than that.
- We'd like everything to be as small as possible.
  - Shrinking from 1MB to 100k matters because of connection speed.
  - Shrinking from 100k to 10k matters because of RTTs during TCP slow start.
- Doing stuff like splitting JS into smaller files can matter if we can get our
   mandatory assets down to fewer than 6 files each smaller than ~50k.

**Optimizing Later Page Loads**

For our initial page load, we're limited by physics and protocal
constraints.

After that intitial page load, we can do lots of stuff to speed things up.

- First page bundle vs. full app bundle.
- Preloading for later pages.

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
