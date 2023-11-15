---
title: "Department Cloud Server Account"
date: "2023-11-14"
---

Goals:

 - Running Inkfish
 - Developing and running other web / network apps for teaching,
   preferably without breaking Inkfish.

Things that haven't worked or don't look promising:

 - Requesting a VM from the University. They effectively don't support
   faculty-administered virtual servers.
 - Running an Amazon cloud instance through the Research Computing
   Center. This service is focused on scientific computing rather than
   persistent virtual servers. It's billed hourly, and backups are
   tricky. Running a single virtual server would realistically be
   about $25/month.

New proposal:

 - Let's set up a department account with a virtual server provider.
 - Specifically: Linode
 - Stephanie would create main account, then she could create a
   delegated account for me (or others) that could do technical stuff
   but not access billing info.
 - Once we have an account, we can set me up with two virtual servers
   for $30/month:
    - One production Inkfish server
    - One server for development, demos, and experiments
    - Reasonable backups included

ref: [Linode Estimate](./Nat-Linode-Estimate-2023-Nov-14.pdf)

