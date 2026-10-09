---
title: "cs4250 Notes: 10-09 The I2C OLED Protocol"
date: "2026-10-08"
---

You've wired up the 128x64 OLED, flashed one of the supplied programs, and
seen text appear. This page explains what is actually happening on the two
wires and in the display's memory, so you can stop using the supplied images
and start drawing your own. Everything here is verified on the hardware.

## 1. I2C at the wire level

I2C is a two-wire bus:

| Line | Meaning            |
|------|--------------------|
| SDA  | serial **data**    |
| SCL  | serial **clock**   |

Both lines are **open-drain**: they are held HIGH by pull-up resistors, and
any device on the bus can only ever pull a line **LOW**. A device never
drives a line high — it either pulls it low or lets it float, and the
pull-up does the rest. This is why two devices can share a wire without
fighting: if either one pulls low, the line reads low.

Two edges are special, and they are defined in terms of SCL:

- **START** — SDA falls while SCL is **high**.
- **STOP** — SDA rises while SCL is **high**.

Between a START and a STOP, data is transferred one **byte** at a time, most
significant bit first, with SDA changing only while SCL is low and being
sampled while SCL is high. After every 8 data bits the transmitter releases
SDA for one more clock, and the receiver pulls SDA low to send an **ACK** bit
(low = acknowledged, high = not acknowledged).

The SSD1306 has the 7-bit address **0x3C**. On the wire an address byte is
the 7-bit address shifted left by one, with the read/write bit in the LSB, so
the **write** address byte is `0x3C << 1 = 0x78`. Every transfer to this
panel starts with the byte `0x78`.

On these boards the little C906 core bit-bangs this bus itself — no kernel
I2C controller — on the header pins:

| Signal | Header pin | SoC pad     |
|--------|-----------|-------------|
| SDA    | pin 11    | GPIO B11    |
| SCL    | pin 13    | GPIO B12    |

"Bit-banging" just means the program toggles those two pads by hand, in the
right order, to make the START/STOP/data/ACK patterns above.

## 2. The SSD1306 framing

An I2C transfer to the panel is the address byte `0x78`, followed by a stream
of bytes. The SSD1306 needs to know whether each following byte is a command
or display data, so every transfer begins with a **control byte**:

| Control byte | Meaning for the bytes that follow |
|--------------|-----------------------------------|
| `0x00`       | **COMMANDS** (configure the chip) |
| `0x40`       | **DISPLAY DATA** (pixels)         |

So the shape of a transfer is:

```
START  0x78  <control>  <byte> <byte> <byte> ...  STOP
```

The control byte is not sticky across a STOP; each new transfer carries its
own.

### Power-on command sequence

Before it will show anything, the panel must be configured. The supplied
`ssd1306.h` sends exactly this sequence (the bytes are in order; the comment
says what each does):

| Bytes        | Command                        |
|--------------|--------------------------------|
| `0xAE`       | display off                    |
| `0xD5 0x80`  | clock divide / oscillator      |
| `0xA8 0x3F`  | multiplex ratio = 64           |
| `0xD3 0x00`  | display offset 0               |
| `0x40`       | start line 0                   |
| `0x8D 0x14`  | charge pump on                 |
| `0x20 0x00`  | memory mode = horizontal       |
| `0xA1`       | segment remap                  |
| `0xC8`       | COM scan remapped              |
| `0xDA 0x12`  | COM pins config                |
| `0x81 0xCF`  | contrast                       |
| `0xD9 0xF1`  | pre-charge                     |
| `0xDB 0x40`  | VCOMH deselect                 |
| `0xA4`       | resume RAM content             |
| `0xA6`       | normal (not inverted)          |
| `0x2E`       | deactivate scroll              |
| `0xAF`       | display on                     |

All of these are sent with the `0x00` (command) control byte. Notice that
some "commands" take an argument byte (`0xD5` is followed by `0x80`, and so
on). You don't need to understand each one to draw pixels; the important
consequences for us are the memory mode (horizontal addressing) and that the
charge pump is on so the panel is powered from its own supply.

## 3. The display memory (GDDRAM)

The panel is 128 pixels wide and 64 pixels tall, one bit per pixel. That is:

```
128 * 64 / 8 = 1024 bytes
```

The display's memory (GDDRAM) is organised as **8 pages of 128 bytes** each,
not as a simple row-major bitmap. Page `p` holds the 8 pixel rows
`8p .. 8p+7`, laid out left-to-right by column:

