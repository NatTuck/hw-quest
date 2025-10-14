---
title: "cs4140 Notes: 10-10 Software Supply Chain"
date: "2025-10-08"
---

## GPL Variants

There are two variants of the GNU GPLv3 that is partially compatible and
worth noting: the GNU LGPL and the GNU AGPL.

The LGPL is the GPL with the requirements slightly relaxed:

- If you use an LGPL library, it doesn't require that your program
   also be LGPL. The same-license requirement applies only to modified
   versions of the library itself.

The AGPL imposes the following additional requirement:

- If you use AGPL code in a network service, that network service
   must have a feature to distribute its current source code to any
   user that requests it.

The AGPL is designed so Google and Amazon will hate it as much as
Apple hates the GPL.

If your goal is to write a library for network program and force
commercial customers to pay for a different license, the AGPL is
great.

## License Auditing

Tools like [License Auditor](
https://github.com/brainhubeu/license-auditor) or
[Organization License Audit](
https://github.com/grosser/organization_license_audit) can help
verify that your depedencies have reasonable licenses.

## Dependencies

Many modern programming languages provide a package management tool.

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

**Semantic Versioning**

<https://semver.org/>

This is a convention for how version numbers should work:

- Major version means incompatible API changes.
- Minor version means backwards compatible new functionality.
- Patch version means backwards compatible bug fixes only.

Following this for libraries is a good idea.

**Elixir**

Add deps by editing "mix.exs"

- Functionally similar to the JS stuff.
- Let's take a look at an example.

## Issues with Dependencies

**left-pad**

Back in 2016 a bunch of popular JavaScript packages - including
React - just broke. The developer of one of their dependencies had
gotten mad and deleted it. The dependency was called "left-pad"; it
was just one function that added padding characters to a string to
make it a minimum length.

And... that was kind of the best case scenario. Every dependency you
add is an opportunity for some external developer to make changes to
your program. The more typical malicious dependency change is adding
code to find and steal bitcoins - that's happened several times.

<https://npmgraph.js.org>

- d3
- webpack
- @uiw/react-codemirror

Other examples:

- event-stream (2018) - new developer of library injected cryptocurrency
  theft code and stole $300k.
- liblzma (2024) - maintainer inserted remote backdoor in C library
- SolarWinds (2020) - Russian hackers breached proprietary software
  company with IT management platform used by a bunch of companies and
  US federal government agencies, stole a bunch of government email
- chalk, debug, etc (last month) - Major npm developer account got
  hijacked and cryptocurrency theft stuff got injected.

Conclusions:

- The threat isn't just libraries or open source software. *Any* mechanism that
results in software installs, especially automatically or periodically, is a
huge threat vector.
- "Universal back door" - Automatic updates + user authentication is a targeted
attack vector.
- Cryptocurrency is great for computer security. It gives attackers something
moderately valuable to target, effectively creating global bug bounties for
all software.
