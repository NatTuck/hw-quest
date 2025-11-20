---
title: "cs4140 Notes: 11-21 Using LLMs"
date: "2025-11-19"
---

## We want to use an LLM from our app

Two choices:

- Embed in app
  - Python Transformers or port (e.g. Transformers.js)
  - llama.cpp library
- Call out to an API endpoint.
  - Llama.cpp
  - Python ecosystem: vLLM
  - Both are OpenAI API compatible

## Embedding example: Running in browser

Show <https://github.com/NatTuck/bchat> and bchat.fogcloud.org

## Example: HW Starter Code

Start by downloading the HW13 starter code.

To enable logging:

```xml
    <dependency>
      <groupId>org.slf4j</groupId>
      <artifactId>slf4j-simple</artifactId>
      <version>2.0.17</version>
    </dependency>
```

Or we can disable by instead including:

```xml
    <dependency>
      <groupId>org.slf4j</groupId>
      <artifactId>slf4j-nop</artifactId>
      <version>2.0.17</version>
    </dependency>
```

Now let's run the starter code.

## Sample Problem: Count ducks in photo

Sample problem:

-

## What do we do with it?

- Functions that need language understanding.
  - Unstructured outputs.
  - Structured outputs.
- Multi-stage workflows with tool calling.
- Agents.
