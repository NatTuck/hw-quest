---
title: "cs2370 Notes: 15 Files and Directories"
date: "2025-02-23"
---


**Files and Directories**

Modern computers have mostly settled on a single mechanism to store
persistent data, or data that survives when you close your
applications and shut off the computer: Files and Directories.

This is true for Windows, Mac, Linux, ChromeOS, iOS, and Android,
although some systems try to hide this stuff from users more than
others do.


**Files**

We keep data in files. A file is:

 - A series of 0 or more bytes of data.
 - Some associated metadata, like a file name.


**Directories**

To keep files organized, each file goes in a directory.

Directories can also store other directories, so we end up with a
"tree" structure.

On Windows:

 - Open up the Windows file manager.
 - Navigate to the root.
 - Windows separates different "drives", so each drive is its own
   directory tree. Drives are identifed by drive letter.
 - ```C:\``` is the root directory of the main drive.
 - It contains several other files and directories.
 - Let's draw a subtree of this out on the board.

On Linux:

 - Open up Nemo
 - Start at /
 - UNIX family systems like Linux and Mac don't separate different drives
   into different trees - there's one tree and the root is '/'.
 - Click around a bit.
 - Let's draw a subtree of this out on the board.


**Paths**

Every file and directory on a computer has a unique path. This is a
string that lists the directories you need to traverse from the root
to get to that file/directory. On windows, it starts with a drive
letter.

For example, the Windows path ```C:\Users\nt1171\IP\walrus.py``` tells
us:

 - This path is on the C drive.
 - Inside the root directory is "Users"
 - Inside that directory is "nt1171"
 - Then "IP"
 - Then "walrus.py"

Probably "walrus.py" is a file, but there's no way by just looking at
the path to determine that it's not a directory.

Probalby "walrus.py" is a Python source file, but the ".py" is just
part of the file name that conventionaly indicates file type. This
could be a JPEG image that someone decided to save with that name.

Windows tree demo: On Windows, try ```C:\> tree /f /a```.

The Linux path ````/home/nat/Teaching/cs2370/syllabus.pdf``` contains
a "home" directory in the root directory, a series of other
directories, and a final part "syllabus.pdf". Again, this is probably
a PDF file, but we can't be sure by looing at the path.

Note that Windows and UNIX-type systems use different characters as
path separators. On Windows it's backslash, on UNIX it's forward
slash. Forward slash is more convenient in programming - you don't
need to escape it in strings - but using backslash means that file
names on Windows can have forward slashes in them.

Those path strings uniquely identify a file or directory on a
computer, but there are also path strings that identify a path
relative to the current working directory.

Every program on a computer is running in some specific directory. It
can access files in that directory by simply specifying their
filename. It also can do other relative paths:

 - "./foo" is a thing called "foo" in the current directory
 - "../foo" is a thing called "foo" in the *parent* directory,
   or the directory that contains the current directory.

When writing cross-platform code, it can be useful to generate
different path strings on different platforms to get the correct
directory separators (and possibly drive letters).

Try this on Windows and on Linux:

```python
>>> from pathlib import Path
>>> xx = Path("/foo/bar/baz")
>>> xx
>>> str(xx)
>>> Path("/") / "tmp" / "walrus.dat"

```

On Linux, the path object is called a PosixPath. "POSIX" - portable
operating system interface - is a standard that describes the common
properties of all modern UNIX-style operating sytems, including how
the file system works.

More stuff in path

```python
>>> Path.cwd()
>>> Path.home()
>>> Path.abspath('.')
>>> Path.abspath('.').glob("*.py")
```

Path methods:

 - exists()
 - is_file()
 - is_dir()
 - read_text()
 - write_text()

What else to do with a path:

 - open

**File Handles**

The ```open``` bif gives us a file object. By default files are opened
in text mode to read a series of characters, but they also can be opened
in binary mode to read a series of bytes.

Methods (on text file):

 - close - When we're done; open files are a limited resource.
 - readline - Read one line
 - write - write a string to the file
 - read - read the whole file

Do some examples, including writing to file.
