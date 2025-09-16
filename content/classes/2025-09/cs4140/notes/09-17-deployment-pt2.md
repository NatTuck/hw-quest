---
title: "cs4140 Notes: 09-17 Deployment, pt2"
date: "2025-09-15"
---

**Deploying Shard**

There are good docs covering some core deployment issues at:
https://hexdocs.pm/phoenix/deployment.html

Deployment checklist:

- Debian or Ubuntu VPS with sufficient RAM and swap.
- DNS hostname pointed to server.
- System user account for app.
- Build deps installed on build machine.
  - Simplest: Build machine is target machine.
  - That means asdf, erlang, elixir, nodejs.
- Figure out env variables:
  - Port
  - Secrets
- Build / deploy script.
- Systemd service file.
- Nginx config file.

**Continuous Deployment**

When tests pass, we'd like to auto-deploy.

How can we do that with like 10 servers run by different people?
