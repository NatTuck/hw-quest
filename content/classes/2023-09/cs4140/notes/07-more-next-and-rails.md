---
title: "cs4140 Notes: 07 More NextJS and Rails"
date: "2023-09-12"
---

**Continuing from Last Time**

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
