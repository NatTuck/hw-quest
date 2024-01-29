---
title: "cs2370: Required Software"
date: "2024-01-01"
---

For this class we will be using Python 3. You can download it at
[https://www.python.org/downloads/](https://www.python.org/downloads/).
As of January 2024, the latest stable release is the 3.12 series
(currently 3.12.1), so that's what you want to get.

 - On Windows, you probabaly want the 64-bit Windows installer.
 - On Mac, the 64-bit universal Mac installer should work.
 - On Linux, it's most likely easiest to install from your
   distribution package repositories. Make sure you get the IDLE
   editor. A slightly older release (e.g. 3.10) should work fine.

## Notes for Mac

Installing Python on Mac gets you a "python3" command but not a
"python" command. This can break some of the test scripts.

To fix this, do something like this:

```
$ python
Error: no such command
$ which python3
/Frameworks/Python.Something/Monkeys/Python3.12/bin/python3
$ cd /Frameworks/Python.Something/Monkeys/Python3.12/bin
$ ln -s python3 python
$ python
Welcome to python, everything works.
>>>
```
