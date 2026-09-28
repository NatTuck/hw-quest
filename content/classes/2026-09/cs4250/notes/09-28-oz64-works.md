---
title: "cs4250 Notes: 09-28 Oz64 Works"
date: "2026-09-23"
---

## Debugging Board Boot

The Oz64 totally works. Here's what I did instead of going to bed
on time last night.

### Problem 1: Power

To power on the Oz64 you need a barrel jack cable providing 5V.

It needs to be plugged into the power jack, not the headphone jack.

When it's plugged in, the light comes on.


### Problem 2: Boot Debugging

For most dev boards like this, there's a debugging serial console. This lets you
see boot messages and use the CLI without hooking up a display or network.

Two complications:

- You don't have a serial terminal.
- Even if you did, standard serial runs at 5V and boards like this pretty
consistently require non-standard 3.3V serial.

Luckily, USB to 3.3V serial adapters are readily available.

I've got this one and it works: https://www.amazon.com/dp/B0D97VR3CY

A cheaper one will probably work too. Just make sure it's "3.3V TTL USB Serial".

Pins away from you, outer row, the pins go +5, +5, Ground, TX, RX. Remember: TX
connects to RX and RX connects to TX. So with my adapter it's blank, blank,
black, green, white.

On Linux, GTKTerm works. 115200, parity none, 8 bits, 1 stop bits, flow none.

Other platforms maybe use PuTTY.


### Problem 3: Correct Image

The Fishwaldo Image works.

Also, the scpcom image works: https://github.com/scpcom/sophgo-sg200x-debian/releases

Looking for duos-e_sd.img.lz4

Set hostname now:

- The image overwrites /etc/hostname on boot
- So we need to set /boot/hostname (or /boot/hostname.prefix)

### Problem 4: Normal lazy setup

Once the thing is booted and connected to ethernet.

```
ssh-copy-id debian@your-hostname
...
sudo visudo
...
%sudo   ALL=(ALL:ALL) NOPASSWD: ALL
```

### Wifi Doesn't Work

- Getting it fixed is non-trivial.
- I'll have to fight with it more.

### Can we get Blink to work?

- Grab it off the Duo S

## Exam 1

- This Friday
- Review will be on Wednesday.

# Rest of the Period

- Let's keep fighting with getting people's boards working.
- I want to make sure that *everyone* can get into their board via ethernet.


