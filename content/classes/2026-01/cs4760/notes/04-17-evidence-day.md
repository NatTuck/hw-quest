---
title: "Notes: 04-20 Evidence Day"
date: "2026-04-18"
---

## Upcoming Stuff

- Make it or break it evidence, due today.
- On Wednesday, the CS&T faculty will meet and determine if we think you're
prepared present next week.
- Next week: Final Presentations on Thursday and Friday evening (Figure 4-7pm
both nights, with a good chance of finishing early). I haven't gotten any emails
about specific days, make sure to email me if you need a specific day.
- Schedule questions?

## Agentic Job Search

<https://github.com/nousresearch/hermes-agent>

- This is an agent tool (like OpenClaw, IronClaw, etc).
- It's a program you run on a concrete computer (desktop, VPS)
- You hook it up to an LLM
- It maintains persistent storage:
  - Full message history in a sqlite db with full text search
  - A MEMORY.md file with startup memories that will help it
    figure out what context to load up in new chats.
- It can do stuff using two mechanisms: Tools and Skills

### Tools

Tools are local functions the LLM can call as a response.

For Hermes, these typically run Python scripts, on the host
computer.

Here's an example tool call the LLM can run:

```
memory(action="replace", target="memory",
       old_text="dark mode",
       content="User prefers light mode in VS Code, dark mode in terminal")
```

Stuff that's built in:

- Arbitrary shell commands on the host computer.
- That includes setting cron jobs.
- Web requests.

Stuff that it can do with API keys:

- Web search

### Skills

Tools like running arbitrary shell commands are very powerful, but it can take
an LLM a bit to figure out how to do stuff. A skill is a markdown file that:

- Describes how to do a related set of tasks.
- Is listed in the system prompt so the LLM can find it.

Example: TODO list

- This could be a tool, just like the memory tool.
- But it could also just be a skill like this:

```
## Skill: TODO List

We're maintaining a TODO list at ~/TODO.md

- To list tasks, read the file.
- To add an item: Check if it's in the list, then if not just append,
  like `echo "- Buy cat food" >> ~/TODO.md`
- To remove an item, use `grep -v`
```

You can just have the agent write skills out itself.

### The Job Search

I recently helped a friend of mine set up Hermes for a job
search.

There's a directory full of markdown files, managed by a skill.

- A cron job triggers a scraper script each morning, polling a variety of
sources each morning.
- It keeps a list of jobs it finds.
- After the script runs, it triggers the Hermes loop to read the summary, find a
couple of appropriate jobs, and send them to the user in an IM.
- The user can then accept / reject / discuss.
- Rejections update the filter notes.
- Once a job is accepted, Hermes will help with generating draft resume and
cover letter specialized for that job.

### Recommendation

If you want to play with this, get a VPS from a vendor like Vultr:

<https://www.vultr.com/pricing/#cloud-compute>

It'll keep the agent up all the time and limits the security issues
from letting an LLM run arbitrary code on your computer.
