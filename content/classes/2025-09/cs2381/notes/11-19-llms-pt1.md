---
title: "cs4140 Notes: 11-19 Local LLMs"
date: "2025-11-17"
---

## Intro

A topic that's worth seeing is writing code that *uses* LLMs.

## LLMs, Basics

- LLMs are big neural networks.
- They predict the next word. More accurately, next token.

Neural Nets:

- A DAG, representing a series of operations on tensors, with weights.
  - Example: multiply everything by 0.73
- Weights tend to be normalized to the range -1..1

LLM sequence:

- Vector (array) of words.
- Use dictionary (maybe 100k entries) to translate to vector of tokens.
- That gets translated to a vector of embeddings, each of which is a tensor.
- Wait, tensor?
  - A scalar is one value.
  - A vector is a 1D array of values.
  - A Matrix is a 2D array of values.
  - A tensor is an N-D array of values, for any N.
- Then the rest of the neural net is trained to predict a next token, which is
  then added to the input, repeat until done.

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
- "Quantization" is when you approximate higher precision with fewer bits, for
LLMs this tends to be sophisticated lossy compression.
- The number is approximately how many bits per weight.
  - fp16/bf16 is 16 bpw
  - int8 is 8 bpw
  - Q8_0 is 8 integer bits per weight.
  - Q4_0 is 4 per weight.
  - Q8_K / Q_4K is a more accurate block method.
  - FP8 is 8 FP bits per weight.
  - mxfp4 is a recent 4-bit floating point block method.
- Quality of quants:
  - 16 bit is full
  - 8 bit is good
  - 4 bit is okay
  - Less tends to be pretty bad
  - Down to 4 bpw, a more weights tend to be better than fewer weights with more
  bpw.

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

## Dense vs. MoE Models

Qwen 32B (dense) vs. Qwen 30B A3B (MoE)

The Mixture of Experts needs enough RAM to load the whole thing,
but requires less compute and memory bandwidth for a given token
rate.

Typically uses more RAM and less compute for a given level of quality.

## How to build programs that use LLMs

Very small models can be embedded in your program.

For larger models, load times mean you probably want to have the model already
running and accessible via API.

### Running an API Server

- Llama.cpp
- Python ecosystem: vLLM
- These both expose an OpenAI-compatible API by default, the same as services
like OpenRouter, so how you structure your app is the same in both cases and
you can even switch back and forth.

### Why Service vs. Running it yourself?

Why service?

- Simple setup
- Cheap to get started
- Access to very high end hardware when needed
- If you give up on the project, you lose $6.28 in left over
  OpenRouter credits.
- Don't have to worry about hardware hosting, including power
  and network issues.

Why run it yourself?

- Get to pick exactly which model you want.
  - Pick your quant.
  - Pick your finetune, avoiding "safety" stuff that otherwise could lead to
  unwanted rejections even on typical use cases.
- No throttling, up to the throughput of your hardware.
- No per-request cost. This reduces friction of trying stuff, especially stuff
that could do a thousand requests.
- You control the logs.
- Can have hardware on-premise, for performance / privacy / compliance.

Compromise: VPS with GPU or similar

- These tend to be dollars per hour.
- Best for short term experimentation or occasional training runs.

### What do we do with it?

- Functions that need language understanding.
  - Unstructured outputs.
  - Structured outputs.
- Multi-stage workflows with tool calling.
- Agents.
