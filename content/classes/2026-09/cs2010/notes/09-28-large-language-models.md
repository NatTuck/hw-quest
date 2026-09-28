---
title: "cs2010 Notes: 09-28 Large Language Models"
date: "2026-09-26"
---

## Large Language Models

**Computing**

- Computing is pretty old at this point
- Most major modern computer concepts were around by 1970.
- By 1990, we had massively parallel supercomputers with graphic user interfaces
that could do real-time 3D rendering, etc.

**Artificial Intelligence**

- Since the earliest computers existed, fiction has shown computer-based robots
that you can have a conversation with.
- MIT opened its AI lab in 1959.
- That's one year after the first neural network type machine learning algorithm
was described.

As of 1995, there were a bunch of major unsolved problems that made sci-fi
robots seem unlikely. Three key examples:

- Computers couldn't beat humans at chess.
- You couldn't write a computer program that could reliably tell the difference
between a picture of a cat and a picture of a dog.
- No program had passed the Turing test - being indistinguishable from a human
to a human in a text-based chat.
- Today you can run a human-beating chess engine on your phone, built out of
neural network assisted tree search.

All of these have since been accomplished:

- In 1997, a computer program first beat the sitting world chess champion.
- In 2005, a top human player *last* credibly beat a top chess program.
- In 2007, cats vs. dogs was a viable CAPTCHA - humans could do it, computers
were basically just guessing.
- In 2008, it wasn't good enough. Computers could be 80% accurate per image with
convolutional neural networks.
- In 2013, there was a big contest where competitors got 99% accuracy.
- Now cats vs dogs is a standard undergrad Machine Learning homework.
- The most famous early chatbot was ELIZA, from 1966. Some neat tricks made her
mildly convincing.
- There was a Turing test competition (the Loebner Prize) from 2003 to 2019.
Nobody won the major prize for a program convincing the judges it was human.
- In March 2025, GPT 4.5 convinced 73% of judges it was more human than a real
human. GPT 4.5 is a large language model. GPT stands for generative pre-trained
transformers, which are another kind of neutral network initially presented by
Google researchers in 2017.

## What's a Large Language Model?

**What is a model?**

- A description of a system that allows us to make predictions.
- We can also think of a model as a mathematical function.

Sample problem:

Alice goes to the bar every night and buys everyone there a beer.

On Monday, there were 3 people and her bill was 15 dollars. Tuesday, 8 people,
40 dollars. On Wednesday, 5 people, 25 dollars. On Thursday there are 6 people,
how much will her bill be?

What kind of model? Linear function. How many parameters? One.

**Large Language Model**

- Given a bunch of words, which word comes next?
- It's not a linear function, it's a deep neural network.
- Turns out this recognizably works at 100 million parameters, can get pretty
useful at about 10 billion parameters, and scales to at least a couple trillion.

## LLM Core Operations

An LLM consists of:

- Token dictionary
- Weights
- Model architecture

LLM operation:

- Translate the input into tokens. A token is some string of characters
represented by a number. Typically, one word or symbol is one token.
- Example: 1 = aardvark, 2 = Aaron, 2 = aardwolf, 4 = abacus, etc.
- That gives a sequence of numbers.
- Then there's a bunch of matrix math. One of the key ideas is attention, where
a relationship is calculated between each token and every previous token.
- Exactly how the matrix math works (and how the weights are split up into
layers, etc) is determined by the model archetecture.
- The result is one next token.
- Stick that on the end of the input, run again, repeat until you get an "end of
output" token.


## Training

Like any ML model:

- The developers pick a architecture.
- They start with random weights.
- They get a *huge* amount of example data, in this case text.
- They pass the first token forward through the model, it predicts a (completely
  wrong) next token.
- Going backwards through the model, the direction of wrongness is determined.
Is the weight too low or two high.
- The weight is nudged slightly in the correct direction.
- Repeat with the next token of the training data.
- You want 20+ tokens per parameter of training data, with some major
models having been trained on a thousand tokens per parameter (so a model with
10B parameters might be trained on 10T tokens of data).
- Training in just English works fine, but multiple languages works fine and
training in one language improves performance in others too.

Training phases:

- Initially a "base"j model is trained, that just predicts continuation of
sequential text.
- For a chatbot, you want it to predict text within a turn-based chat sequence
and thus respond to a user's prompts. This is done in a second training/fine
tuning round that produces an "instruct" variant.
- After that, variants can be created through additional training. For example,
you could take an existing model and train it to talk like a pirate.


## Conversation Protocol

Nest demo, chat, Qwen 3.8, thinking off.

- System prompt.
- User / assistant alternation.
- Show API messages, talk about JSON.

Nest demo, Coding, Qwen 3.8, thinking on.

- Thinking tokens.
- Tool calls.
- Tool specifications.
- API details.


## What can we do with tools?

- Write markdown files.
- Use Pandoc to convert markdown to PDF.
- Write simple computer programs.


## Running LLMs

LLMs run on computers. You need a program (an inference engine) that will load
the model and run it.

How big an LLM can you run?

- LLMs have some number of weights (parameters) (e.g. 4B, 397B-A17B)
- A full size weight is a 16 bit floating point number, so one weight
"naturally" takes 2 bytes to store.
- Weights can be "quantized", or stored with less detail, without messing things
up too much. Models are typically run in quantized mode with 8 bits per weight
for good quality or 4 bits per weight for okay quality.
- At 8 bpw, 1 weight = 1 byte, so a 4B model takes ~4GB.
- At 4 bpw, 2 weights = 1 byte, so a 4B model takes ~2GB.

To run fast, you want weights to fit in video memory.

You also need to fit something else in video memory: KV cache. That's the
already-processed active conversation, so every new chat turn doesn't need
to reprocess the whole thing from the beginning.




