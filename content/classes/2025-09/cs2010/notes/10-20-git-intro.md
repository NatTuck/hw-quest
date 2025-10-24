---
title: "cs2010 Notes: 10-20 Intro to Git(hub)"
date: "2025-10-18"
---

## Source Control

Sometimes you end up with more than one version of the same program.

- You want to add a feature to a working program, but you don't want to
  break the old program while you're working on the new one.
- You make some changes to a program and it's horribly broken, so you
  want to get the old version back.
- Two people are working on the same program at the same time and make
  different changes.
- You have copies of the program on two different computers, and you've
  made changes to both.

For a simple program, you can handle a lot of this by making copies:

- chop-tree.lua
- chop-tree-with-branches.lua
- chop-tree-bob.lua
- chop-tree-alice.lua
- chop-tree-alice2.lua.backup

But when things get more complicated, this turns into a mess. That's
especially true when you have larger programs that have multiple files,
multiple computers, *and* multiple people working together.

Solution: A Source Control App

- We mark some directory as being managed by our source control app.
- It lets us save versions of the stuff in the directory.
- It lets us switch between versions or roll back to old versions.
- It helps us share and merge changes with other people.
- Frequently, it gives access to a network server that can store
  a copy of all the versions of the app.

Traditionally: Centralized Source Control, where the server has the main copy

Popular recently: Distributed version control, where there is no main copy (at
least technically)

- Git is a distributed version control tool.
- We create a git repo on our machine.

```
mkdir git-demo && cd git-demo
ls -la
gedit hello.txt # Add some text
git init .
ls -la # Look, there's a .git
git add hello.txt
git commit -a -m 'add hello.txt'
gedit hello.txt # Mess it up and save, whoops!
git log
git checkout -- hello.txt
```

## Github

- Let's go do this week's homework.
- (Pull up Canvas. Quickly do the whole thing.)
