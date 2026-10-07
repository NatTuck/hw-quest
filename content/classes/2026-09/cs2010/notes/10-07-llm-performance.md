---
title: "cs2010 Notes: 10-07 LLM Performance"
date: "2026-10-05"
---

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

## Multimodal Models

- Images
- Audio


