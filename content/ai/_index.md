---
title: "Notes on AI Tools, Mostly LLMs"
date: "2025-01-20"
---

# Web Chatbots

A variety of companies provide some of their most advanced AI models
as interactive web chatbots, mostly for no fee.

Keep in mind:

- These typically require a user account.
- These are good for straightforward questions, but not as good as other
tools for complex multi-step tasks like software development.
- All of these services save all your interactions for a variety of reasons,
including future training data.

Suggestions:

- [Google AI Studio (Gemini)](https://aistudio.google.com) - Good all-around
chatbot, plus some other models.
- [Claude](https://claude.ai/) - The expensive option.
- [OpenAI (ChatGPT)](https://chatgpt.com/) - Popular, probably overrated.
- [Twitter (Grok)](https://twitter.com/i/grok) - Surprisingly good at debugging.
- [Mistral](https://chat.mistral.ai/chat) - From France.
- [Microsoft (Copilot)](https://copilot.microsoft.com/) - The OpenAI models
again.
- [Deepseek](https://www.deepseek.com/en) - From China. A large model.
- [Alibaba (Qwen)](https://chat.qwen.ai/)

## API Coding Tools

Tools:

- [aider](https://aider.chat) - (Recommended) This provides chat-based
programming assistance using various APIs.
- [Cline](https://cline.bot/) if you really like VSCode, then cline provides
a similar workflow as an IDE plugin.

Chat-based tools are strongly recommended over autocomplete-based tools. I
recommend fully disabling autocomplete in your editor; it's a distraction. 

The APIs gateways:

- [OpenRouter](https://openrouter.ai/) - Provides access to a broad variety of
models, both free and paid.
- Google AI Studio, Claude, etc 


## Local AI tools:

 - ollama
 - llama.cpp
 - [Kobold.cpp](https://github.com/LostRuins/koboldcpp) - Chat interface

Running open source models locally provides maximum control, but requires
a pretty powerful PC to run anything but the smallest models.

A decent model to start playing with locally on a 10-16GB GPU is
[Qwen3-14B](https://huggingface.co/Mungert/Qwen3-14B-GGUF).

If you have a new Mac or Ryzen with a lot of unified memory (e.g. 64GB+) you
should be able to run bigger models like
[Qwen3-Coder-30B](https://huggingface.co/unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF).


