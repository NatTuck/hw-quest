---
title: "cs4140 Notes: 14 Licensing Traps"
date: "2023-09-28"
---

Paying for commodity services makes sense.

Paying for application software licences may or may not make sense.

Paying for software libraries that your project will depend on is much
more expensive than just the fee - the terms are usually a huge
restriction on what you can do with your app.

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


## Meeting Stuff

 - Are all quiz apps deployed?
 - Has everyone contacted their customer and scheduled an initial meeting?
 - Any questions on customer / meeting / semester project?
 
Team meetings, go!

 - If anyone has questions on quiz app technical stuff, I'd be happy
   to help during the meeting time.
