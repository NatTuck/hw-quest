---
title: "cs4140 Notes: 11-14 LLMs, Part 3"
date: "2025-11-12"
---

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

## Example App: Eats

Eats: <https://github.com/NatTuck/eats-2025>

Lang Chain Elixir: <https://hexdocs.pm/langchain/custom_functions.html>
