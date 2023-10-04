---
title: "cs4140 Notes: 61 Backups"
date: "2023-10-03"
draft: true
---

## Backups

Any important data should be backed up, and that includes data for web
apps.

For our applications, the source code exists both on Github and local
dev machines, so that's pretty safe.

What that leaves is any persistent state being stored by the app. That
includes:

 - Your production database
 - Any other data that may be stored outside of the DB, such as user uploads

Best practice for backing up a SQL database is to do periodic database
dumps. Every database has its own procedure and/or tools, but here's
how to do it for SQLite:

ref: https://www.sqlite.org/cli.html

We can't just take a copy of the db file directly, because it might
get changed while we're trying to copy it, which could leave us with a
corrupted backup. So we want to open it with an SQLite client and do a
snapshot that way.

The sqlite3 command line tool provides us two reasonable options:

 - The .backup command will write a copy of the open DB to a new DB file.
 - The .dump command will output the entire DB as a sequence of test SQL statements
   to recreate the DB.

The former should be faster and more compact. The latter gives us more
options for trying to do data recovery if something goes wrong.

After that dump is created, it should be copied to another machine so
it's not lost if the server breaks.

Example:

```bash
export DUMP=dump-$(date +%Y%m%d-%H%M).sql
sqlite3 dbfile.db .dump > $DUMP
gzip $DUMP
scp $DUMP backup.host:~/dumps
```

Restoring a backup:

```bash
zcat dump-xx.sql.gz | sqlite3 dbfile.db
```




