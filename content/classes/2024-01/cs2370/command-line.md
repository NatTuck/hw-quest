---
title: "Command Line Cheat Sheet"
date: "2024-01-28"
---

Anyone writing computer programs should be familiar with the command
line interface for their computer. Here's a quick review of the
absolute basics.

## Windows CMD.EXE

The default command line interface is CMD.EXE, descended from the old
MS DOS interface.

When you open a CMD window, you'll see something like this:

```batch
C:\Users\nt1171>
```

There are three parts to that prompt:

 - "C:" means this cmd window is currently looking at the C drive.
 - "\\Users\\nt1171" means it's looking at that directory (a user home directory).
 - ">" is the end of the prompt, telling us to type a command.

Basic commands:

 - ```help``` - List available commands
 - ```help (command)``` - List usage info for (command)
 - ```dir``` - List files in current directory.
 - ```cd (path)``` - Change directory to path.
 - ```move (name) (path)``` - Move (or rename) file (name) to (path).
 - ```copy (name) (path)``` - Copy file (name) to (path).
 - ```python script.py arg1 arg2 ...``` - Run a python script.

Path examples:

 - ```move apple.txt orange.txt``` - Both files are in current directory.
 - ```move apple.txt \users\nt1171``` - Desination is absolute path to directory.
 - ```move apple.txt ..\fruit``` - ".." is the parent directory.

Example of some ```cd``` commands:

```batch
C:\Users\nt1171> cd Documents
C:\Users\nt1171\Documents> cd ..
C:\Users\nt1171> cd \
C:\>
```


## Linux Shell (Mac is basically the same)

When you open a shell window you'll see something like:

```bash
nat@mint:/home/nat$
```

Four parts to that prompt:

 - Current user (nat)
 - Current machine name (mint)
 - Current path (/home/nat)
 - $ prompt (% on Mac) tells you you can type a command. If this is an
   root (admin user) prompt, the last character will be '#'.

Linux and Mac use a traditional UNIX style set of commands.


 - ```man (command)``` - View documentation for a command.
 - ```ls``` - List current directory.
 - ```cd (path)``` - Change directory to path.
 - ```mv (name) (path)``` - Move or rename item.
 - ```cp (name) (path)``` - Copy item.
 - ```python script.py arg1 arg2 ...``` - Run a python script.

Example of some ```cd``` commands:

```bash
nat@mint:/home/nat$ cd Documents
nat@mint:/home/nat/Documents$ 
nat@mint:/home/nat$ cd /
nat@mint:/$ 
```



