---
title: "cs4140 Notes: 10-13 Hangman"
date: "2025-10-13"
---

## Hangman

The point here is managing state in different places.

But we're going to build a full app anyway.

```
mix phx.new hangman --database sqlite3
cd hangman
mkdir db
touch db/.gitkeep
vim config/dev.exs # add db dir
mix ecto.create
cd assets
pnpm add react react-dom cash-dom
vim js/app.js # import "./hangman"
```

hangman.jsx

```jsx
import React, { useState } 'react';
import { createRoot } from 'react-dom/client';
import $ from 'cash-dom';


function Hangman(_props) {
  const [state, setState] = useState({});

  return (
    <div>
      Hello
    </div>
  );
}

function init() {
  var root_div = document.getElementById('root-div');
  if (!root_div) {
    return;
  }

  const root = createRoot(root_div);
  root.render(<Hangman />);
}

$(init);
```

home.html.heex

```html
<div id="root-div">
  React loading...
</div>
```

Build from here:

- Create a hangman.ex module with the game rules.
  - new
  - guess
  - etc
- Create a channel
- Talk about views
- etc
