---
title: "cs2010 Notes: 20 Functions on Objects, Lists"
date: "2024-11-03"
---

Number

 - Is the number even?
 - Given two numbers, return the larger one.
 - Given three numbers, return the largest one.

List of Number

 - Find the largest number in the list.
 - Find all even numbers in the list.
 - Find the largest even number in the list, or return null.

A Car is {tankSize, milesPerGallon}

 - Write a function that takes two cars and returns the
   one with the better milage. 
 - Write a function to calculate range

List of Car

 - Calculate the total tank size in a list of car.
 - Find the best range in a list of car.
 - Find the car with the best range in a list of car.



HTML:

```html
<!doctype html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Simple Functions</title>
  </head>
  <body style="text-align: center; margin: 4em">

    <div style="border: thin solid black; padding: 2em">
      <h1>Example 1</h1>
      <p><input type="number" id="input-1"></p>
      <p id="output-1">out-1</p>
      <p><button id="btn-1">Example 1</button></p>
    </div>

    <script src="./app.js">
    </script>
  </body>
</html>
```

app.js

```js
function fun1(xx) {
  return xx + 2;
}

function click1() {
  let input = document.getElementById('input-1');
  let output = document.getElementById('output-1');
  let xx = parseInt(input.value);
  let yy = fun1(xx);
  output.innerText = yy;
}

document.getElementById('btn-1').addEventListener('click', click1);
```
