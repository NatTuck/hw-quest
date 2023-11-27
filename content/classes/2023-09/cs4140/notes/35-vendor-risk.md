---
title: "Notes: 35 Vendor Risk"
date: "2023-11-19"
---

Today's report:

 - You should have setup docs.

Next week's report:

 - Each team member should spin up a VPS and
   do a test deploy.
 - You can use subdomains for this, or separate domains
   per user.
 - Should work with customer to get customer accounts set up
   and start work towards customer deployment.

Disclaimer: 

 - Today's story involves controversial politics.
 - The point is to describe political risks to app development, not
   to endorse any particular political factions.
   - I do have a political bias here: against large vendors,
     especially when they abuse their ologopoly power.

**Example 1: Parler**

Background:

 - New social network site / app founded in 2018: Parler [1]
 - Promoted as a Twitter clone for political conservatives
 - By 2020, had become popular for a niche social app, and was used by
   prominent Republican politicans (e.g. Ted Cruz)
 - January 6th 2021: Parler is widely reported in the press as being
   having been an organization point for the election riot at the capital
   building.
 - Soon there were widespread calls for the Parler app to be shut down,
   including by its service providers.

Service provider shutdowns, mostly on Jan 9th:

 - Google and Apple remove Parler from mobile app stores.
   - "Lack of moderation policies and enforcement"
   - "Objectionable content"
 - Twilio ended service, breaking SMS 2FA
 - ScyllaDB ended service (SaaS DB)
 - Then Amazon AWS ended service

With that, Parler was down. It basically stayed down until April, and even
though it came back temporarily, it never really recovered.

Some observations here:

 - Google + Apple is approximately 100% of mobile app distribution.
   - Apple doesn't allow sideloading, so an iOS app that isn't on the App Store
     is SOL.
   - Sideloading is possible on Android, but probably not viable as a mass
     market strategy.
   - Epic Games sued both Apple and Google [2] in 2020/2021 for
     anticompeditve practices because they don't want to pay a 30% cut
     on in-app purchases. These suits are ongoing.
   - The EU may force Apple to allow sideloading [3] starting next
     year, but that may only effect Europe.
 - Parler was built specifically for the AWS platform. When Amazon ditched them,
   they needed to do a pretty serious rewrite to run anywhere else.
 - Actions by smaller service providers can still be distruptive if your app
   depends on them.
 - Any one of these vendor cancellations would have been seriously disruptive. 

How should we look at this:

 - The broader political questions are interesting, but that's not my point today.
 - The question of whether the vendors acted correctly is also
   interesting, both in reality and in some hypothetical variants
   (e.g. assume Parler was a public safety threat, assume they were
   not)
 - But we're looking at software engineering, so we can make a simple
   assumption: We want to decide whether our app stays up or is taken
   down.
 - The Parler developers didn't properly consider vendor / political risk:
   - They knew their app would be politically controversial
   - They should have evaulated every external service as a potential
     risk
 - Why didn't they consider this risk?
   - Parler, not unlike some other "for conservatives" social apps,
     was built with a particular strategy: Get something up, get
     popular, put off any non-essential concerns as long as possible
   - That's a really good strategy for some kinds of app.
   - Not so much here.
 

**Example 2: The Pirate Bay**

Is it possible to host a politically controversial site / app?

Yes. The Pirate Bay [1] launched in 2003 and has mostly stayed up for
the past 20 years, even though it's most likely actually illegal in
the US.

The Pirate Bay was built for infrastructure resilliency from the
start, with external services carefully selected and implemented in a
way that allows them to be replaced if needed.

There have been a bunch of attempts to take it down. Some examples:

 - In 2006, the cops showed up at the datacenter and took their 
   servers. The site was down for 3 days.
 - In 2009, the founders were found guilty of copyright infrignement
   and went to prison. The site stayed up.

Some techniques they use:

 - They largely run their own servers, colocated at data centers.
 - They currently use Cloudflare - which reduces their bandwidth
   requirements while also hiding their servers.
 - Torrents are actually distributed via P2P "magnet links", which
   makes the legal issue more complicated in Sweden.
 - They have multiple domain names in case of domain seiures, although
   the .org domain has survived the whole time (while they've lost
   tons of other backup domains).


**Other Vendor Risks**

Having your provider declare you a political enemy and actively try to
shut you down isn't the only kind of vendor risk. Also consider:

 - Vendor goes out of business
 - Vendor discontinues service
 - Vender changes pricing structure
 - Vendor gets bought out by Oracle
 - Vendor bans your account

Most of those can be collapsed into the "vendor disappears" scenario,
and it's worth considering that for each vendor / service provider
you're using.

Questions to ask:

 - Is this type of service mandatory to my app?
 - Is this particular vendor mandatory to my app?
 - What's the backup plan?
 - Is it possible to have a hot spare?

What sort of services to consider.

 - Domain registrar
 - Server host
 - Email provider for email address associated with service accounts
   - Is email incidental to something else?
   - Are you using a Gmail account? What if your whole account gets banned?
 - Cell phone provider, if cell # associated with service accounts
 - CDN / Caching Proxy
 - Email for app
   - Recieving
   - Sending
   - You can self host email - it's tricky though
 - Distribution?
   - App store?
 - Any APIs directly used by app
 - Secondary tools: marketing, CRM, etc


**Cloud Lock-in**

Exclusive services:

 - Amazon DynamoDB
 - Is S3 exclusive?

Your data:

 - Where is your application state stored?
   - Consider a Twitter clone
     - User accounts
     - Posts
     - Media
 - If it's on Amazon, that might be:
   - A big database
   - Some S3 buckets
 - If the vendor stops providing service, internal backups don't help.
   - Need external backups
   - For small data, periodic download is fine
   - As data gets bigger, need incremental automatic replication to
     other service
   - That replication may double storage costs *plus* add significant
     bandwidth costs.


**Links**

 [1] https://en.wikipedia.org/wiki/Parler
 [2] https://en.wikipedia.org/wiki/Epic_Games_v._Apple
 [3] https://www.xda-developers.com/ios-sideloading-eu-next-year/
 [4] https://en.wikipedia.org/wiki/The_Pirate_Bay

