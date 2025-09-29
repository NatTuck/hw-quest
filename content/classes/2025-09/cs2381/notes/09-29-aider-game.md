---
title: "cs2381 Notes: 09-29 Vibe Coding with Aider"
date: "2025-09-24"
---

## Today, we're going to build Missile Command

For simplicity, we'll start with the starter code for Lab 05, largely
because that lab already opens a graphics window.

### Aider Install and Setup

- Need Python and Git
  - On Debian family linux:
    - `sudo apt install python-is-python3 pipx git build-essential`
    - `pipx install aider-chat`
  - On Windows / Mac: 
    - https://python.org/
    - https://git-scm.com/
    - https://aider.chat/
- Get an OpenRouter API key
  - https://openrouter.ai/
  - Give them $10 for credits; this both allows the use of premium models,
    and marks your account as paid which may make free models cheaper.

Aider config file (~/.aider.conf.yml):

```yaml
api-key: OPENROUTER=sk-or-v1-[...]
model: openrouter/qwen/qwen3-coder
edit-format: diff
weak-model: openrouter/qwen/qwen-turbo
```


- Create new git repo:
  - `git init .`
- In the repo directory, run aider (`aider`)

Then we can start chatting with our AI dev buddy.

### Key Ideas: Context and Messages

Aider works by sending a chat message with some extra data about
our project, including a portion of the existing source code.

- /read-only path/to/file.java   # Aider sends a copy to the LLM, but can't modify this
file.
- /add path/to/file.java         # Aider sends a copy to the LLM, which can chose to modify this file.
- /ask Question...               # Aider should send a message and modify
nothing.
- Instructions                   # Aider should make a change to the code.


So let's write Missile Command...











