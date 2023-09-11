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

Now let's do the list page.

```jsx
// app/jokes/page.js

import Link from 'next/link';

import { list_jokes } from '@/lib/jokes';

export default async function Jokes() {
  let jokes = await list_jokes();

  let joke_rows = jokes.map((joke) => (
    <tr key={joke.id}>
      <td>{joke.content}</td>
    </tr>
  ));

  return (
    <main className="text-center min-h-screen">
      <h1 className="text-2xl py-8">List Jokes</h1>
      <p><Link className="text-sky-700 underline" href="/joke/new">New Joke</Link></p>
      <table className="table table-striped">
        <tbody>
          {joke_rows}
        </tbody>
      </table>
    </main>
  );
}
```

We can't see anything yet, so let's do the new joke page.

```jsx
// app/joke/new/page.js

export default async function NewJoke() {
  return (
    <main className="text-center min-h-screen">
      <h1 className="text-2xl py-8">New Joke</h1>
      <form action="/joke" method="post">
        <label htmlFor="content" className="my-2">
          Content <br/>
          <textarea rows="4" cols="40" name="content"></textarea>
        </label>
        <div className="my-2">
          <button className="bg-blue-600 text-white py-2 px-4 rounded"
                  type="Submit">
            Save
          </button>
        </div>
      </form>
    </main>
  );
}
```

Now we can post a form to "/joke", so let's write the handler for
that.

```js
// app/joke/route.js

import { NextResponse } from 'next/server';

import { create_joke } from '@/lib/jokes';

export async function POST(request) {
  let data = await request.formData();

  let joke = Object.assign({}, {content: data.get('content')});
  console.log("create_joke", joke);

  let joke1 = await create_joke(joke);
  console.log("created", joke1);

  let resp = new Response("redirect", {
    status: 303,
    headers: {
      "Location": "/jokes",
    }
  });
  return resp;
}
```

Let's show one joke:

```jsx
// app/joke/[id]/page.js

import Link from 'next/link';

import { get_joke } from '@/lib/jokes';

export default async function ShowJoke({params}) {
  let {id} = params;
  let joke = await get_joke(parseInt(id));

  return (
    <main className="text-center min-h-screen">
      <h1 className="text-2xl py-8">Joke #{id}</h1>
      <p>{joke.content}</p>
      <p><Link className="text-sky-700 underline" href="/jokes">Back</Link></p>
    </main>
  );
}
```

And delete a joke

In jokes/page.js:

```jsx
// We can't do client-side stuff in default components, so... 
import DeleteJoke from '@/components/delete_joke.js';

// And, in the table row

     <td>{joke.content}</td>
     <td>
       <DeleteJoke joke_id={joke.id} />
     </td>
```

And the new client-side component:

```jsx
// components/delete_joke.js 

'use client';

export default function DeleteJoke({joke_id}) {
  function click_delete(ev) {
    ev.preventDefault();
    if (confirm("Really delete?")) {
      send_delete_joke(joke_id).then(() => {
        console.log("Deleted joke #" + joke_id);
      });
    }
  }

  return (
    <button onClick={click_delete}
            className="bg-red-600 text-white py-2 px-4 rounded">
      Delete
    </button>
  );
}

async function send_delete_joke(id) {
  let resp = await fetch('/joke', {
    method: 'DELETE',
    mode: 'same-origin',
    headers: {
      'content-type': 'application/json',
    },
    body: JSON.stringify({id}),
  });
  let _body = await resp.json();
  window.location.reload();
}
```

And on the server:

```js
// in app/joke/route.js

import { create_joke, delete_joke } from '@/lib/jokes';

// add a delete handler

export async function DELETE(request) {
  let {id} = await request.json();

  await delete_joke(id);

  return NextResponse.json({deleted: id});
}
```
