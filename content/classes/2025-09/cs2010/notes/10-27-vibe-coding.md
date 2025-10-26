---
title: "cs2010 Notes: 10-27 Vibe Coding"
date: "2025-10-25"
---

## Vibe Coding Turtle Programs

### Vibe Coding Example

- Get a turtle, get a terminal in its disk directory.
- Clone the git repo from <https://github.com/NatTuck/turtles25>
- Run aider
- Note that Aider needs a git repo to work in.
- Do the sample prompt.
- Spend some effort debugging it.
- Note that the LLM is really good at copying stuff and understanding
  PL syntax, but it has no eyes and will only do spacial reasoning if
  we give it strong hints.

### Setting Up Aider

(If you run into trouble, try talking to [Google Gemini](https://aistudio.google.com).
Explain what your doing and went wrong including copy/pasting error messages.
Then carefully read and understand the response, asking further questions to
clarify anything that's unclear.)

- First, you need a modern terminal environment.
  - Linux / Mac support this very well.
  - On Windows: PowerShell should work.
- Then you need Python installed.
  - On Linux: `sudo apt install python-is-python3`
  - Windows / Mac: <https://www.python.org/>, follow instructions to install.
- Then you can install Aider.
  - [https://aider.chat/](https://aider.chat/)
  - Click "Getting started", follow instructions.
- Then you'll need to set up an OpenRouter key.
  - [https://openrouter.ai/](https://openrouter.ai/)
  - Create a key, put it in your Aider config file.
  - Buy $10 in credits.
- Configure your model.
  - Let's look at OpenRouter / Models / Programming
  - Note some prices, then look at "free".
  - I've been using Qwen Coder recently, but I probably should try out
    others like GLM and Grok Code Fast.