```
        column x = 0        1        2   ...   127
        +--------+--------+--------+     +--------+
page 0  | byte   | byte   | byte   | ... | byte   |   rows 0..7
        +--------+--------+--------+     +--------+
page 1  | byte   | byte   | byte   | ... | byte   |   rows 8..15
        +--------+--------+--------+     +--------+
  ...                                              ...
        +--------+--------+--------+     +--------+
page 7  | byte   | byte   | byte   | ... | byte   |   rows 56..63
        +--------+--------+--------+     +--------+
```

Within one byte, **bit 0 is the TOP row of that page** and bit 7 is the
bottom row. So bit `k` of a page byte corresponds to row `8p + k`.

Putting that together, the byte that holds pixel `(x, y)` is at framebuffer
index:

```
index = x + (y / 8) * 128
```

and within that byte, the bit is:

```
bit = y % 8
```

You set the pixel by OR-ing in `1 << (y % 8)` and clear it by AND-ing out the
same bit. Because a byte spans 8 vertical pixels in the same column, a whole
vertical stripe of 8 pixels shares one byte.

### Updating the screen

GDDRAM is just memory; the panel only redraws what you've pushed into it. To
push the whole framebuffer you set the address window to the entire panel and
then stream all 1024 bytes as **data**:

1. Set the **column** range: `0x21, 0, 127` (start column 0, end column 127).
2. Set the **page** range: `0x22, 0, 7` (start page 0, end page 7).
3. Send the 1024 framebuffer bytes with the `0x40` (data) control byte.

With horizontal addressing mode enabled in the init sequence, the SSD1306
auto-advances through the window as it consumes the data bytes, so one flat
1024-byte stream fills the display.

## 4. The code you're using

The supplied driver hides all of the above behind a small framebuffer API.
Both the Arduino and the Python sides keep a 1024-byte buffer and only touch
the panel when you ask them to.

**Arduino** (`ssd1306.h`, used by `oled-text.ino`):

| Call                     | What it does                                              |
|--------------------------|-----------------------------------------------------------|
| `oled_pixel(&o, x, y)`   | set the bit for pixel `(x, y)` in the framebuffer         |
| `oled_clear(&o)`         | zero the whole framebuffer                                |
| `oled_flush(&o)`         | set the window and send all 1024 bytes to the panel       |

The origin is the **top-left** corner, with `x` in `0..127` and `y` in
`0..63`. `oled_pixel` ignores out-of-range coordinates, so you can't corrupt
the buffer by drawing off the edge.

**Python** (`ssd1306.py`):

| Call                | What it does                                   |
|---------------------|------------------------------------------------|
| `dev.pixel(x, y)`   | set the bit for pixel `(x, y)`                  |
| `dev.clear()`       | zero the whole framebuffer                      |
| `dev.show()`        | set the window and send the buffer to the panel |

The important idea: `pixel` (and `oled_pixel`) only change the local
framebuffer. Nothing reaches the screen until `flush`/`show` sends the
buffer. `clear` likewise only clears the buffer.

## 5. Lighting ONE pixel

Let's light the single pixel at the **center** of the display, `(64, 32)`.

Arduino:

```c
oled_clear(&o);
oled_pixel(&o, 64, 32);
oled_flush(&o);
```

Python:

```python
dev.clear()
dev.pixel(64, 32)
dev.show()
```

### Why `(64, 32)` is the middle

The display is 128 pixels wide and 64 pixels tall, so the valid coordinates
are `x` in `0..127` and `y` in `0..63`. The horizontal middle is the column
with 64 columns to its left and 63 to its right — that's `x = 64` (columns
`0..63` on one side, `65..127` on the other). The vertical middle is the row
with 32 rows above and 31 below — that's `y = 32` (rows `0..31` and
`33..63`). Hence `(64, 32)`.

### Drawing your own image

To draw an image you call the pixel function **once for each pixel you want
lit** — the sequence above, repeated for every coordinate that should be on,
between the `clear` and the `flush`/`show`. The panel is only 128x64, so
`x` runs from 0 (left) to 127 (right) and `y` from 0 (top) to 63 (bottom).

## 6. Reference links

- ELEGOO:
  - https://www.elegoo.com/pages/download
  - https://www.elegoo.com/blogs/arduino-projects
- SSD1306 datasheet: https://cdn-shop.adafruit.com/datasheets/SSD1306.pdf

Back to the [lab](./).
