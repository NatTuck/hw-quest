---
title: "cs4140 Notes: 06 NextJS and Rails"
date: "2023-09-10"
---

**Jokes App with NextJS**

We want to have a webpage that shows a Joke of the Day.

This joke will be picked from a database of jokes, and we'll have
management pages to:

 - List all jokes
 - Create a new joke
 - Edit a joke
 - Delete jokes
 
I almost demoed this already for Rails. Let's do it again real quick:

```bash
rails new jokes --css=bootstrap --database=sqlite3
cd jokes
rails generate scaffold joke content:text
rails db:migrate
rails server
```

It's a little more complicated for Next.js for two reasons:

 - DB support isn't included by default.
 - There aren't generators.
 - Doing full page loads for actions isn't the primary mode.

So let's walk through the whole thing...

**Setup for NextJS**

Requirements:

 - A modern OS
 - Node.js >= 16.14

For Web Dev in general, I recommend anything but raw Windows. If
you're on Windows, [WSL](
https://learn.microsoft.com/en-us/windows/wsl/install) is a really
good idea.

Installing NodeJS:

In web dev you'll sometimes find yourself wanting a specific version
of one or more language runtimes. Sometimes you'll even want two
switch between multiple versions.

To install NodeJS (and Ruby, and some other stuff) I use the
[asdf](https://asdf-vm.com/) version manager. For NodeJS specifically
there's also [NVM](https://github.com/nvm-sh/nvm).

The current NodeJS LTS release is 18, and that meets the requirements,
so that's probably the best option.

**Starting a NexJS project**

```bash
npx create-next-app@latest
# What is your project named?      jokes
# Typescript?   no
# ...  defaults
```

That created our project, cd in there and

```bash
npm run dev
```

That says we can visit our new site at http://localhost:3000 in a browser.

And that suggests we edit ```app/page.js```

So let's do that:

```jsx
import Image from 'next/image';

export default function Home() {
  return (
    <main className="text-center min-h-screen">
      <h1 className="text-2xl py-8">Today's Joke</h1>
      <p>Joke of the Day goes here</p>
    </main>
  )
}
```

Before we get too far, I want to add a pretty tables library.

https://github.com/drehimself/tailwindcss-tables

```bash
npm install tailwindcss-tables
```

In tailwind.config.js:

```js
  plugins: [
    require('tailwindcss-tables')(),
  ],
```

**Adding Prisma**

From the project directory:

```bash
npm install prisma
npx prisma init
```

Edit prisma/schema.prisma:

```
datasource db {
  provider = "sqlite"
  url      = "file:./jokes.db"
}
```

And we should add the database to our .gitignore:

```
# database
*.db
*.db-journal
```

Now let's add our model to prisma/schema.prisma:

```
model Joke {
  id            Int      @id @default(autoincrement())
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt
  content       String
}
```

And migrate:

```bash
npx prisma migrate dev --name init
```

**CRUD for Jokes**

First, let's create a layer of indirection to avoid accessing the DB
directly from our UI code.

```js
// lib/jokes.js

import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export async function list_jokes() {
  let jokes = await prisma.joke.findMany();
  return jokes;
}

export async function get_joke(id) {
  let joke = await prisma.joke.findUnique({
    where: { id }
  });
  return joke;
}

export async function create_joke(joke) {
  await prisma.joke.create({ data: joke });
}

export async function update_joke(joke) {
  await prisma.joke.update({
    where: { id: joke.id },
    data: joke
  });
}

export async function delete_joke(id) {
  await prisma.joke.delete({
    where: { id }
  });
}
```

**Day1 ended here**
