---
title: "cs4140 Notes: 22 Integration Tests"
date: "2023-10-13"
---

**Test DB with Prisma**

Set DB URL from an env var.

```
// prisma/schema.prisma
datasource db {
  provider = "sqlite"
  url      = env("DATABASE_URL")
}
```

Set defaults:

```
# .env
DATABASE_URL="file:./jokes-development.db"
```

Create seed script:

```js
// This is prisma/test-seeds.mjs

import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function create_joke(joke) {
  let joke1 = await prisma.joke.create({ data: joke });
  return joke1;
}

(async function() {
  const joke = await prisma.joke.create({
    data: {
      content: "Why did the chicken cross the road? Dunno.",
    },
  });

  await prisma.$disconnect();
})();
```

Create a script to start a test server.

```bash
#!/bin/bash

export DATABASE_URL="file:./jokes-test.db"
npx prisma migrate reset -f
npm exec -- node prisma/test-seeds.mjs
npx next dev
```

**Integration Tests**

Playwright with jokes-next:

 - https://playwright.dev/
 - https://nextjs.org/docs/pages/building-your-application/optimizing/testing#playwright

From jokes-next:

```bash
npm install --save-dev @playwright/test
npx playwright install
```

Setup playwright.config.js:

```
import { defineConfig } from '@playwright/test';

export default defineConfig({
  // Glob patterns or regular expressions that match test files.
  testDir: '__tests__',
  testMatch: '*.spec.js',
});
```


With the test server running:

```
npx playwright codegen localhost:3000/jokes
```

 - New Joke
 - Enter text.
 - Click save.
 - Click new row.

Save to ```__tests__/new-joke.spec.js```

Update the test to change the click to an assertion:

```js
  await expect(page.getByRole('cell', { name: 'One time a bartender walked into a bar. He worked a full shift.' })).toBeVisible();
```

Now we can run it:

 * Restart the dev server to clear the db.
 * ```npx playwright test```
 * Restart the dev server to clear the db.
 * ```npx playwright test --headed```
 * Restart the dev server to clear the db.
 * ```npx playwright test --ui```

You can also write tests entirely manually.

 


**Traditional tool: Selenium**

This can definitely be scripted in Ruby.

 - https://www.selenium.dev/documentation/webdriver/
 - https://www.selenium.dev/selenium/docs/api/javascript/index.html


**Scraping**

These tools are primarily useful for end-to-end testing, but they have
another application: Web Scraping.

Sometimes you just need to write a script to see what's on a web site
continuously every 10 minutes. Sometimes you can just script a simple
web request, but for sites with a lot of JS-generated dynamic content
it can be useful to spin up a whole browser and automate that.

When doing this, make sure to consider:

 - Scraping may be against the terms of service of some websites.
 - Violating the terms of service of web sites may sometimes be
   illegal.

