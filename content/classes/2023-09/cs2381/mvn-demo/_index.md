---
title: "cs2381: Maven/JavaWorld Project Starter"
date: "2023-08-31"
---

One of the key things that the Maven build tool lets us do is to
specify dependencies - libaries that our project uses - by name rather
than having to provide manual instructions to get them or including
the library binaries in our source code.

The typical way to start a new project with Maven would be to use a
"project archetype", which is a template for a project that defines the
structure and common configuration for that kind of project.

We have an archetype for labs in this class, available on Github here:

https://github.com/NatTuck/java17-junit5-archetype

As with many things in the Java language ecosystem, this process is a
bit verbose, so here's a faster way for quick and dirty experiments:

**Demo Project Starter**

Here's a tarball of a new project called "demo" created with the archetype:

[mvn-demo-app-starter.tar.gz](./mvn-demo-app-starter.tar.gz)

To use this: 

 * download it
 * unpack it
 * rename the directory to something else
 * open the directory in VS Code (or edit and mvn manually)
 
As long as your software is all set up you should be good to go.
