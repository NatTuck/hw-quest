---
title: "Virtual Machine Host"
date: "2023-12-18"
---

## Refurbished Server

Here's the first example of a refurbished server I found:

![ServerMonkey Screenshot](refurb-r630-v2.png?width=1316)

The specs are:

 - Dell 1U Chassis
 - Dual 16-core Xeons from 2016
 - 256 GB of RAM in 8 DIMMs to use all the memory channels
 - No disks, but 4 disk trays
 - 4x 1GB Ethernet Ports
 - iDRAC Enterprise for remote hardware management
 - Dual power supplies

Refurbished disks are slightly overrpriced, so we'd want to add pair of
2TB SATA SSDs from Amazon.

 - Server ($750) + Disks ($250) = $1000

[Refurbished PowerEdge R630 @ ServerMonkey](
https://www.servermonkey.com/refurbished-dell-poweredge-r630-8-port.html)

[Crucial MX500 2TB SATA SSD @ Amazon](
https://www.amazon.com/Crucial-MX500-NAND-SATA-Internal/dp/B003J5JB12)


## Software Setup

Realistically, any modern community Linux distro would work for the
host. Personally, I'd prefer the latest Debian Stable (currently 12)
or Ubuntu LTS (currently 22.04) due to stability, reliability of
automatic updates, and personal familiarity.

We don't want the ET&S approved Oracle Enterprise Linux - the license
cost for two sockets would be similar to the cost of the hardware.

For managing VMs at this scale there's no need for any software beyond
what's available in the repos for a modern Linux distro (e.g. virsh,
virt-manager, cockpit).


## Where does this go?

Optimally, somewhere on the PSU campus where CS faculty can have
access and students can have at least supervised access.

If there's nowhere this can go in D&M, is there an existing rack in
another building?


## What would this let us do?

For the price of cloud hosting two small virtual servers for a year,
we could instead host between 30 and 60 similar virtual servers for
several years.

This would also allow us to run an Inkfish instance with several CPU
cores. That would allow for automatic testing parallel speedup on
student assignments that use multiple threads or processes, which
would have been useful on a recent Data Structures lab.
