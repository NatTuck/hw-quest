---
title: "cs2381 Notes: Lab 01 - Welcome"
date: "2024-01-25"
---

**Lab Rules**

 - No personal electronics; they can be in the room, but not out. If
   you need to check a text message, step out of the lab room.
 - Only approved web resources:
   - Inkfish ( https://inkfish.homework.quest/ )
   - The course website ( https://homework.quest/ )
   - The two textbooks linked from the course website.
   - The official documentation for programming languages, libraries,
     and tools we're using for the current lab.

I agree that these rules are obnoxious. But the only way to practice
something is to do it, and we're trying to practice writing code from
scratch without external help.


**Lab Workstations**

 - Log in with your USNH username.
 - These have fixed software which will be limiting, and they
   don't reliably persist settings.
 - I recommend using OneDrive, but not allowing it to take over your
   local Documents folder.


**Register for Inkfish**

 - Go to https://inkfish.homework.quest/
 - Type in your school email address under Get a Password. The @usnh.edu one.
 - The email will show up in your spam folder within 10 minutes.
 - Pick a long enough password.
 - Hit "all classes" and request access to this class.


**First Teams, Pair Programming**

 - You will usually be working with a partner in lab.
 - Today we'll assign them as people get registered on Inkfish.

Pair programming works as follows:

 - Both partners sit in front of one computer.
 - One person is the pilot - they get the keyboard. The other person
   is the copilot.
 - The pilot types, the co-pilot watches and provides helpful feedback
   (or at least calls out typos).
 - After each section of the assignment, the partners switch roles.

Why?

 - Harder to get distracted.
 - Harder to stay stuck.
 - If one partner doesn't understand something, they have someone to
   discuss it with.
 - Better chance to catch non-obvious mistakes.


**The Mechanics of Completing a Lab**

(Walk through completing the first part of Lab 01)

 - Download the starter code.
 - Figure out where the download went.
   - Probably your "Downloads" directory.
 - Move the starter code somewhere more appropriate.
 - If it's an archive, unpack it and rename the directory.
   - ```tar xzvf archive.tar.gz```
   - ```mv lab03-starter lab03-yourname```
 - Figure out what to do.
   - Do it.
   - Remember to swap pilot/co-pilot roles after each section.
 - Run the tests locally.
   - ```mvn verify```
 - Clean your project.
   - ```mvn clean```
   - The autograder will give you a zero for non-cleaned solutions.
 - Pack your solution archive.
   - ```tar czvf archive-yourname.tar.gz lab03-yourname```
 - Submit your solution archive to Inkfish.
   - Wait for the tests to run.
   - If the tests fail, fix and resubmit.

Important tactical suggestions:

 - Run the tests first. Then submit the starter code.
 - Read both the assignment and the tests to figure out what
   you're supposed to do and how it's being autograded.
 - Do one problem at a time.
   - Then run the tests.
   - Then submit your work.


**Useful Info: What's Maven?**

Maven is a management tool for Java projects.

A Maven project has:

 - A top-level directory
 - Containing a project config file: pom.xml
 - And source code in a specific structure.
   - src/main/java/[package]/Whatever.java
   - src/test/java/[package]/WhateverShould.java
   - and some other stuff

If you open the project directory with VS Code and the appropriate
plugins, it'll handle it as a Maven project.

But you can also (and should be able to) use Maven yourself from
the command line.

Common Maven commands:

```
mvn compile
mvn verify
mvn test
mvn checkstyle:checkstyle
mvn exec:java
mvn clean
```


**Lab 01**

Now you do the (rest of the) lab.
