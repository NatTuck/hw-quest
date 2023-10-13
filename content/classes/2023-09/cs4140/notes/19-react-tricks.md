---
title: "cs4140 Notes: 19 React Review"
date: "2023-10-07"
---

**Quick React Review**

Functional reactive programming.

What is functional programming?

Programming style focused on two key ideas:

 - Immutable data
 - Pure functions

**Immutable Data**

 - Immutable data can't be changed after it's created.
 - This can make programs easier to reason about, because
   that's a pretty strong invariant.
 - This allows for some optimizations.
   - e.g. React uses this to optimize equality comparisons: if data is
     immutable, then unchanged identity implies unchanged value.
 - This allows for some simplifications in programming style.
   - e.g. Immutable data is safe to read in multi-threaded code without
     locks.

**Pure Functions**

 - A pure function has no side effects.
   - Doesn't mutate global state.
   - Doesn't do any sort of I/O action. 
 - It takes some values as arguments, and doesn't mutate them.
 - It constructs one new value and returns it.
 - It doesn't rely on any mutable global state that isn't passed
   as an explicit argument.

This means:

 - A pure function will always produce the same value given the same
   arguments.
 - That means it's safe to memoize (i.e. cache).
 - That means it's safe to call extra times.

**Functional-Reactive Programming**

This is a way to handle interactive, graphical programs in a
functional style.

No program can be 100% functional. Anything useful that a program does
is a side effect and any non-trivial program requires changable state.

So functional programming works by trying to isolate those elements.

In functional-reactive programming, you've got the following ideas:

 - You've got one state value, managed by the runtime environment.
 - You have a render function. This is a pure function that takes the
   current state value as input and generates the current graphical
   view of the app. The simplest version would be a 3D game engine
   generating a single frame.
 - You have several event handler functions. These take an event (e.g.
   key press, mouse click, periodic "tick" to handle time passing) and
   the current state as input and generate a new state as output.
 - When the state changes, or at a fixed frame rate, the render
   function is called to genenrate the new view.

React works exactly like this, with three compliations:

 - The view is an HTML document, so the render function translates the
   current state to an HTML tree.
 - Browsers aren't great at doing complete re-renders, so react
   generates a "Shadow DOM" with the full document tree internally but
   then only requests that the browser render the changes from the
   current document state. So rendering everything on every event
   allows React to minimize actual rendering cost.
 - The render function, event handlers, and even application state are
   broken up into a bunch of little pieces.

# Simple Example

Start from current jokes-next.

**app/root/page.js**

```react
export default function Root() {
  return (
    <main className="text-center min-h-screen py-4">
      <p>This is the react component "Root".</p>
    </main>
  );
}
```

Now more complicated:

```react
"use client";

import { useState } from 'react';

export default function Root() {
  const [count, setCount] = useState(0);

  function update(change) {
    return (ev) => {
      ev.preventDefault();
      setCount(change(count));
    };
  }

  return (
    <main className="text-center min-h-screen py-4">
      <Counter count={count} update={update} />
    </main>
  );
}

function Counter({count, update}) {
  return (
    <div>
      <p>Count: {count}</p>
      <p><button onClick={update((x) => x + 1)}>++</button></p>
      <p><button onClick={update((x) => x - 1)}>--</button></p>
    </div>
  );
}
```

The Counter component is a straightforward functional-reactive element:

 - Counter is a pure render function, taking the current state and returning a view
   with no side effects.
 - Events (appear to be) handled by pure update functions, which take
   the old state and (implicitly) the event and produce a new state.

The Root component shows how React gives the developer control over
the state management mechanism. Hooks like useState allow components
to manage pieces of immutable local state while remaining "mostly
pure".

# Wrapping disfunctional components

This raises a question: How do we deal with JS libraries that want to
draw stuff directly to the DOM and have side effects and not follow
the React rules at all, while still using React to manage the rest of
the page and the page overall?

 - Managed vs unmanaged form controls.
 - Graph library example.
 
**Forms**

Tabs:

```react
"use client";

import { useState } from "react";

export default function Form() {
  const [tab, setTab] = useState(0);

  return (
    <main className="text-center min-h-screen">
      <h1 className="text-2xl py-8">Form</h1>
      <p>
        <button className="m-2 p-1 ring-1"
                onClick={() => setTab(0)}>Tab0</button>
        <button className="m-2 p-1 ring-1"
                onClick={() => setTab(1)}>Tab1</button>
      </p>
      { (tab == 0) ? <Tab0 /> : <Tab1 /> }
    </main>
  );
}

function Tab0() {
  return (
    <div>
      Tab 0
    </div>
  );
}

function Tab1() {
  return (
    <p>Tab 1</p>
  );
}
```

Uncontrolled form:

```react
function Tab0() {
  return (
    <div>
      <input type="text" />
    </div>
  );
}
```

Controlled form, doesn't help:

```react
function Tab0() {
  const [text, setText] = useState("");
  
  return (
    <div>
      <input type="text" value={text} onChange={(ev) => setText(ev.target.value)} />
    </div>
  );
}
```

Controlled form, helps:

```react
export default function Form() {
  const [tab, setTab] = useState(0);
  const [text, setText] = useState("");

  ... 
      
  { (tab == 0) ? <Tab0 text={text} setText={setText} /> : <Tab1 /> }
  ...
}

function Tab0({text, setText}) {
  return (
    <div>
      <input type="text" value={text} onChange={(ev) => setText(ev.target.value)} />
    </div>
  );
}
```

**app/graph/page.js**

```react
function makeData(xx) {
  // https://plotly.com/javascript/bar-charts/
  return [
    {
      x: ['giraffes', 'orangutans', 'monkeys'],
      y: [xx, 14, 23],
      type: 'bar'
    }
  ];
}

function Tab0() {
  var data = makeData(20);

  useEffect(() => {
    Plotly.newPlot('myDiv', data);
  });

  var yy = 10;
  function click(ev) {
    ev.preventDefault();
    yy = (yy + 7) % 30;
    Plotly.react('myDiv', makeData(yy));
  }

  return (
    <div className="m-8">
      <button onClick={click}>click</button>
      <div id="myDiv" style={{width: "800px", height: "600px"}}>
        Graph goes here.
      </div>
    </div>
  );
}
```


How do we fix it?
