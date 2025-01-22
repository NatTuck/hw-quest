---
title: "Required Software for cs2370"
date: "2025-01-08"
---

For this semester we will be using the Python programming language as
well as several libraries and tools installable through the
Conda-Forge package manager.

Working on a Linux machine is recommended, although this software can
be used on Mac or Windows.

To install on your local machine:

 - First, run the [conda forge](https://conda-forge.org/) installer.
 - That will give you the "conda" command in your system command
   prompt.

From there, install the following packages using conda:

```
conda activate
conda install -y spyder
conda install -y pytest
conda install -y mypy
conda install -y pyglet
conda install -y spyder-unittest
```


To run python code in this class:

```
conda activate
python your-code.py
```

To run the spyder IDE:

```
conda activate
spyder
```

To test your code:

```
conda activate
pytest your-code.py
mypy your-code.py
```
