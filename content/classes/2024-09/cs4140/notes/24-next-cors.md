---
title: "cs4140 Notes: 24 Next and CORS"
date: "2024-10-20"
---

Today I'm going to look at an alternate structure for a web app that's
occasionally useful.

This especially applies to the Podcast app, and shouldn't be as
critical for the other two teams. It's still basic web dev stuff that
everyone should have heard of.

## Basic concept

 - App is split into two parts: A Single Page Application front-end
   (typically primarily in JavaScript) and a back end that primarily
   provides a REST API.
 - These two parts can be managed as two seperate code projects.

TODO demo:

 - Create new Phoenix app.
   - Do mix phx.gen.auth
   - Create a tasks API resource that belongs_to user
   - Put it in the API 
 - Create new Next app.
   - We're back to flowbite-react 
   - Create a quick form.
   - Make it use the API

Problem: Same-origin policy

 - By default, JS code can only send "complex" requests and
   see the response to URLs with the same origin.
 - Same origin means same (protocol, host, port).
 - A complex request isn't simple. A simple request is
   a GET or POST request with basically no custom headers.
 - For a complex cross-origin request, the browser first
   sends a "preflight" OPTIONS request.
 - If the server sends a response that approves the request,
   the browser will allow it.
 - Doing this preflight/response thing is called CORS, or
   cross-origin resource sharing.

To enable CORS from Phoenix: https://hexdocs.pm/cors_plug/readme.html


Problem: Authentication

 - Using cross-origin cookies for authentication is a bad idea because:
   - It enables XSRF attacks
   - It gives you less control than the alternative
 - Solution: Explicit access tokens
   - Login form, sends to new session API.
   - Sends back Phoenix Token
   - Authenticated requests send an x-auth header with the token.
   - Without Phoenix, the typical token standard would be JWT

 
