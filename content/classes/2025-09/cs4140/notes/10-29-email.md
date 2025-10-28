---
title: "cs4140 Notes: 10-29 Email Fun"
date: "2025-10-27"
---

## Self-Hosting Email

Conceptually email should be easy:

- Install a mail server.
- Use SMTP to send mail, which your local server will relay
  to the correct destination server, which will then deliver
  to the recipient.

Problem: Spam

- Because any machine on the internet can conceptually send email,
  obnoxious people do a lot of it.
- This means that receiving mail servers don't accept all mail.

How mail servers decide whether to accept email.

- Protocol compliance checks.
- Check against "realtime blackhole lists".
- Sender policy framework: Confirm email isn't forged by checking
  sender address DNS for allowed sending servers.
- DKIM: Similar to SPF, but with cryptographic signatures.
- DMARC: Another DNS sender policy rule.
- Other domain / IP reputation rules.
- Content-based spam filtering.

Setting up everything so major providers will accept email is annoying.

- I host my own email with all of this set up correctly.
- My emails still regularly get spam foldered, especially for people
  I haven't corresponded with much.

The hardest part is domain/IP reputation and detecting and fixing when things go
wrong, which can require having staff to directly interact with large providers
and reputation services.

## Email-by API

Even though self-hosting email should be straightforward, there's a service to
sell of having someone else deal with verifying all the configuration is
correct and maintaining reputations.

There used to be a couple of decent free providers, but most of them have gotten
big enough that they don't want to deal with it anymore.

When I looked at setting up authentication links for Inkfish, and didn't want to
argue with ET&S about outgoing email, I set up Mailjet.

Mailjet free tier limits:

- 6000 emails / month
- 200 emails / day
- 1000 contacts

That's tight, but it's enough for very low volume uses like registration links
for apps with less than a hundred users.

So let's try to set it up for Shard.

Account settings:

- Sender address and domain: already set up for homework.quest
- Note the required records for SPF/DKIM - you need to configure
  these in your DNS settings for your domain to work.

API Key management:

- I'm not allowed a second key, I'll steal the Inkfish one.

Let's look at integrating with Shard.

- Remember to pull and feature branch.
- Swoosh Docs: <https://hexdocs.pm/swoosh/Swoosh.Adapters.Mailjet.html>
- Note all the providers.
- Set up MAILJET_KEY in prod-env.sh
- Also, mail from and make sure that's hooked up correctly. Needs to
  match sender address in Mailjet web UI.
- Might as well set up OPENROUTER while we're in here.
- Docs should be fine, but we can fall back to Inkfish otherwise.
