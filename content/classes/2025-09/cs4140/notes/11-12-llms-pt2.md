---
title: "cs4140 Notes: 11-12 LLMs, Part 2"
date: "2025-11-10"
---

## Intro

One of the requests in the midterm report was on how to write code
that uses LLMs.

- Last time, we talked about what LLMs are.
- Today, we'll talk about running LLMs.
- Next time, we'll talk about writing code that uses LLMs.

## How big a model

- Very small: Under 5B weights
  - Useful for very limited language processing.
  - Great to fine tune.
  - Can run basically anywhere: In a browser on a phone,
    on a small SBC, etc.
- Small: Under 25B
  - Can be good for straightforward, well defined tasks.
  - Useful to fine tune.
  - Can run on typical computers, or run fast on a gaming GPU.
- Medium: Up to ~70B
  - Generally useful
  - Needs "pro" hardware to run (~ $2000)
- Large: Under 200B
  - Stretches to more complicated tasks.
  - Needs higher end "pro" hardware to run (~ $4000)
- Very large: Over 200B
  - Most proprietary "frontier" models are in this category.
  - Needs a decent sized server to run slowly, or $100k of
    GPUs to run fast.

## Dense vs. MoE Models

Qwen 32B (dense) vs. Qwen 30B A3B (MoE)

The Mixture of Experts needs enough RAM to load the whole thing,
but requires less compute and memory bandwidth for a given token
rate.

Typically uses more RAM and less compute for a given level of quality.

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

**Unified Memory APU**

Devices like the Mac Pro or AMD Strix Halo provide extra compute and
memory bandwidth compared to a typical CPU.

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
