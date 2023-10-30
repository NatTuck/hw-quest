---
title: "cs4140 Notes: 25 Scaling"
date: "2023-10-21"
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

