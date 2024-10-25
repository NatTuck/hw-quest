---
title: "cs2010 Notes: 16 Cannon"
date: "2024-10-20"
---


The ram is attacking!

We need to defend against it with a cannon.

We use mouse to point cannon, shoot cannonball at constant velocity.

Work with the cannon2/render.js code in the scratch repo.

Once the cannonball has an angle, make the cannon ball apply vertical velocity
to the ram, and then see if we can shoot it up off the screen.


```
function moveRam(xx) {
  xx = xx - 4;
  if (xx < 0) {
    xx = xx + 800;
  }
  return xx;
}

function ramFrame(tick) {
  let fno = Math.floor(tick / 3) % 4 + 1;
  return "ram-" + fno + ".png";
}

function ramIsHit(state) {
  let dx = Math.abs(state.ball.px - state.ramX);
  let dy = Math.abs(state.ball.py - 75);
  return dx < 60 && dy < 60;
}

function newBall(ang) {
  return { px: 150, py: 80, vx: 20 * Math.cos(ang), vy: 20 * Math.sin(ang) };
}

function tickBall(ball) {
  return { px: ball.px + ball.vx, py: ball.py + ball.vy,
           vx: ball.vx, vy: ball.vy - 1 }; 
}

function onInit() {
  return { tick: 0, ball: null, ang: 0, ramX: 800 };
}

function onDraw(state, {drawImage, drawCircle}) {
  console.log(state.ball);
  drawImage(ramFrame(state.tick), 0, state.ramX, 150, 100, 100);
  drawImage('cannon.png', -state.ang, 200, 100, 200, 100);
  if (state.ball != null) {
    drawCircle(state.ball.px, state.ball.py, 10, "black"); 
  }
}

function onTick(state) {
  let tick = state.tick + 1;
  if (state.ball == null) {
    return { tick: tick, ramX: moveRam(state.ramX), 
	         ball: null, ang: state.ang };
  }
  else {
    if (ramIsHit(state)) {
      return { tick: tick, ramX: state.ramX + 80, ball: null, ang: state.ang };
    }
    else {
      return { tick: tick, ramX: moveRam(state.ramX), 
	           ball: tickBall(state.ball), ang: state.ang };
    }
  }
}

function onMove(state, xx, yy) {
  let ang = Math.atan2(600 - yy, xx);
  return { tick: state.tick, ball: state.ball, ang: ang, ramX: state.ramX };
}

function onClick(state, _xx, _yy) {
  return {
    ang: state.ang,
    tick: state.tick,
    ball: newBall(state.ang), 
    ramX: state.ramX
  };
}
```
