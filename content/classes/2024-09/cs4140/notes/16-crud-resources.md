---
title: "cs4140 Notes: 16 CRUD Resources"
date: "2024-10-01"
---

One useful way of thinking about software design is that the whole
point of an app is the data it stores and processes.

Phoenix provides support for a common data model, as follows:

 - Your persistent data is stored as a series of "resources".
 - Each resource has:
   - A database table, each row is one record.
   - A schema, mapping database rows to Ecto structs (this might be
     called a "model object" in an OO language).
   - One or more controllers, providing a web path to access and 
     manipulate this kind of data.
   - Controllers have associated templates, to render web pages.
 - Broadly, the controller provides for a set of operations called
   CRUD on the resource:
   - Create
   - Retrieve
   - Update
   - Delete
 - More specifically, the generated controllers follow a pattern
   called REST, with five operations:
   - List (index)
   - Show
   - Create
   - Update
   - Delete
 - To provide for those five operations in a traditional web interface,
   we need five associated routes plus two more:
   - New (the form for create)
   - Edit (the form for update)
 - One of the neat things about the REST structure is that it also works
   when we don't want to use traditional web forms. The same five operations
   (and five routes) can be used as an API endpoint.
   - A REST API typically uses JSON, but could also be something else like XML.
   - We can use this to have a single-page JavaScript UI on the same site.
   - Or on a different site.
   - Or as the backend for a mobile app.
   - Or for fully machine-to-machine API scenarios.
 
Let's do an example with Invites for our PartyAnimal app:

```bash
mix phx.gen.html Meals Meal meals name:string grams:integer
mix phx.gen.json --no-schema --no-context --web Ajax Meals Meal meals name:string grams:integer
```

Using --no-schema, --no-context, and --web Xx with the same fields
will genenerate both a traditional form-based UI and a JSON API that
manipulate the same resource with different paths, both following the
REST conventions.

Relations:

 - An invite belongs to an event.
 - An event has many invites.
 - An invite belongs to a user (the person who's invited).
 - A user has many invites.



## Adding React components

```
cd assets
corepack enable pnpm
pnpm add react
pnpm add flowbite-react
```

 - https://flowbite.com/docs/getting-started/react/
 - https://flowbite-react.com/docs/components
 - Alt: https://sparkui.vercel.app/?path=/docs/getting-started--docs

Update tailwind config to look in jsx files:

```
module.exports = {
  content: [
    "./js/**/*.js",
    "./js/**/*.jsx",  // Here
```

In app.js:

```js
import "./invites/main";
```

In invites/main.jsx:


```js
import React from 'react';
import { createRoot } from 'react-dom/client';

import Invites from './invites';

const root_div = document.getElementById('invites-main');
if (root_div) {
  const root = createRoot(root_div);
  root.render(<Invites />);
}
```

In invites/invites.jsx:


```js
import React from 'react';
import { createRoot } from 'react-dom/client';

import { Card } from 'flowbite-react';

export default function Invites(props) {
  return (
    <div className="flex items-center justify-center">
      <Card className="max-w-sm">
        <p>Invites go here</p>
      </Card>
    </div>
  );
}
```

In .../page_html/home.html.heex:

```html
  <div id="invites-main">
    React component loading...
  </div>
```


In invites/api.js:

```js
const base = "/ajax/invites";

export async function list_invites() {
  let resp = await fetch(base, {
    headers: {
      'Accept': 'application/json',
    }
  });
  return await resp.json();
}
```

And now update invites.jsx:

```js
import { list_invites } from './api';

export default function Invites(props) {
  const [invites, setInvites] = useState([]);

  useEffect(() => {
    list_invites().then((xs) => setInvites(xs));
  }, []);

  console.log(invites);
  let invite_items = invites.map((item, ii) => (
    <li key={ii}>
      { item.name }
    </li>
  ));

  return (
    <div className="flex items-center justify-center">
      <Card className="max-w-sm">
        <ul>
          { invite_items }
        </ul>
      </Card>
    </div>
  );
}
```

## Digression: Phoenix UI

We don't need to push to React just to get already styled UI components:

 - https://phoenix-ui.fly.dev/
