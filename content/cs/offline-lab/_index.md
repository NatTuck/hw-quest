---
title: "Offline Capable Linux Lab"
date: "2023-12-13"
draft: true
---

We need an offline capable Linux teaching lab.

Constant access to the Web is a double edged sword. There are clear
benefits, but for a beginner practicing programming or any similar set
of cognative skills, the option to respond to any challenge by turning
to the web can allow them to progress through learning material
without really engaging with it in a way that teaches them the skills
they need to learn.

Nothing in an introductory programming sequence requires internet
access - a stand-alone workstation is sufficient. All of the tools and
documentation can be installed locally. The concepts and techniques
can be covered in a paper textbook, or an e-book on disconnected
workstation.

Teaching some of our early programming courses (e.g. Intro to
Programming, Data Structures, System Programming in C) in an offline
environment would allow the students to learn the material better and
be better prepared to use the Web to enhance their personal skills.
This will be especially valuable for them in later courses, where
trying to find solutions rather than personally solving problems is
much less feasible.

This offline lab should run modern desktop Linux. Setting up an
offline environment will be easier on Linux. We don't currently have a
Linux lab, which creates multiple holes in our program. And taking
advantage of some of the more interesting opportunties of a dedicated
offline-capable lab would be easier on the Linux platform.

## Offline Lab Assignments

> Do exercises 10.6, 10.8, and 10.9 in the textbook.

In our current labs, that sort of assignment doesn't work. Best case,
the students type the questions into Google. Worst case, they find an
answer sheet or go to an AI chatbot.

With an offline lab, that sort of assignment would become possible.
Further, standard lab assignments work better too and become more
reusable.

To get the benefit, lab assignments would need to be separate from
homework. But this should even help longer homework assignments, by
giving the students a clear idea of what the assignments are
practicing for.

## Offline Programming Exams

> Write a function that uses recursion to find the longest string in a
> list of strings. Your function must be correct and must pass the
> provided test cases.

It's currently possible to give questions like that on paper exams,
but the fact that the student can't compile or run the code nor access
the standard documentation makes such questions much slower and
clunkier than they need to be. On paper there can't be as many
questions, nor can they be as detailed, nor is exactly the right skill
being tested.

With an offline lab, it would be possible to to have students write a
real program using standard tools and go through the typical code /
test cycle.

## Mechanics

The simplest version of this would be:

 - A lab full of desktop computers
 - Desktop Linux installed normally on each computer
 - The lab configured as a stand-alone LAN.
 - A simple router would issue local IP addresses and provide local DNS name lookup.
 - A single ethernet uplink specifically intended to be easily physically unplugged.

There are some compliations:

 - Each student should have their own user account, which works on any workstation,
   and allows for authentication when the lab is offline.
 - It would be nice for each student to have a single home directory, accessible
   from any workstation.

Both of those can be handled by having a single in-lab server
providing LDAP for authentication and NFS for home directories.
Providing login with USNH credentials is worth exploring, but not
worth any compromises to local functionality - creating local accounts
is easy.
   
It is explicitly *not* a goal of this proposal to interoperate with
existing USNH cloud infrastructure - like OneDrive - in any way.

