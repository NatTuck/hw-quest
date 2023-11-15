---
title: "Notes: 32 React / Redux"
date: "2023-11-14"
---

ref: https://github.com/NatTuck/cart_demo

We've got a simple shopping cart app:

 - We see the items in the cart.
 - We've got a summary in the top corner.
 - As we change the cart items we want the summary to change too.
 - They are two seperate React components.
 
In this case the react components are completely seperate, but we can
run into the same issue with a single React component tree and a bunch
of stateful components.

Let's pull the state out of the components and into one single state
repository.

Redux concept:

 - Our entire (browser) state is a single immutable value.
 - That value is stored in and managed by an object called the store.
 - We can query the store for the current value at any time.
 - To update, we dispatch an action - an object representing a change
   to our state, usually caused by some event.
 - We provide code to generate a new state value based on the old
   value and an action.
 - Objects like react components can subscribe to be notified and get
   the new value when the value is updated (which will trigger a
   re-render, just like setState would).

Setting up redux:

```
yarn add redux react-redux
```

Example store:

```js
import { createStore, combineReducers } from 'redux';

function users(state = [], action) {
    switch (action.type) {
    case 'users/set':
        return action.data;
    default:
        return state;
    }
}

function user_form(state = {}, action) {
    switch (action.type) {
    case 'user_form/set':
        return action.data;
    default:
        return state
    }
}

function root_reducer(state, action) {
    console.log("root_reducer", state, action);
    let reducer = combineReducers({
        users, user_form
    });
    return reducer(state, action);
}

let store = createStore(root_reducer);
export default store;
```

Example root:

```js
import { Provider } from 'react-redux';
...
import store from './store';
...
ReactDOM.render(
  <React.StrictMode>
    <Provider store={store}>
      <App />
    </Provider>
  </React.StrictMode>,
  document.getElementById('root')
);

load_defaults();
```

Example component:

```js
import { connect } from 'react-redux';

function Users_({users, user_form, dispatch}) {
   // ...
}

const Users = connect(({users, user_form}) => ({users, user_form}))(Users_);
```

Other stuff to cover:
