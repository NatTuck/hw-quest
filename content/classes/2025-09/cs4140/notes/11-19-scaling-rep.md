---
title: "cs4140 Notes: 11-19 Scaling and Replication"
date: "2025-11-17"
---

Let's consider a reasonably simple web app: local search.

Specifically, we're going to make a mirror of Wikipedia and
search that.

That's something like:

- 60 million pages
- 25 GB

We'll use a VPS like the ones we're using for class:

- 2 processor cores
- 2 GB of RAM
- 50 GB of disk.

Our first plan is going to be to put everything in one table in our
SQL database. Our full data set fits on disk, but not in RAM.

So our user types in their search, and the DB does a sequential scan.

- User types in query.
- Presses "search"

Let's assume our disk can do reads at 1 GB/second.

- Our bottleneck is disk read speed.
- We scan the whole data set, which takes 25 seconds.

**Basic Optimizaton: Index**

So we need to do some basic optimization. Let's make an index on words
in our pages.

- If we assume 100 unique words per document, that's a table of 6 billion
   records.
- We'll have to do some trickery to get everything to fit on disk -
   ignoring very common words is probably the easiest.
- But now we can now find records containing words very fast, but
   picking the best records will still require some post processing.
   Let's assume that we read the first 1000 pages into memory and then
   do soem post-processing to find the best 10.
- So our disk read time for a query is down to to under 10ms - call it 10ms.
- Let's assume that the post-processing compute takes 100ms.
- We're single threaded sequential, so we can do 9 requests per second.

What if we need to handle 20 requests per second?

**Scaling: App Server Processes**

- Our app server has a common property in web dev: It handles
   requests entirely independently.
- There are no global variables storing inter-request state.
- The only global state is the DB, which is designed to handle
   concurrent requests.

So we can easily add extra server processes.

- If we add one process, we can double our throughput.
- The system can schedule the CPU load to the second core.
- Our processes still aren't using CPU while they're blocked on disk
   so two processes is only 18 requests/second.
- Adding a third process will give the CPU something to do while
   the other processes are blocked on disk. At 100% CPU, we'd be at
   20 reqeusts per second (ignoring some overhead inefficiency).

At that point we can't scale more on our hardware, so we need to
upgrade our instance.

Our disk performance limits us to 100 requests per second - we can get
there with 5 processes running on 5 cores.

It's possible to increase disk performance a bit. We could move to a
two disk NVMe RAID-0 and double read performance, which would let us
scale to 200 requests per second with 10 processes on 10 cores.

To scale beyond that, we need to reduce our dependency on reading from
the database.

But this example doesn't really work anymore. If we have ~ 10 cores we
can easily get 50 GB of RAM, put our whole dataset in RAM, and write a
custom in-memory search app that will likely saturate the network
interface.

# Other Techniques

## Read Caching

Consider a news site:

- Lots of views of the main page.
- Lots of views of recent articles.
- A few new articles created.
- A few views of older articles.

If articles are stored in a DB and requests are satisified by DB
queries, DB read speed will quickly become the bottleneck.

In this scenario it's feasible to do in-memory caching in the app
server.

- In a global variable, keep track of the path of the last 1000 requests.
- In a global hash table, cache the most recent responses for the
   most commonly requested 10 paths.
- If the cached version of a response is no more than 5 minutes old, send the
   cached version. After 5 minutes, re-do the DB query to get any changes.

If 90% of requests are for the top 10 paths, then this allows 10x the
throughput.

## Content Delivery Networks

Move static files off app server.

Move static files and cache closer to user.

Vendor risk.

## Scaling the DB itself

Modern relational DBs (Postgres, MariaDB, MS SQL Server, etc) scale
nicely on single multi-core servers.

Scaling beyond one server is harder - it's theorietically impossible
to have all the DB properties you want in a distributed DB.

**Read Replicas**

For read-only operations, it's generally OK to get slightly old data.
It's not really possible to distinguish between doing a read 100ms ago
and doing the read now and getting a result from 100ms ago.

Relational DBs typically allow you to set up read-only replicas. All
writes go to a single main server, and then that server copies the data
to several replica servers.

Then write and read/write requests go to the main server, but all
read-only requests can go to the replicas.

**Multi-Master Replication**

Many relational DBs allow for synchronous multi-master replication.
Multiple servers accept write requests, but any such request will be
duplicated to all of the servers and all of the servers must confirm
recipt of the write before it completes.

Not only does this not speed up writes, it slows them down a bit. So
this is more of a reliablity thing than a performance thing.

**Sharding**

If you need to support a thousand users, and each DB server can only
support 500 users worth of requests, you can split the users across
multiple DB servers.

You could do this by telling each user to connect to a different
instance of your app, or you can add logic to your app server to
direct different users to different DBs - that's sharding. For
example, users with names starting A-M could go to DB server 1 and N-Z
users could go to DB server 2.

Any DB table can be sharded, but this requires some application
specific knowledge about how the data is split and what sort of
operations you want to do. Generally you give up doing atomic updates
for data that crosses shards.

# Replication and Redundancy

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
