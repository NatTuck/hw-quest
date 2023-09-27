---
title: "cs4140 Notes: 13 deps"
date: "2023-08-27"
---

**Node**

Command:

```bash
npm install package
```

Config file (package.json):

```json
{
  ...
  "dependencies": {
    ...
    "prisma": "^5.2.0",
  }
}
```

Version number specifiers:

 - Exact string "5.2.0" means exactly that.
 - Approximate "~5.2.0" means new patch releases are allowed, like 5.2.17
 - Compatible "^5.2.0" means new minor releases are allowed, like 5.2.17 or 5.3.5

Specifying a dependency also requests its transitive dependencies. Npm
provides some mechanisms to allow multiple versions of the same
dependency to be installed which helps avoid version conflicts for
indirect deps.

When you run "npm install", you get a lock file: package-lock.json

This pins exact versions, including URLs and cryptographic hashes.
This should guarantee that subsequent "npm install"s give you exactly
the same code, even if a dependency author is trying to mess you up.

**Ruby**

Add deps by editing "Gemfile"

General pattern for deps is:

```ruby
gem "name", "version"
```

There are several ways to specify versions, but the most common are:

 - Exact string "5.2.0" or "= 5.2.0" gives you that version.
 - Greater but near "~> 5.2" allows the last specified digit to change.
 - "~> 5.2" allows "5.2.1" or "5.3.4" but not "6.0".
 " "~> 5.2.0" allows "5.2.1" but not "5.3.0".

Like with npm, running "bundle" gives a lock file. This pins exact
versions, but not cryptographic hashes.

Unlike with npm, the ruby bundler can't handle mulitple conflicting
versions of the same gem.

