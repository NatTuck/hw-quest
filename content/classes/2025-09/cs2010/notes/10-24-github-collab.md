---
title: "cs2010 Notes: 10-24 Github Collab"
date: "2025-10-22"
---

## Collabortion with Github

The key feature of source control systems like Git is the ability to
efficiently, asynchronously, collaborate with other people.

Q: Collaborate on what?

A: Anything that's mostly stored as plain text files.

### What is and isn't "plain text"?

- Plain text is stuff you can edit with a programming text editor.
- So source code in most programming languages, HTML, etc.
- Not stuff like Microsoft Word documents.

### Why "mostly plain text"?

- Git is optimized to efficiently track different versions of text files.
- All it can do with non-text is store whole files, and it keeps every version
for as long as the repository exists.
- That's okay for a few small binary files (like the image in the homework), as
long as they don't change frequently.

## What's the typical collaboration work flow on Github?

- Someone starts a project, makes a github repo.
- <https://github.com/fogcloud/workflow-demo>
- Each collaborator presses the "fork" button on that initial github
  repo, which makes a copy linked to the origional.
- Each collab clones to local machine.
- Feature branch
- Change, good commit message.
- Pull request
- Repo owner (or team member) reviews and merges.
- Problem: Merge Conflicts

Next: **demo**

## Project types: Computer Programs

- Typical: Programs with many files.
- Also: A directory of many programs.

## Project types: Not Computer Programs

- Web sites; homework.quest is built with a SSG and Markdown.
- Academic papers; in math and CS, frequently use LaTeX.
- Many things can be done with "code".
- Another big advantage to working with text-based formats:
  LLMs can understand and produce it.
