---
title: "cs4140 Notes: 09-15 Deployment"
date: "2025-09-13"
---

**Background**

Unless you're developing an app just for your own personal use, you need to
somehow make it accessible to other people.

This is really straightforward for web apps: Just deploy it to a server.

A couple issues:

- You need a server.
- You need a public host name.

Finding a virtual server:

- Well known commodity providers:
  - Linode, DigitalOcean, Vultr, etc.
  - Standard price: 2GB of RAM = $12/month
- Big Cloud Providers:
  - Note: These tend to be more expensive and more complicated than the
    VPS providers, while trying to upsell you nonsense.
  - These are not recommended for this class, unless you can get a free
    Oracle ARM VM working.
  - Amazon (Lightsail), Azure, Oracle, Google, etc.
- Discount VPS Providers:
  - ovhcloud.com (8GB of RAM = $5/month)
  - https://www.racknerd.com/BlackFriday/ (2.5GB of RAM = $20/year)
  - https://lowendtalk.com/ (A forum full of ads)

Finding a public host name:

- I use joker.com for domain registration.
- Other vendors exist: 
  - GoDaddy is unreliable.
  - Probably tucows (hover.com) is good.
  - Using your hosting provider or a big cloud provider as your registrar
    risks lock-in.


I've got a RackNerd server with a hostname pointed at it:

- ettin.homework.quest

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

How can we do that with like 10 servers?
