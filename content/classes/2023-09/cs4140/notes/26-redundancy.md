---
title: "cs4140 Notes: 26 Backups and Redundancy"
date: "2023-10-21"
---

When someone tries to visit your web site, you want it to work.

There are a bunch of techniques you can use to make your code as
bulletproof as possible, but that ignores an important class of problems.

## What if the server breaks?

Hardware fails. Not super frequently, but frequently enough that it's
worth prepareing for.

If you're running on one server - as we are so far in this class -
there's no way to solve this problem; adding software to a computer
doesn't help if the computer isn't working.


## First, Backups

If your server fails, what do you need to recover:

 - Your code - that's pretty safe because it's in various copies of
   your Git repo.
 - The current state of your server (Whatever it would take to
   recreate the server beyond the default OS and current code.)

Generally that means:

 - A snapshot of your DB.
 - A snapshot of your config files.

You can write a script to dump the DB, copy everything into a
temporary directory, and make a tar archive of it. This archive can
then either be download to a local machine or copied to some sort of
cloud storage.

VPS snapshots are good too, but that doesn't help if your whole
provider breaks.


## Second, Replicas

So the only way to solve this is to add at least one additional
server.

Just like with scaling, we've got the same basic app structure:

 - An app server, which can typically handle many concurrent instances.
 - A DB server, which is harder to duplicate.

To simplify discussion here, let's split up our application to
three machines to begin with:

 - Two app server machines.
 - One DB server machine.

How do we get requests to both app servers?

 - Load balancer (what if that fails)
   - Network-level failover
   - What if the router fails?
 - Round robin DNS

Redundancy for SQL DB:

 - Main server
 - Read replica
 - Failover
 - Multi-master replication

This is one of those areas where lots of people try to sell "premium"
addons for common open source tools, so finding the standard thing and
avoiding all the nonsense payware can take some effort.

## What if the network breaks?

Or what if your whole datacenter gets hit by a meteor?

Again, you can't solve this by setting up the datacenter better.

You need a backup location. Again, app servers duplicate fine and
duplicating a SQL DB is hard.

Probably the easiest way to deal with this for reasonable sized
systems is to do WAL replication to a replica at the secondary site
and then manually switch over for long-duration outages.


## NoSQL

SQL databases are only one option for a persistent data store. They're
the default for good reason, but let's look at what the alternatives
are.

A SQL database gives us some specific guarantees. Specifically, it
provides for transactions where you can make multiple changes without
worrying about data corruption.

ACID guarantees about SQL transactions:

 - Atomicity - A transaction either completes fully or not at all.
 - Consistency - Transactions move the database from one valid state to
   another valid state.
 - Isolation - Concurrent transactions are entirely independent; no transaction
   can ever see the effects of another incomplete transaction.
 - Durability - Once a transaction is done, it'll never be undone -
   even if someone pulls the plug on the server or something else
   weird happens.

Those are very strong guarantees about data validity. Designing
software systems is much easier when your persistent storage mechanism
provides those guarantees.

Unfortunately, such strong guarantees have non-trivial performance
costs. So it's tempting to give some of them up for better
performance. Further, doing replication for a system with these
properties is hard.

Once you give up on guaranteeing complex atomic transactions and
durability, it's possible to make a system faster and more easily
distributed /replicated. But it still can't have all the other
properties you might want.

Why?

**The CAP Theorem**

We'd like our distributed data storage system to provide:

 - Consistency - Every read receives the most recent write or an error.
 - Availability - Every request receives a (non-error) response,
   reasonably quickly, without the guarantee that it contains the most
   recent write.
 - Partition tolerance - The system continues to operate despite an
   arbitrary number of messages being dropped (or delayed) by the
   network between nodes.

When the network is partitioned, you can either have consistency or
availability - either writes are accepted and reads can't be consistent or
writes are rejected which means you're not available.

Two common modes for NoSQL systems:

 - Immediate consistency - writes require confirmation by >1/2 of nodes,
   reads require consensus between >1/2 of nodes. (or n and 1, n-1 and 2, etc)
 - Eventual consistency.


## Another Thought

What if you build a custom replication layer on top of several SQL DB
instances?

This lets you mix and match which guarantees you want for which
transactions. If you need durability, you can wait for multiple
confirmations with a mechanism for resolving conflicts. If you need
maximum speed, you can do zero confirmations and eventual consistency.


## Real world distributed database systems

**CouchDB**

 - JSON Docuemnt Store
 - No transaction guarantees
 - Eventual consistency by versioning
   - One write is enough
 - Map-Reduce indexes
 - Offline support - you can put a local node on a client (e.g. phone/browser),
   and it'll eventually sync

**Riak KV**

 - String key to BLOB value
 - Key-based sharding
 - Can chose between eventual consistency and majority-to-write
 - Does CRDTs, which allow for automatic conflict resolution 

**Cockroach DB**

 - A distributed SQL database
 - With built-in sharding and replication
 - Doesn't support all of SQL
 - Can be slow
 - But does provide ACID and the ability to lose any server at any time
