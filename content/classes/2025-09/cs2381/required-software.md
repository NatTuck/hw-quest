---
title: "cs2381: Required Software"
date: "2025-08-01"
---

[&larr; Back to Course Site](../)

To do class assignments on a computer, you'll need several things:

 * The Java Development Kit
 * The Maven build tool
 * A properly configured programming editor
 * On Windows, several other tools are recommended

## Installing the Java Development Kit

For this class we want version 17 of OpenJDK.

Later versions will work, earlier ones may not.

**Linux (Ubuntu, Debian, Mint, or related)**

```bash
sudo apt install openjdk-17-jdk
```

**Windows / Mac**

 - Download the appropriate package for your OS from 
   https://adoptium.net/temurin/archive/?version=17
 - Install as normal for your OS.
 - If on Mac, make sure you know whether your machine is amd64 or
   aarch64 and pick the right package.

## Installing Maven

**Linux (Ubuntu, Debian, Mint, or related)**

```bash
sudo apt install maven
```

**Windows / Mac**

 - Visit the [Apache Maven](https://maven.apache.org/) website.
 - Follow the directions to install.
 - There is no simple installer program, so you will need to
   read the instructions and possibly search for details about
   how to accomplish individual steps.
 - The current release version should be fine.

## Installing an Editor

**A Basic Programmer's Editor**

For this class, a traditional programming editor is recommended.

 - [Notepad++](https://notepad-plus-plus.org/), 
   [Bluefish](https://bluefish.openoffice.nl/index.html)
 - On Linux, Kate
 - [Neovim](https://neovim.io/), 
   [Emacs](https://www.gnu.org/software/emacs/) (
   [Spacemacs](https://github.com/syl20bnr/spacemacs),
   [Doom Emacs](https://github.com/doomemacs/doomemacs) )

You want to make sure your editor is intended for programming and
provides syntax highlighting. I recommend turning any autocomplete
functionality off.


**Visual Studio Code**

If you want to fight with a more complex editor that mostly makes things harder,
you can consider VSCode.

Once you've installed it, it needs some configuration. First, install
"Extension Pack for Java". Then, press Press F1, type "> open user
settings" and select "Open User Settings (JSON)". Paste in the
following blob as the complete config file:

```json
{
    "editor.quickSuggestions": { "other": false, "comments": false, "strings": false },
    "editor.acceptSuggestionOnEnter": "off",
    "editor.quickSuggestionsDelay": 10,
    "editor.wordBasedSuggestions": "off", 
    "editor.parameterHints.enabled": false,
    "editor.suggestOnTriggerCharacters": false,
    "editor.autoClosingBrackets": "never",
    "editor.autoClosingQuotes": "never",
    "java.inlayHints.parameterNames.enabled": "none",
}
```



## Other Software for Windows

Both Linux and Mac provide reasoanbly complete terminal environments
by default. On Windows, installing some extra stuff helps. Perl
especially will allow you to run the test script locally.

 - [Strawberry Perl](https://strawberryperl.com/) (>= 5.32 64 bit)
 - Linux commands in Windows command prompt: [GoW](https://github.com/bmatzelle/gow/releases)
 - Just get a whole Linux on Windows: [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) 
   with Debian or Ubuntu
 - The [7-Zip](https://www.7-zip.org/) archive tool might help for inspecting .tar.gz archives

