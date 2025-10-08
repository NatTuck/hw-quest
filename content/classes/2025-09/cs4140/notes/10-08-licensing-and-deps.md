---
title: "cs4140 Notes: 10-08 Licensing and Dependencies"
date: "2025-10-06"
---

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

## Licensing

SPDX identifiers

This is a very practical issue: Our customers generally won't be happy
if we deliver them software that they can't legally use.

Another ref: <https://github.com/readme/guides/open-source-licensing>

**Basics: Copyright**

Anything any person writes or otherwise authors - software, a novel, a
movie, etc - is covered by copyright law.

In practice, copyright may restrict:

- Creating modified versions (deriviative works)
- Distributing modified or unmodified copies
- Any use that involves incidental copying

By default, all of those things are disallowed unless the copyright
holder gives permssion in the form of a copyright license. The license
can impose requirements on those activities. The copyright holder may
charge money for the license.

Copyright is automatic and lasts more than 50 years. All software that
has ever been written is covered by copyright unless the author
explicitly gave up their copyright (dedicated the software to the
public domain).

**Open Source**

Some software licenses are "open source" licenses.

"Open Source" is a trademark of the Open Source Initiative. To be open
source, software must:

- Be freely usable and redistributable in source and binary form.
- Have available source code.
- Allow people to create and distribute modified versions.
- Not impose certain odious requirements.

The OSI has [a list of open source licenses](
https://opensource.org/licenses/). There are a bunch of them, but most
of them are redundant to others that are more commonly used.

Today, I'm going to spit all software licenses into four categories:

**Permissive Open Source**

Most programming libraries are licensed under permissive open source
licenses. These allow anyone to use, copy, modify, and redistribute the
software with only minimal restrictions.

Both Rails and Next.js are distributed under the most popular
permissive open source licens,e the [MIT
License](https://opensource.org/license/mit/). This license allows us
to do whatever we want with the software, with the following conditions:

- We must not remove the copyright notice or license from copies of the software.
- The authors disclaim all liability related to the software.

There are a bunch of licenses in this category, but one other license
is especially notable. The [Apache License 2.0](
https://opensource.org/license/apache-2-0/) is a bit more complicated
than the MIT license, but includes only one major practical
difference:

- Anyone who contributes software to an project licensed under the
   Apache Licese 2.0 grants a patent license to all users of the
   software for any of their patents which cover that contribution.

This prevents companies from submitting changes to an open source project
to cause it to infringe their patents and then suing anyone who uses the
program, which would be kind of a jerk move.

If a program or library is released under a permissive open source
licence there there no special licensing concerns in using it. Just
follow the attribution requirements (possibly in your documentation)
and don't be a patent jerk.

This is the **only** category of software license that's safe to
include as a dependency without a business impact analysis.

**Copyleft Open Source**

Some open source licenses require that any derivitive works of
programs covered by the license must be distributed with source code
and must be entirely covered by the same license.

This prevents companies from taking these programs, making a few
improvements, and then releasing the resulting software under a
proprietary license.

That sounds anti-commerical, but one of the most common uses of this
style of license is as a business model. Users who want to include
this sort of copyleft software in their propritary product are
required to buy a proprietary license.

The most common copyleft license is the GNU GPL v3. It has the
following basic requirements:

- Any derivitve works must be licensed under the GNU GPL v3 or a
   compatible license.
- If you distribute the program or a derivitive work, you must
   either include source code or an offer for source code.
- If you distribute the program in a consumer hardware device, the
   end user must able to install their own modified version of the
   program on that device.
- Don't be a patent jerk.

Apple hates the GPL.

If you're considering GPLed software, the following licensing
considerations apply:

- If you simply plan to run the software, the license doesn't
   impose any requirements on you.
- If you simply plan to locally modify the software and run your own
   modified versions, the lisence imposes no requirements on you.
- If you're OK with distributing derivitive works under the GPL and
   distributing source code, the GPL is fine.
- If you want to produce software under some other license - be it
   permissive, proprietary, or simply a different copyleft license -
   you can't include GPLed code.

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

There are other copyleft licenses, but that causes issues because a
given program can generally only have code under at most one copyleft
license at a time.

It's good practice to avoid copylefted dependencies by default, even
if you plan to release your program under a copyleft license. If you
ever want to do something the licenses don't allow then you'll have to
do a bunch of work to replace those dependencies.

**Zero-Price Proprietary Licenses**

Some software isn't open source, but can be freely downloaded and used
to some extent.

When considering dependencies that fall into this category it's
nessiary to carefully consider the terms under which the software is
offered and the implications of using it.

Here are some specific things to look out for:

- Do the conditions limit how this software can be used? Is it
   possible that you will **ever** run into those limitations? If so,
   how hard will it be to remove this dependency?
- Are there any conditions under which a payware license is required.
   If there is any chance that you'll meet those conditions you should
   evaluate the software as payware.
- If full source code isn't included, you may not be able to fix bugs or even
   figure out what the code does.
- If full source code isn't included, you may not be able to easily run the code
   on different hardware in the future.
- If there are restrictions on use, you won't be able to do those things without
   removing this dependency.
- If the software is provided by Oracle, they may send you a bill for
   thousands of dollars per user and/or CPU core and send their
   lawyers after you if you don't pay up.

More broadly, this stuff falls into two categories:

- Abandoned historical artifacts.
- Traps

**Payware Proprietary Licenses**

This software requires purchasing a license, and is generally
restricted to use on specific computers or by specific people.

Adding payware dependencies is a business tradeoff, but the simple
story is that once you do it you no longer own your program.

Buisness people will occasionally talk about a "build / buy tradeoff".
You can buy an office building. You can't buy software - it only comes
on short term leases.

Let's consider [FusionCharts](https://www.fusioncharts.com). This is a
JavaScript chart rendering library. For only $1899/year you can use
this for up to 5 developers, as long as you don't charge a
subscription fee to end users. If you use this dependency, those
requirements now apply to your whole project: No more than 5
developers, no subscription fees. Honestly that seems nuts even if
there weren't other charting libs.

"Platform" dependencies are especially pernicious. If you build an
application specifically for Microsoft Sharepoint or Amazon AWS, then
that's the only place it's ever going to run without effectively doing
a from-scratch rewrite.

## License Auditing

Tools like [License Auditor](
https://github.com/brainhubeu/license-auditor) or
[Organization License Audit](
https://github.com/grosser/organization_license_audit) can help
verify that your depedencies have reasonable licenses.
