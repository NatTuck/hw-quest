---
title: "cs4140 Notes: 31 Production Deployment"
date: "2024-11-05"
---

**Production Deployment for Phoenix**

Docs: https://hexdocs.pm/phoenix/deployment.html

Why:

 - Want optimizations on.
 - Debug messages aren't shown, which is nessary because
   they're designed to assume they don't need to worry about
   security issues.
 - Need to manage app secrets.

Secrets:

 - There is some data your app needs to know, but that you need
   the rest of the world to not know.
 - Every Phoenix app has a secret encryption key, used primarily
   for signing tokens for authentication and XSS protection.
 - Other potential secrets: DB pass, API tokens

Handling secrets:

 - In a modern Phoenix app, secrets are typically handled as environment
   variables.
 - A simple way to deal with this is to set them in a ~/prod-env.sh script
   which is sourced from your start script.
 - Files with secrets in them *must not* be checked into version
   control. Putting an API key in your public git repo can be like
   giving your credit card to your teenage cousin and telling them to
   "go nuts" with it.

Releases:

 - Erlang provides a mechanism to bundle up your app and Erlang (and
   Elixir) deps as well as Erlang and Elixir themselves into a tarball
 - This is really useful for automated deployments. Most obviously, it
   means you don't need to worry about getting the language versions
   wrong on the server.
 - Releases don't bundle system deps, so you still need to run a
   release on the same OS version with the same system packages (e.g.
   apt-get) as the release was built on.
 - You can build the release in a docker container that matches your
   deploy server.

Problem:

 - The source code isn't available if you deploy only with releases.
 - This means you can't run migrations with mix, without adding a feature
   to the relased app to do it.
 
See docs:  https://hexdocs.pm/phoenix/releases.html


Let's run through those docs. Then sanity check with the Inkfish deploy script.


**Production deployment for NextJS**

Docs: https://nextjs.org/docs/pages/building-your-application/deploying

("A Node.js Server" is the relevent section for a VPS deployment.)





