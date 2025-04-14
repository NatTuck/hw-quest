---
title: "cs2370 Notes: 32 AI"
date: "2025-04-09"
---

```bash
conda install transformers timm pillow
```

Now to install Pytorch for the appropriate hardware

https://pytorch.org/get-started/locally/

- For the lab computers, we pick CUDA.
- Which version? ```nvcc --version```
- We need to use pip here rather than the conda
  command. Mixing them works.

```python
from transformers import pipeline
import time

t0 = time.time()

qa = pipeline("question-answering")

context = """

Leonardo, the leader, is the most disciplined and skilled 
turtle; an expert
swordsman, he wields two katana and wears a blue bandana. Raphael, the
strongest and most hot-headed turtle,[26] wears a red bandana and uses a pair of
sai. Donatello uses his intellect to invent gadgets and vehicles; he
wears a purple bandana and uses a bō staff. Michelangelo is the least
disciplined and most fun-loving, and is usually portrayed as the fastest and
most agile. He wears an orange bandana and uses nunchucks.

"""

question = "Which turtle wears a red bandana?"

answer = qa(question=question, context=context)

t1 = time.time()
print("runtime:", round(t1-t0, 2))

print(answer)
```

Next, operating on images:

https://www.wallpaperflare.com/static/906/824/973/digital-art-wolf-moon-three-wallpaper.jpg


```python
from transformers import pipeline
from PIL import Image

img = Image.open("/home/nat/Pictures/digital-art-wolf-moon-three-wallpaper.jpg")

od = pipeline('object-detection')
result = od(img)

print(result)
```

Then:

```python
from transformers import pipeline
from PIL import Image

vqa = pipeline(model="dandelin/vilt-b32-finetuned-vqa")

img = Image.open("/home/nat/Pictures/digital-art-wolf-moon-three-wallpaper.jpg")

answer = vqa(question="How many wolves are there?", image=img)
```

## Jupyter Notebook

This semester we’ve written a bunch of python code. We’ve primarily written and run our programs in IDLE, but we’ve also tried running our programs from the command line. This makes a lot of sense when the point of the program is primarily to create a completed program that can then be run repeatedly.an image generation example:

Today I want to demonstrate another way to look at writing Python programs that makes sense for situations where:

- A core purpose of the program is to have other people look at the code in order to communicate (e.g. a scientific paper).
- The code will produce one output and the only reason to re-run it is to confirm that output.
- You’re exploring in a way that interactive programming is useful.

New tool: [Jupyter Notebook](https://jupyter.org/)

Install and run with:

```bash
$ conda activate
$ conda install jupyter
$ jupyter-notebook
```

Then File -> New Notebook.

- Cell -> Markdown
- '# Hello Notebook'
- Cell -> Code
- ```x = 10 + 20```
- Cell -> Code
- ```x```
- Cell -> Code

```python
from PIL import Image
image = Image.open("duck1.jpg")
image
```

Another cell

```python
image.rotate(180)
```

Notes

- File -> Export as PDF
  - Deps:
  - Linux: apt-get install texlive texlive-xetex
  - Windows: choco install texlive
  - Mac: brew install texlive
- File -> Export as HTML




