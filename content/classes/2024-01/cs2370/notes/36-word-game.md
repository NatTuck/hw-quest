---
title: "cs2370 Notes: 36 Word Game"
date: "2024-04-28"
---

Word game: https://words.homework.quest/

Word list: https://github.com/NatTuck/word-game/tree/03-high-scores/priv/data

Setup:

```bash
py -m pip install git+https://github.com/NatTuck/realtime-py.git
```

Code:

```python
from realtime.connection import Socket
import asyncio
from random import randint
import sys

NAME = "Orange"
URL = "wss://words.homework.quest/socket/websocket?vsn=2.0.0"

loop = asyncio.get_event_loop()
channel = None
done = False


def letters():
    return set("abcdefghijklmnopqrstuvwxyz")


async def on_view(msg):
    global done
    
    print("\nmsg =", msg)
    puzzle = msg['puzzle']
    
    if not "-" in puzzle:
        done = True
        print("Game done.\n")
        return
    
    guesses = set(msg['guesses'])
    options = letters() - guesses
    print("options:", options)

    guess = list(options)[0]
    print("Guessing:", guess)

    await channel.send("guess", {"ch": guess}, "")

    
async def main():
    global channel

    client = Socket(URL, False, {"name": NAME})

    # connect to the server
    await client.connect()

    # fire and forget the listening routine
    listen_task = asyncio.ensure_future(client.listen())

    # join the channel
    channel = client.set_channel("game:practice" + str(randint(1, 1000)))
    await channel.join()

    channel.on("view", None, on_view)

    # we give it some time to complete
    while not done:
        await asyncio.sleep(1)

    # proper shut down
    listen_task.cancel()

    
if __name__ == '__main__':
    try:
        loop.run_until_complete(main())
    except KeyboardInterrupt:
        loop.stop()
        exit(0)
```
