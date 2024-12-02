---
title: "cs2010 Notes: 25 Network Client"
date: "2024-12-01"
---


## Two Lectures Left

 - Today: Network Client
 - Friday: Semester Review
 
Then finals week:

 - Final exam: Wed Dec 11 @ 8am - 10:30am, here
 

## Intro

https://words.homework.quest

 - Attendence
 - This is going to be this week's lab and this week's HW.
 - HW is due Sunday night.

## Setup

```bash
$ npm install phoenix-channels
$ npm install core-js
```


## Code


```js

const name = "student";
const game = "auto-" + name + "-" + randomInt(1000);

const alphabet = new Set("abcdefghijklmnopqrstuvwxyz".split(''));

require('core-js/actual');
let { Socket } = require('phoenix-channels');

let socket = new Socket("wss://words.homework.quest/socket", {debug: true});
socket.connect();

let channel = socket.channel("game:" + game, {name});

function randomInt(xx) {
  return Math.floor(xx * Math.random());
}

function randomPick(xs) {
  return xs[randomInt(xs.length)];
}

function onView(view) {
  const guesses = new Set(view.guesses);
  const moves = Array.from(alphabet.difference(guesses));

  console.log("alphabet", Array.from(alphabet));
  console.log("puzzle:", view.puzzle);
  console.log("guesses:", Array.from(guesses));
  console.log("moves:", moves);

  if (moves.length > 0) {
    channel.push("guess", {ch: randomPick(moves)});
  }
  else {
    console.log("done", view);
  }
}

channel.join()
  .receive("ok", (msg) => console.log("Connected to game:", msg.game))
  .receive("error", (msg) => console.log("Error:", msg));

channel.on("view", onView);
```


Lab info: https://github.com/NatTuck/wg-client
