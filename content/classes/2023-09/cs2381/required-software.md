---
title: "cs2381: Required Software"
date: "2023-08-31"
---

The software you need to install to work on a personal machine is:

An Editor:

 - [VS Code](https://code.visualstudio.com/) (>= 1.78) or 
   [VScodium](https://vscodium.com/) with "Extension Pack for Java" or some 
   other editor

The dev tools:

 - [OpenJDK](https://adoptium.net/temurin/releases/?os=any&arch=x64&package=jdk) >= 17
 - [Apache Maven](https://maven.apache.org/) (>= 3.9.4)

To run the test script and see how autograding will go:

 - [Strawberry Perl](https://strawberryperl.com/) (>= 5.32 64 bit) for Windows
 - Perl might be installed by default on Mac?

Links are for Windows and maybe Mac. On Linux you can install these
(even Maven) from your distribution package repository.

**Installing Maven**

Maven is tricky, because it doesn't come with an installer. Start by
reading the installation instructions, and then cosider:

 - You should unpack the archive outside your Downloads folder.
 - You need to add the "bin" directory to your PATH environment variable.

To change your PATH, try searching for "Add directory to windows/mac/linux path".
