---
title: "Notes: 38 Multi Player Word Game"
date: "2023-11-30"
---

## Starting Point

 - Last time we saw the implementation of the basic word game rules
   as a single player game.
 - App state has three parts:
   - Secret words (selected randomly)
   - Guessed letters
   - Score
 - Each turn, the user guesses a letter and
   - Any instances of that letter in the secret words are revealed
   - Gets points equal to the number of letters revealed, except that
     vowels are worth no points.

## Setup for Multiplayer

 - We're going to have multiple players, each with a separate browser,
   taking sequential turns.
 - Everyone shares a secret and set of guesses.
 - Each player has a separate score.
 - Further, we need to keep track of the active player.
 
So the old state looked like:

```js
    {
        secret: ["word", "word", ...],
        guesses: Set["e", "t", "j", ...],
        score: 7,
    }
```

The new game state wants to look like:

```js
    {
        secret: ["word", "word", ...],
        guesses: Set["e", "t", "j", ...],
        players: [
           { name: "Alice", score: 7 },
           { name: "Bob", score: 9 },
        ],
        active: "Alice",
    }
```

That full game state lives only on the server. In each browser, we
have a local state that looks like this:

```
    {
        user: "Bob",
        view: "---d ---d ....",
        guesses: Set["e", "t", "j", ...],
        players: [
           { name: "Alice", score: 7 },
           { name: "Bob", score: 9 },
        ],
        active: "Alice",
    }
```

In order to make that work, we need to know each user's name. So we'll
need a "login" screen where the user enters their name.

Logging in will set the user name in local state:

```js
// store.js

function user(state = null, action) {
  switch (action.type) {
  case 'set-user':
    return action.data;
  case 'clear-user':
    return null
  default:
    return state;
  }
}

...


let rfn = combineReducers({secret, guesses, score, user});
```


## Server-Side Logic

Web apps built with tools like Ruby and NodeJS tend to handle
concurrency and parallel scalabilty with multiple OS processes.

This requires the app server code to be stateless between requests.
Any state either lives in the database or in some sort of state
service.

Another approach to consider might be to use a single OS process and
multiple threads. That would provide concurrency and parallel
scalability on a single server. It would also allow for state to be
shared between requests with shared memory as long as there was some
appropriate synchronization mechanism used (e.g. a global variable
protected with a lock). 

The thread approach might seem reasonable for something that looked
like a monolithic Java app. There are two big issues with this
approach: shared memory and locks is extremely bug prone, and it would
require separate distributed-system logic to scale beyond one server
while maintaining in-app cross-request state.

My favorite platform - the Erlang VM - starts with the distributed
system plan. The building blocks is "processes" that logically don't
share memory and communicate by passing messages, which means that the
same mechanisms for building a system on one server keep working when
scaling to multiple servers.

To handle our App state, we'll follow a "state server" pattern, where
we have a dedicated process to hold our state and pass messages to it
to interact with that state. Logically, this is a lot like a
"synchronized" object in Java, but in a more distributed-first
structure.

We'll start by implemeting our game logic in a Game module.

 - Look at Game.ex, including in REPL. This models the game.

Then we want to store a game. We'll start with one game. To store the
game, we'll create a dedicated Erlang process using the GenServer
pattern. Operations on the game instance happen by sending messages to
the process.

 - Look at GameServer.ex, including in REPL.

Next, it's time to hook up the JS code to the server code. We do that
through a websocket, or in Phoenix, a Channel.

 - Look at game_channel.ex
 - Look at updated game.js, login.jsx


