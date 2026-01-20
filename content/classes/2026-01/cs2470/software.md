---
title: "Software for cs2470"
date: "2026-01-09"
---

This course is "Systems Programming in C/C++".

Systems programming involves using programming interfaces provided by
the operating system. Different operating system families provide
different interfaces, so we need to pick one.

We'll be using Linux. Most version of Linux will provide the same
POSIX system call interface for C programming. Different Linux
distributions have slightly different commands; the following versions
will be supported for this class:

- Ubuntu 24.04, as installed on the lab workstations
- Debian 13, as installed on the Inkfish testing containers
- Linux Mint 22.2, recommended for your personal machine

There are slight differences between these versions and we will run into
them. That's expected.

You can run a different version of Linux or even try to run the
assignments on MacOS or Windows with a POSIX compatability layer. In
those cases, if it breaks only a limited amount of help will be
available.

## Installing Linux in a VM

This is the recommended procedure if you're not running Linux directly
on your hardware. Aside from the first homework, this is not required.

**Install a Hypervisor**

- On Windows: [VirtualBox](https://www.virtualbox.org/)
- On ARM Mac: [UTM](https://mac.getutm.app/) [Blog Post](https://medium.com/@max.kombarov/virtualizing-amd64-architecture-on-apple-m-chips-with-utm-for-qa-a-step-by-step-guide-366dbaa0cc2c)

This course includes some AMD64 assembly code, so you will need to
install the AMD64 version of your Linux OS even if that means
emulating it on a modern Mac.

**Install a Linux Mint VM**

- Download the [Linux Mint 22.2 AMD64 Cinnamon Edition ISO](https://linuxmint.com/)
- Create a new virtual machine in your hypervisor, and install Linux
Mint using the ISO you downloaded.
- Make sure your new VM has at least 4 cores, 4 GB of RAM, and 20 GB of disk
space. Not pre-allocating the disk is fine.

**Install Some Packages**

Once you have Linux mint up and running, open a terminal and run the following
commands

```bash
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y build-essential git neovim time util-linux \
    manpages manpages-dev manpages-posix manpages-posix-dev \
    libipc-run-perl libarchive-zip-perl libbsd-dev pkg-config
```

## Text Editors

The recommended text editor for this course is neovim. It's a mature editor that
provides for powerful editing capabilities by default while also allowing for
extreme levels of customization and workflow optimization. As an extra bonus,
learning neovim will also teach you the standard vi editor which is installed on
most Linux machines including servers that you may ssh into.

While neovim is not specifically required, a programming text editor is
required.

Specifically, your editor must:

- Primarily edit plain text files.
- Provide syntax highlighting and indentation assistance for C code.
- Not be a heavyweight IDE and especially not have any sort of AI autocompletion
  functionality enabled.

Reasonable alternatives to neovim include:

- GNU Emacs (Spacemacs, Doom Emacs)
- Kate (on Linux with a GUI)
- Notepad++ (on Windows)
- Bluefish

It is recommended to agressively disable all "autocomplete" functionality for
your editor. Aside from automatic indentation it's a bad tradeoff, especially
when you're trying to learn to write code.
