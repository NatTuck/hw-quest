---
title: "Notes: 27 Fetch and Websockets"
date: "2023-10-31"
---

**Monitoring:**

Plan A:

 - Add a monitoring VPS
 - Have it periodically (i.e. every minute) poll your app.
 - If it detects a failure, have it send you a message:
   - Email
   - Text via service like Twilio
   - IM via some protocol like XMPP or through an API

Plan B:

 - Get a service
 - Let's look at https://uptimerobot.com/pricing/

**Async Requests**

 - Easiest way to communicate with server is full page load.
 - But we already did an async request once.
   - See components/delete_joke.js in jokes-next

Common pattern is a REST API:

 - You have a resource, e.g. jokes
 - You have operations on that resource: list, create, get, update, delete
   - GET /jokes
   - POST /jokes
   - GET /jokes/4
   - PATCH /jokes/4
   - DELETE /jokes/4

**React Server Actions**

https://nextjs.org/blog/next-14#forms-and-mutations

This appears to be implmented like it's setting up API paths
implicitly and then accessing them with fetch, but from a programmer
perspective it feels like you can have code running in a mix between
the server and the browser.

I'm not sure this is a good idea in general, but it might be useful
for simple scenarios.

## Websockets

ssh nat@homework.quest; sudo su - draw; (cd draw && ./start.sh)

Pull up https://draw.homework.quest/


HTTP is a request-response API is built on TCP, which is a stream API.

Websockets is a way to "upgrade" an HTTP connection into a stream.

Why?

 - Jerk IT people like to block ports; and they tend to block by default.
 - Some of them even protocol sniff and block unknown protocols.
 - So practically, everything needs to pretend to be HTTP
 - With HTTPS, the jerk move of blocking everything by default has lost
   administrators the option of controlling traffic at all.

Wait, no, why?

 - Browser code can open an HTTP connection to the server whenever, but
   typically the server can't initiate messages to the browser.
 - When a Websocket is open, either end can send a message at any time.

Rails

 - Action Cable

NodeJS

 - Socket.io

Basic concept:

 - Your base level application router needs to have a path that does
   an upgrade and then handles socket logic.
 - This doesn't work like HTTP normal requests - it requires a persistent
   connections - which is tricky for app structures that assumed stateless
   and fast HTTP requests.

Let's walk through how the draw app works.

