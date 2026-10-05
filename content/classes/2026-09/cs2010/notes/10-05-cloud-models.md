---
title: "cs2010 Notes: 10-05 Cloud Models"
date: "2026-10-03"
---

## Tool Call Demo in Nest

- Show this.

## What can we do with tools?

- We saw this in lab on Monday
- Write HTML, markdown, convert between text formats, etc.
- Use Pandoc to convert markdown to PDF.
- Write simple computer programs.

## Model Size Review

- Model size is # of weights
- Full precision, weights are 16-bit floats
  - That's 2 bytes per weight
- Quantization: smaller weights at a quality decrease
  - 8 bits, nearly full quality (1 byte/weight)
  - 4 bits, decent quality (2 weights/byte)

## Running LLMs

- To pick the next token, need to do math with the previous token and all the
weights.
- That means all the weights need to be in fast memory.
  - Memory bandwidth is the performance limit.
  - Consider 30B dense model with an 8 bit quant:
    - GPU @ 1TB/s memory: 1000/30 = 33.3 tok/s
    - CPU + DDR5 @ 100 GB/s = 3.3 tok/s
  - Consider a 35B-A3B MoE model with an 8 bit quant:
    - GPU @ 1TB/s memory: 1000/30 = 333.3 tok/s
    - CPU + DDR5 @ 100 GB/s = 33.3 tok/s
- But there's a prefill stage first.
  - This runs every token in the prompt against every weight.
  - This ends up being compute bound.
  - A GPU might get us 1000+ tokens/second prefill.
  - CPU + DDR5 might get us 20 tokens/second prefill.
  - Prefill tends to be where compromises like unified memory
  or old GPUs suffer.

## How big are these models? What do they run on?

- Current top is 5+T models like Claude Fable, OpenAI Astra
  - A full rack of servers (draw 3ft by 2ft by 8ft high)
- Below that is 1-3T models like Kimi K3
  - One big server (draw 3ft by 2ft by 2ft high)
- Below that is 200-800B "Flash" models like Deepseek V4.1 Flash
  - One medium server (draw 3ft by 2ft by 2ft high)
  - One maxed out workstation
- Below that is small general purpose models: 25-150B weights, like Qwen 3.8 27B
  - These can run on a small server or nice workstation
  - Small ones can run on absolute maxed out gaming PCs (e.g. RTX 5090)
- Below that is very small models: 0.5-15B weights
  - Run even on old gaming PCs
  - Like we ran in lab yesterday
  - Potentially useful, but mostly you need to tell them exactly what you want
  to get anything useful out of them

## Exploring Performance

- Prompt processing
  - Parallel computation, can run all the prompt tokens
  through the layers of the model at once
  - How much compute power do you have?
  - Really want 1000+ for usability, especially on larger prompts
- Token generation
  - Need to run one token through the whole model
  - How much memory bandwidth do you have?
  - Not too bad at 20+.

GPU vs. Unified Memory vs. CPU

# OpenCode

- Generate markdown
- Translate to PDF
- Fancy up with LaTeX
- Spend $10 on OpenRouter tokens for lab this afternoon now.


