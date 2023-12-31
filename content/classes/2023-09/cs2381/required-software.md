---
title: "cs2381: Required Software"
date: "2023-09-07"
---

The software you need to install to work on a personal machine is:

An Editor:

 - [VS Code](https://code.visualstudio.com/) (>= 1.78) or 
   [VScodium](https://vscodium.com/) with "Extension Pack for Java"
 - Alternatives: [Neovim](https://neovim.io/), 
   [Emacs](https://www.gnu.org/software/emacs/) (
   [Spacemacs](https://github.com/syl20bnr/spacemacs),
   [Doom Emacs](https://github.com/doomemacs/doomemacs) )

The dev tools:

 - [OpenJDK](https://adoptium.net/temurin/releases/?os=any&arch=x64&package=jdk) >= 17
 - [Apache Maven](https://maven.apache.org/) (>= 3.9.4)

On Linux (Mint, Ubuntu, Debian), that's:

```bash
sudo apt install openjdk-17-jdk maven
```

To run the test script and see how autograding will go:

 - Windows: [Strawberry Perl](https://strawberryperl.com/) (>= 5.32 64 bit)
 - Linux and Mac: Perl is probably installed by default. On Linux, a missing
   "Foo::Bar" is generally the "libfoo-bar-perl" package.

Other recommendations on Windows:

 - Linux commands in Windows command prompt: [GoW](https://github.com/bmatzelle/gow/releases)
 - Just get a whole Linux on Windows: [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) 
   with Debian or Ubuntu
 - The [7-Zip](https://www.7-zip.org/) archive tool might help for inspecting .tar.gz archives

**Installing Maven on Windows/Mac**

Maven is tricky, because it doesn't come with an installer. Start by
reading the installation instructions, and then cosider:

 - You should unpack the archive outside your Downloads folder.
 - You need to add the "bin" directory to your PATH environment variable.

To change your PATH, try searching for "Add directory to windows/mac/linux path".
