---
title: "cs2010 Notes: 09-23 Text Files and Git"
date: "2026-09-16"
---

## Computing Fundamentals

- We know how text is stored on a computer.
- We know about text files.
- We know about Git.

So now I can explain the fundamentals of computing and using a computer
for some productive purpose:

- You make text files.
- You store them in a Git repository.

One major exception: Multimedia

- If you need to hear audio or see visuals, you'll need to deal
with non-text files that probably aren't stored in Git.
- Your workflow probably should still have a lot of text/git, but
it can't be entirely text/git.


## Plain text compared to what?

**HTML is plain text**

```html
<!doctype html>
<html>
  <head>
    <title>Hello, Web</title>
  </head>
  <body>
    <h1>Hello, Web</h1>
    <p>This is a web page</p>
  <body>
</html>
```

**What about MS Word?**

- Create test doc.
- Download it.
- `file x.docx` shows MS Word Document
- But it's really a zip archive.
- `unzip x.docx`
- cat word/document.xml
- `sudo apt install libxml2-utils`
- xmllint --format word/document.xml

**What about pictures?**

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 400" width="100%" height="100%">
  <!-- 1. Head -->
  <circle cx="200" cy="200" r="175" fill="#FFCC00" />

  <!-- 2 & 3. Rosy Cheeks -->
  <circle cx="95" cy="235" r="28" fill="#FF2A6D" />
  <circle cx="305" cy="235" r="28" fill="#FF2A6D" />

  <!-- 4 & 5. Eyes -->
  <ellipse cx="140" cy="165" rx="18" ry="26" fill="#111322" />
  <ellipse cx="260" cy="165" rx="18" ry="26" fill="#111322" />

  <!-- 6. Mouth Interior -->
  <path d="M 135 220 Q 200 330 265 220 Q 200 235 135 220 Z" fill="#111322" />

  <!-- 7 & 8. Vampire Fangs -->
  <polygon points="160,223 182,225 171,262" fill="#FFFFFF" />
  <polygon points="218,225 240,223 229,262" fill="#FFFFFF" />
</svg>
```

**And a really amazing format: Markdown**

```md
# The Three Little Pigs

## Chapter 1

Once upon a time there were three little pigs.

[Three Little Pigs](https://en.wikipedia.org/wiki/Three_Little_Pigs)
```

```bash
pandoc -o pigs.html pigs.md
```


## Why Source Control

- Tracking changes over time
  - https://github.com/NatTuck/hw-quest/blob/master/content/_index.md
  - History
- Multi-user collaboration
  - https://github.com/NatTuck/inkfish/pull/90


## Git / Github Collaborative Workflow

- Start a project.
- Grab that SVG
- Initialize a git repository.
- Make a change.
- Commit
- Make a Github repo
- Push
- Clone to a second checkout.
- Make a feature branch
- Make a change
- Commit
- Push
- PR

We should probably do some of this later, but that's the key idea.
