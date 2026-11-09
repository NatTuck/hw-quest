---
title: "cs2010 Notes: 11-09 Introducing APIs"
date: "2026-11-02"
---

## Computer Interfaces

**User Interfaces**

- Graphic User Interface
- Command Line Interface
- Talk to an LLM

**Programmer Interfaces**

(Programmers are kind of like users.)

- Command Line Interface -> Script

Those are all fancy ways to run code in existing 
computer programs. The next option is:

- Writing Computer Programs

**Application Programming Interface**

User interfaces are a way for a person to ask a program
to do stuff.

An API is a way for a program to ask another program
to do stuff.

Lots of programs expose APIs:

- A computer operating system exposes APIs that let programs
running on it do stuff (otherwise, they couldn't do much).

- A network server exposes an interface over a network, which
allows for programs on other to interact with it.

## Let's Build a Weather App

Plan:

- Pull weather
- Change reference image to match weather
- Call text gen API with multimodal LLM for ti2i prompt, passing in the image,
and requesting it be change to match the time, season, and weather report.

Plymouth NH ZIP is 03264, 43.7589° N, 71.6892° W

https://www.weather.gov/documentation/services-web-api

[panther-snow.jpg](../panther-snow.jpg)

Openrouter, Models, Image (tab), Qwen Image 2.1 Turbo

API key env var (will last for the terminal session):

```
export OPENROUTER_API_KEY=sk..."
```

Doing one run takes like 20 seconds.

The example (t2i.ts), modified to use an env var API key:

```ts
import { mkdir, writeFile } from "node:fs/promises";

const apiKey = process.env.OPENROUTER_API_KEY;
if (!apiKey) {
  // Bun loads .env automatically; with Node use: node --env-file=.env
  console.error("OPENROUTER_API_KEY is not set");
  process.exit(1);
}

const response = await fetch("https://openrouter.ai/api/v1/images", {
  method: "POST",
  headers: {
    "Authorization": `Bearer ${apiKey}`,
    "Content-Type": "application/json",
  },
  body: JSON.stringify({
    model: "qwen/qwen-image-2.1-turbo",
    prompt: "A serene mountain landscape at sunset with dramatic clouds",
  }),
});

const result = await response.json();
await mkdir("./output", { recursive: true });
for (const [i, image] of (result.data ?? []).entries()) {
  const path = `./output/image-${i}.png`;
  const bytes = Buffer.from(image.b64_json, "base64");
  await writeFile(path, bytes);
  console.log(`Wrote ${path} (${bytes.length} bytes)`);
}
```

Then example modified to have a reference image (ti2i.ts):

```ts
import { mkdir, readFile, writeFile } from "node:fs/promises";
import { extname } from "node:path";

const MIME_BY_EXT: Record<string, string> = {
  ".png": "image/png",
  ".jpg": "image/jpeg",
  ".jpeg": "image/jpeg",
  ".webp": "image/webp",
  ".gif": "image/gif",
};

const DEFAULT_PROMPT =
  "Apply warm, painterly sunset light to the reference image, keeping its composition and subject unchanged.";

const [refPath, prompt = DEFAULT_PROMPT] = process.argv.slice(2);
if (!refPath) {
  console.error("Usage: bun qwen21t-img2img.ts <reference-image> [prompt]");
  process.exit(1);
}

const mime = MIME_BY_EXT[extname(refPath).toLowerCase()];
if (!mime) {
  console.error(
    `Unsupported reference image type: ${refPath}. Use one of: ${Object.keys(MIME_BY_EXT).join(", ")}`,
  );
  process.exit(1);
}

const apiKey = process.env.OPENROUTER_API_KEY;
if (!apiKey) {
  // Bun loads .env automatically; with Node use: node --env-file=.env
  console.error("OPENROUTER_API_KEY is not set");
  process.exit(1);
}

const refBytes = await readFile(refPath);
const refUrl = `data:${mime};base64,${refBytes.toString("base64")}`;

const response = await fetch("https://openrouter.ai/api/v1/images", {
  method: "POST",
  headers: {
    "Authorization": `Bearer ${apiKey}`,
    "Content-Type": "application/json",
  },
  body: JSON.stringify({
    model: "qwen/qwen-image-2.1-turbo",
    prompt,
    input_references: [{ type: "image_url", image_url: { url: refUrl } }],
  }),
});

if (!response.ok) {
  const body = await response.json().catch(() => ({}));
  console.error(`HTTP ${response.status}: ${body?.error?.message ?? "request failed"}`);
  process.exit(1);
}

const result = await response.json();
await mkdir("./output", { recursive: true });
for (const [i, image] of (result.data ?? []).entries()) {
  const ext = image.media_type?.split("/")[1] ?? "png";
  const path = `./output/image-${i}.${ext}`;
  const bytes = Buffer.from(image.b64_json, "base64");
  await writeFile(path, bytes);
  console.log(`Wrote ${path} (${bytes.length} bytes)`);
}
```

From here, we'll generate an app with vite...

