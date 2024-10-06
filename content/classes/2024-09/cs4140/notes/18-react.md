---
title: "cs4140 Notes: 18 React"
date: "2024-10-03"
---

**First, Continuous Deployment**

Refs:

 - https://github.com/NatTuck/party_animal/blob/main/.github/workflows/deploy.yml
 - https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows#workflow_run
 - https://github.com/appleboy/ssh-action


**Let's set up React and a React component for PartyAnimal**

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
