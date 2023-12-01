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

## How to Move to Multiplayer

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



 

 
