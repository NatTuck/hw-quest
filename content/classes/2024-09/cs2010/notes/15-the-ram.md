---
title: "cs2010 Notes: 15 The Ram"
date: "2024-10-17"
---


Let's make the ram run. First, make sure the frames are in the HTML:

```html
      <img class="img" src="rocket.png">
      <img class="img" src="ram-1.png">
      <img class="img" src="ram-2.png">
      <img class="img" src="ram-3.png">
      <img class="img" src="ram-4.png">
```

Then, here's the working sheep code:

```js
// app.js

function ramX(tick) {
  return 800 - (tick * 4 % 800);
}

function ramFrame(tick) {
  let fno = Math.floor(tick / 3) % 4 + 1;
  console.log(tick, fno);
  return "ram-" + fno + ".png";
}

function onDraw(tick, {drawImage}) {
  drawImage(ramFrame(tick), ramX(tick), 150, 100, 100);
}
```

Now let's make the sheep jump.

In render.js, our application state is currently one value: tick.

We want to change that to three values: {tick, py, vy}

To do this we're going to replace our single "tick" value
with an object. An object is a thing in JS where we can put
multiple named values.

```js
// render.js

let state0 = {tick: 0, py: 0, vy: 0};
let state = state0;

...

  function doTick() {
    ctx.clearRect(0, 0, 800, 600);

    onDraw(state, {drawImage});
    state = onTick(state);
  }

  setInterval(doTick, 50);

  function onReset() {
    state = state0;
  }

  ...

  function doClick(ev) {
    let rect = ev.target.getBoundingClientRect();
    let xx = ev.clientX - rect.left;
    let yy = ev.clientY - rect.top;
    state = onClick(state, xx, yy);
  }
  
  canvas.addEventListener('click', doClick);
}

```

And our updated app.js:

```js
function ramX(tick) {
  return 800 - (tick * 4 % 800);
}

function ramFrame(tick) {
  let fno = Math.floor(tick / 3) % 4 + 1;
  return "ram-" + fno + ".png";
}

function onDraw(state, {drawImage}) {
  drawImage(ramFrame(state.tick), ramX(state.tick), 150 + state.py, 100, 100);
}

function onTick(state) {
  let tick = state.tick;
  let py = state.py + state.vy;
  let vy = state.vy - 1;
  if (py < 0) {
    py = 0;
    vy = 0;
  }
  return {tick: tick + 1, py: py, vy: vy};
}

function onClick(state, _xx, _yy) {
  let tick = state.tick;
  let py = state.py;
  let vy = state.vy;
  return {tick: tick + 1, py: py, vy: vy + 10};
}
```
