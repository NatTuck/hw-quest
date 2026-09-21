---
title: "cs2010 Notes: 09-21 Computer and UI"
date: "2026-09-16"
---

## Text

Text is a series of bytes.

- For English keyboard chars, each byte is one character.
- So the text "Hi, Welcome to CS 2010" is 22 bytes.

## Structure of a Computer

- CPU
- RAM
- Disk
- I/O: Keyboard, screen, network

## Where do we store data?

- Running program: in RAM
- Longer than one program? On disk, in a file.
- A file is a series of bytes, with a name (short text)

## Demonstrate file <-> bytes and different UI modes

- Use gedit to create sample file
- Use nemo to show properties:
  - Name
  - Size in bytes

Two user interface modes:

- GUI, like gedit/nemo
  - gives a single clear view
  - common actions are visual and discoverable
  - Less common actions are hidden or entirely missing
  - Show space free in nemo
  - System monitor
- CLI, repeat with echo/ls/stat/vim/duf/free -h
  - "we can do better than point and grunt: language"
  - communicate with text: commands and command output
  - Need to know the language(s), both concepts and grammar
  - `hd (FILE)`
  - `man ascii`
  - Absolutely need to read some docs.
- Option 3: Natural language
  - opencode - Qwen
  - "Create a text file named 'hello.txt' containing the lyrics of Twinkle
  Twinkle Little Star"
  - What are the ascii codes for the characters in the file?
  - Append a snowman emoji to the end of the file.
  - *Still* need to know the concepts, although but there's some
  improved discoverability through discussion.

## File System Structure

- We need to store files
  - That's a sequence of bytes
  - And some metadata: Name, maybe file type, dates, etc.
- Early computers just said your files go on a disk
  - Doesn't work with too many files
  - We get this file cabinet metaphor, almost.
  - One document is a "file", they go in "folders", folders live on "disks".
- Technical detail: paths
  - Every file or directory has a path
    - One string of characters
    - On Linux/Mac, starts with "/"
    - On Windows, starts with a drive letter (probably C: for local)
  - Sequence of parts separated by / or \\.
  - If we're finding a file, the last part is the file name.
  - The rest of the parts are directory names.
- Relative paths:
  - Every running program (including file managers and terminal windows)
  has a working directory.
  - Explain ./ and ../

