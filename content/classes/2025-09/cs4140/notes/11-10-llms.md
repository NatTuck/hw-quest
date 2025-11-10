---
title: "cs4140 Notes: 11-10 LLMs, Part 1"
date: "2025-11-08"
---

## Intro

One of the requests in the midterm report was on how to write code
that uses LLMs.

To set up for that, I want to spend a lecture talking about what
LLMs are and how to run them.

## LLMs, Basics

(This overall story is similar to reality, but no promises that I
got any of the specifics right.)

Tokens:

- Text is represented as a series of numbers.
- This uses a dictionary based on expected inputs.
  - aardvark 0
  - abacus 1
  - abandon 3
- Not necessarily 1 word = 1 token. Could add "-s (plural)" token
  so "aardvark" becomes (aardvark) (-s plural). Same thing for "ing",
  etc.

How big a dictionary? Maybe 100k tokens. For comparison, there are maybe 30k
reasonably common English words, so a lot of the tokens are non-word symbols,
partial words, etc.

Tensors:

- One value is a scalar.
- A row of scalars is a vector.
- A 2d array of scalars is a matrix.
- Generalizing that to N dimensions gets you a tensor.

Neural Nets:

- A DAG, representing a series of operations on tensors, with weights.
  - Example: multiply everything by 0.73
- Weights tend to be normalized to the range -1..1

Embedding:

- The sequence of tokens is first fed through a neural net intended to translate
(token, position) pairs into embeddings, or tensors that encode token
similarity.
- For example, "dog" and "wolf" might have very similar embeddings, but "dog"
would be more similar to "pet" and "wolf" would be more similar to "wild".

Next token prediction:

- Then the collection of embeddings (a tensor of one more dimension) becomes the
input to a next token prediction network.
- This outputs one token, the next token.
- Sending that through the embedding network generates a new input tensor for
the prediction network, etc.

Training:

- Generate a random weight deep neural net.
- Take a training text, and feed the first token through the process.
- Calculate the difference between the predicted next token and the
  correct next token (e.g. the second token of the training text), and
  slightly change the weights of the last layer of the neural net to get
  closer.
- For the previous layer, calculate the partial derivative and slightly
  change the weights in the correct direction.
- Back-propagate all the way.
- Repeat until out of training text.

Inference:

- Just run the network forward and take the output tokens it generates.

## How big a neural network?

The size of the network, specifically the number of weights, is a key
metric for LLMs.

A small model might have 350M weights (e.g. Granite 4.0 350m), while a very
large model (e.g. Kimi K2 or one of the premium proprietary models) might have a
trillion.

Weights are naturally stored as floating point numbers, which would make them 4
bytes each. That turns out to be overkill, so typically a half-precision
(16-bit) float is the standard for "full precision" LLM weight storage.

That means that a "32B" model, with 32 billion weights, would take 64 GB of RAM
or disk space to store at full 16-bit precision.

## Quantization

- Full precision is 16-bits, or 2 bytes per weight.
- "Quantization" is when you approximate higher precision with fewer bits.
- This can just be going from a 16-bit float to an 8 or 4 bit float.
- But, in the context of LLMs, quantization is typically a bit more complicated
and is effectively a data-specific compression mechanism.
- The common method is block-based quantization.
- Simplest version:
  - Store an fp16 block minimum.
  - Store an fp16 block maximum.
  - Store a block of 32 or 256 lower precision weight differences, which say
  where between the min and max that particular weight is.
  - Nearby weights tend to be similar, so this gives pretty accurate values.
- Common quantizations:
  - Q8_0 is 8 integer bits per weight.
  - Q4_0 is 4 per weight.
  - Q8_K / Q_4K is a more accurate block method.
  - FP8 is 8 FP bits per weight.
  - mxfp4 is a recent 4-bit floating point block method.
- Size:
  - fp16 is 2 bytes / weight.
  - Q8 is 1 byte / weight.
  - Q4 is 2 weights / byte.
- Typically;
  - Any 8 bit quant is going to be pretty close to full quality.
  - A 4 bit quant is about as low as you can go without getting bad.
  - Fancier blocking methods do better, with K being better than 0.
  - Beyond that, bigger is better. So Q6 would be better than Q5,
    both somewhere between Q4 and Q8.
  - Powers of two tend to be faster.

## How to run a language model

**GPU**

Language models like to run on a GPU, but they need to fit in VRAM.

**CPU**

They run slower on CPU, but this can allow running larger models.

**Bottlenecks**

LLM evaluation is intensive in both matrix math and memory bandwidth. GPUs are
typically faster at both, but modern server CPUs can be pretty good too.

**With Python**

Search huggingface. Let's try qwen3-0.6B

You can quantize these, but I haven't fought with it enough.

**With llama.cpp**

See <https://huggingface.co/unsloth/Qwen3-0.6B-GGUF>

(Other options are frequently either Python or llama.cpp in disguise.)

Let's try some llama-bench with common models on laptop and then CPU/GPU on a
server.

Let's try some test prompts for each to see how those benchmarks feel.

## APIs

llama-server gives us a HTTP API, compatible with the OpenAI api.

This means we can use it or something like OpenRouter interchangably.

We'll look at this more on Wednesday.

## Running in browser

Show <https://github.com/NatTuck/bchat> and bchat.fogcloud.org
