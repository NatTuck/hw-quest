---
title: "cs4250 Notes: 10-09 Source Code"
date: "2026-10-08"
---

These are the support files referenced by the [lab](./) page; save each under the exact filename shown, next to the program that uses it, and do not edit the driver code. You can also grab them from the [sg2000-hints repo](https://github.com/NatTuck/sg2000-hints/tree/main/examples/i2c-lab) rather than copying them out of this page.

## ssd1306.py — Python driver (save as ssd1306.py)

```python
#!/usr/bin/env python3
"""Minimal, dependency-free SSD1306 (128x64, I2C) driver for Linux.

Uses only the stdlib: /dev/i2c-N via the I2C_SLAVE ioctl. No smbus/PIL.

Example:
    python3 ssd1306.py "Hello Oz64"
    python3 ssd1306.py --bus 3 --addr 0x3c --size 1 "line 1\\nline 2"
"""

import argparse
import fcntl
import os
import struct
import sys

I2C_SLAVE = 0x0703
WIDTH, HEIGHT = 128, 64

# 5x7 font, drawn as ASCII art (one string per row, 5 columns).
# '#' = lit pixel. Lowercase is folded to uppercase.
_FONT_ART = {
    " ": ["     "] * 7,
    "A": [".###.", "#...#", "#...#", "#####", "#...#", "#...#", "#...#"],
    "B": ["####.", "#...#", "#...#", "####.", "#...#", "#...#", "####."],
    "C": [".###.", "#...#", "#....", "#....", "#....", "#...#", ".###."],
    "D": ["####.", "#...#", "#...#", "#...#", "#...#", "#...#", "####."],
    "E": ["#####", "#....", "#....", "####.", "#....", "#....", "#####"],
    "F": ["#####", "#....", "#....", "####.", "#....", "#....", "#...."],
    "G": [".###.", "#...#", "#....", "#.###", "#...#", "#...#", ".###."],
    "H": ["#...#", "#...#", "#...#", "#####", "#...#", "#...#", "#...#"],
    "I": ["#####", "..#..", "..#..", "..#..", "..#..", "..#..", "#####"],
    "J": ["..###", "...#.", "...#.", "...#.", "...#.", "#..#.", ".##.."],
    "K": ["#...#", "#..#.", "#.#..", "##...", "#.#..", "#..#.", "#...#"],
    "L": ["#....", "#....", "#....", "#....", "#....", "#....", "#####"],
    "M": ["#...#", "##.##", "#.#.#", "#...#", "#...#", "#...#", "#...#"],
    "N": ["#...#", "##..#", "#.#.#", "#..##", "#...#", "#...#", "#...#"],
    "O": [".###.", "#...#", "#...#", "#...#", "#...#", "#...#", ".###."],
    "P": ["####.", "#...#", "#...#", "####.", "#....", "#....", "#...."],
    "Q": [".###.", "#...#", "#...#", "#...#", "#.#.#", "#..#.", ".##.#"],
    "R": ["####.", "#...#", "#...#", "####.", "#.#..", "#..#.", "#...#"],
    "S": [".####", "#....", "#....", ".###.", "....#", "....#", "####."],
    "T": ["#####", "..#..", "..#..", "..#..", "..#..", "..#..", "..#.."],
    "U": ["#...#", "#...#", "#...#", "#...#", "#...#", "#...#", ".###."],
    "V": ["#...#", "#...#", "#...#", "#...#", "#...#", ".#.#.", "..#.."],
    "W": ["#...#", "#...#", "#...#", "#...#", "#.#.#", "##.##", "#...#"],
    "X": ["#...#", "#...#", ".#.#.", "..#..", ".#.#.", "#...#", "#...#"],
    "Y": ["#...#", "#...#", ".#.#.", "..#..", "..#..", "..#..", "..#.."],
    "Z": ["#####", "....#", "...#.", "..#..", ".#...", "#....", "#####"],
    "0": [".###.", "#...#", "#..##", "#.#.#", "##..#", "#...#", ".###."],
    "1": ["..#..", ".##..", "..#..", "..#..", "..#..", "..#..", ".###."],
    "2": [".###.", "#...#", "....#", "...#.", "..#..", ".#...", "#####"],
    "3": ["####.", "....#", "....#", ".###.", "....#", "....#", "####."],
    "4": ["...#.", "..##.", ".#.#.", "#..#.", "#####", "...#.", "...#."],
    "5": ["#####", "#....", "####.", "....#", "....#", "#...#", ".###."],
    "6": [".###.", "#...#", "#....", "####.", "#...#", "#...#", ".###."],
    "7": ["#####", "....#", "...#.", "..#..", ".#...", ".#...", ".#..."],
    "8": [".###.", "#...#", "#...#", ".###.", "#...#", "#...#", ".###."],
    "9": [".###.", "#...#", "#...#", ".####", "....#", "#...#", ".###."],
    ".": [".....", ".....", ".....", ".....", ".....", ".##..", ".##.."],
    ",": [".....", ".....", ".....", ".....", ".##..", ".##..", ".#..."],
    ":": [".....", ".##..", ".##..", ".....", ".##..", ".##..", "....."],
    ";": [".....", ".##..", ".##..", ".....", ".##..", ".##..", ".#..."],
    "-": [".....", ".....", ".....", "#####", ".....", ".....", "....."],
    "_": [".....", ".....", ".....", ".....", ".....", ".....", "#####"],
    "+": [".....", "..#..", "..#..", "#####", "..#..", "..#..", "....."],
    "=": [".....", ".....", "#####", ".....", "#####", ".....", "....."],
    "!": ["..#..", "..#..", "..#..", "..#..", "..#..", ".....", "..#.."],
    "?": [".###.", "#...#", "....#", "...#.", "..#..", ".....", "..#.."],
    "/": ["....#", "...#.", "...#.", "..#..", ".#...", ".#...", "#...."],
    "(": ["..##.", ".#...", ".#...", ".#...", ".#...", ".#...", "..##."],
    ")": [".##..", "...#.", "...#.", "...#.", "...#.", "...#.", ".##.."],
    "'": ["..#..", "..#..", ".....", ".....", ".....", ".....", "....."],
    '"': [".#.#.", ".#.#.", ".....", ".....", ".....", ".....", "....."],
    "*": [".....", "#.#.#", ".###.", "#####", ".###.", "#.#.#", "....."],
}


def _encode_font():
    font = {}
    for ch, rows in _FONT_ART.items():
        cols = []
        for x in range(5):
            b = 0
            for y in range(7):
                if rows[y][x] == "#":
                    b |= 1 << y
            cols.append(b)
        font[ch] = bytes(cols)
    return font


FONT = _encode_font()
GLYPH_W, GLYPH_H = 5, 7
ADVANCE = 6  # 5 columns + 1 space


class SSD1306:
    def __init__(self, bus=3, addr=0x3C):
        self.addr = addr
        self.fd = os.open(f"/dev/i2c-{bus}", os.O_RDWR)
        fcntl.ioctl(self.fd, I2C_SLAVE, addr)
        self.buf = bytearray(WIDTH * HEIGHT // 8)
        self._init_panel()

    def _cmd(self, *cmds):
        os.write(self.fd, bytes([0x00]) + bytes(cmds))

    def _data(self, payload):
        # Send in <=32-byte chunks; prefix each with the 0x40 data control byte.
        for i in range(0, len(payload), 32):
            os.write(self.fd, bytes([0x40]) + bytes(payload[i:i + 32]))

    def _init_panel(self):
        self._cmd(
            0xAE,              # display off
            0xD5, 0x80,        # clock divide / oscillator
            0xA8, 0x3F,        # multiplex ratio = 64
            0xD3, 0x00,        # display offset
            0x40,              # start line 0
            0x8D, 0x14,        # charge pump on
            0x20, 0x00,        # memory addressing = horizontal
            0xA1,              # segment remap
            0xC8,              # COM scan direction remapped
            0xDA, 0x12,        # COM pins config
            0x81, 0xCF,        # contrast
            0xD9, 0xF1,        # pre-charge
            0xDB, 0x40,        # VCOMH deselect
            0xA4,              # resume RAM content
            0xA6,              # normal (not inverted)
            0x2E,              # deactivate scroll
            0xAF,              # display on
        )

    def clear(self):
        for i in range(len(self.buf)):
            self.buf[i] = 0

    def pixel(self, x, y, on=True):
        if not (0 <= x < WIDTH and 0 <= y < HEIGHT):
            return
        idx = x + (y // 8) * WIDTH
        if on:
            self.buf[idx] |= 1 << (y % 8)
        else:
            self.buf[idx] &= ~(1 << (y % 8))

    def text(self, x, y, s):
        for ch in s:
            glyph = FONT.get(ch, FONT.get(ch.upper(), FONT["?"]))
            for cx in range(GLYPH_W):
                for cy in range(GLYPH_H):
                    if glyph[cx] & (1 << cy):
                        self.pixel(x + cx, y + cy, True)
            x += ADVANCE
        return x

    def invert(self):
        for i in range(len(self.buf)):
            self.buf[i] ^= 0xFF

    def show(self):
        self._cmd(0x21, 0, WIDTH - 1)  # column range
        self._cmd(0x22, 0, HEIGHT // 8 - 1)  # page range
        self._data(self.buf)

    def close(self):
        os.close(self.fd)


def main(argv=None):
    p = argparse.ArgumentParser(description="Show text on an SSD1306 I2C OLED")
    p.add_argument("text", nargs="?", default="Hello Oz64", help="text (use \\n for newline)")
    p.add_argument("--bus", type=int, default=3, help="I2C bus number (default 3)")
    p.add_argument("--addr", type=lambda v: int(v, 0), default=0x3C)
    p.add_argument("--invert", action="store_true")
    args = p.parse_args(argv)

    text = args.text.replace("\\n", "\n")
    dev = SSD1306(bus=args.bus, addr=args.addr)
    try:
        dev.clear()
        y = 0
        for line in text.split("\n"):
            dev.text(0, y, line)
            y += GLYPH_H + 2
        if args.invert:
            dev.invert()
        dev.show()
        print(f"wrote {text!r} to /dev/i2c-{args.bus} @ {hex(args.addr)}")
    finally:
        dev.close()


if __name__ == "__main__":
    main()
```

## ssd1306.h — SSD1306 driver layer (save as ssd1306.h)

```cpp
/* Shared SSD1306 (128x64, I2C) driver layer.
 *
 * Transport-agnostic: the caller supplies a write callback that knows how to
 * push bytes at 0x3C over whatever bus it owns (Linux i2c-dev, raw DesignWare
 * registers, Arduino Wire, an RTOS task, ...). This is the layer that is
 * identical across every example in the deck.
 *
 * I2C framing used here (SSD1306 datasheet section 8):
 *   control byte 0x00 -> the following bytes are COMMANDS
 *   control byte 0x40 -> the following bytes are GDDRAM DATA
 * plus the 7-bit address 0x3C (wire byte 0x78).
 */
#pragma once
#include <stddef.h>
#include <stdint.h>
#include <string.h>

#include "font5x7.h"

#define OLED_W 128
#define OLED_H 64
#define OLED_PAGES (OLED_H / 8)
#define OLED_ADDR 0x3C

/* Send `len` payload bytes. is_data selects the 0x40 vs 0x00 control byte. */
typedef void (*oled_write_fn)(void *ctx, const uint8_t *buf, size_t len,
                              int is_data);

/* Standard 128x64 SSD1306 power-on sequence (no data bytes mixed in). */
static const uint8_t OLED_INIT[] = {
    0xAE,        /* display off            */
    0xD5, 0x80,  /* clock divide / osc     */
    0xA8, 0x3F,  /* multiplex ratio = 64   */
    0xD3, 0x00,  /* display offset 0       */
    0x40,        /* start line 0           */
    0x8D, 0x14,  /* charge pump on         */
    0x20, 0x00,  /* memory mode = horizontal */
    0xA1,        /* segment remap          */
    0xC8,        /* COM scan remapped      */
    0xDA, 0x12,  /* COM pins config        */
    0x81, 0xCF,  /* contrast               */
    0xD9, 0xF1,  /* pre-charge             */
    0xDB, 0x40,  /* VCOMH deselect         */
    0xA4,        /* resume RAM content     */
    0xA6,        /* normal (not inverted)  */
    0x2E,        /* deactivate scroll      */
    0xAF,        /* display on             */
};

typedef struct {
    oled_write_fn write;
    void *ctx;
    uint8_t fb[OLED_W * OLED_PAGES]; /* 1 bpp, 1024 bytes */
} oled_t;

static inline void oled_send(oled_t *o, int is_data, const uint8_t *p,
                             size_t n) {
    o->write(o->ctx, p, n, is_data);
}

static inline void oled_init(oled_t *o, oled_write_fn write, void *ctx) {
    o->write = write;
    o->ctx = ctx;
    memset(o->fb, 0, sizeof o->fb);
    oled_send(o, 0, OLED_INIT, sizeof OLED_INIT);
}

static inline void oled_clear(oled_t *o) { memset(o->fb, 0, sizeof o->fb); }

static inline void oled_pixel(oled_t *o, int x, int y) {
    if (x < 0 || x >= OLED_W || y < 0 || y >= OLED_H)
        return;
    o->fb[x + (y / 8) * OLED_W] |= (uint8_t)(1u << (y & 7));
}

static inline void oled_char(oled_t *o, int x, int y, char ch) {
    const glyph_t *g = NULL;
    for (int i = 0; i < FONT5X7_N; i++) {
        if (FONT5X7[i].ch == ch) {
            g = &FONT5X7[i];
            break;
        }
    }
    if (!g) {
        if (ch >= 'a' && ch <= 'z')
            return oled_char(o, x, y, (char)(ch - 32)); /* fold to upper */
        g = &FONT5X7[0];
    }
    for (int cx = 0; cx < 5; cx++)
        for (int cy = 0; cy < 7; cy++)
            if (g->col[cx] & (1u << cy))
                oled_pixel(o, x + cx, y + cy);
}

static inline void oled_text(oled_t *o, int x, int y, const char *s) {
    for (; *s; s++, x += 6)
        oled_char(o, x, y, *s);
}

/* Draw multi-line text. Both a real newline and the literal two characters
 * backslash-n are treated as line breaks, so shells can pass "a\nb". */
static inline void oled_draw_lines(oled_t *o, int x, int y, const char *s) {
    char line[80];
    size_t k = 0;
    while (*s) {
        if (*s == '\\' && s[1] == 'n') {
            s += 2;
        } else if (*s == '\n') {
            s += 1;
        } else {
            if (k < sizeof line - 1)
                line[k++] = *s;
            s++;
            continue;
        }
        line[k] = '\0';
        oled_text(o, x, y, line);
        y += 10;
        k = 0;
    }
    line[k] = '\0';
    oled_text(o, x, y, line);
}

/* Set the address window to the whole panel, then stream the framebuffer. */
static inline void oled_flush(oled_t *o) {
    const uint8_t win[] = {0x21, 0, OLED_W - 1, 0x22, 0, OLED_PAGES - 1};
    oled_send(o, 0, win, sizeof win);
    oled_send(o, 1, o->fb, sizeof o->fb);
}
```

## font5x7.h — 5x7 font (save as font5x7.h)

```cpp
/* 5x7 bitmap font, generated from hints/work/oled/ssd1306.py.
 * Each glyph is 5 column bytes; bit 0 is the top row. */
#pragma once
#include <stdint.h>

typedef struct {
    char ch;
    uint8_t col[5];
} glyph_t;

static const glyph_t FONT5X7[] = {
    { ' ' , { 0x00, 0x00, 0x00, 0x00, 0x00 } },
    { 'A' , { 0x7E, 0x09, 0x09, 0x09, 0x7E } },
    { 'B' , { 0x7F, 0x49, 0x49, 0x49, 0x36 } },
    { 'C' , { 0x3E, 0x41, 0x41, 0x41, 0x22 } },
    { 'D' , { 0x7F, 0x41, 0x41, 0x41, 0x3E } },
    { 'E' , { 0x7F, 0x49, 0x49, 0x49, 0x41 } },
    { 'F' , { 0x7F, 0x09, 0x09, 0x09, 0x01 } },
    { 'G' , { 0x3E, 0x41, 0x49, 0x49, 0x3A } },
    { 'H' , { 0x7F, 0x08, 0x08, 0x08, 0x7F } },
    { 'I' , { 0x41, 0x41, 0x7F, 0x41, 0x41 } },
    { 'J' , { 0x20, 0x40, 0x41, 0x3F, 0x01 } },
    { 'K' , { 0x7F, 0x08, 0x14, 0x22, 0x41 } },
    { 'L' , { 0x7F, 0x40, 0x40, 0x40, 0x40 } },
    { 'M' , { 0x7F, 0x02, 0x04, 0x02, 0x7F } },
    { 'N' , { 0x7F, 0x02, 0x04, 0x08, 0x7F } },
    { 'O' , { 0x3E, 0x41, 0x41, 0x41, 0x3E } },
    { 'P' , { 0x7F, 0x09, 0x09, 0x09, 0x06 } },
    { 'Q' , { 0x3E, 0x41, 0x51, 0x21, 0x5E } },
    { 'R' , { 0x7F, 0x09, 0x19, 0x29, 0x46 } },
    { 'S' , { 0x46, 0x49, 0x49, 0x49, 0x31 } },
    { 'T' , { 0x01, 0x01, 0x7F, 0x01, 0x01 } },
    { 'U' , { 0x3F, 0x40, 0x40, 0x40, 0x3F } },
    { 'V' , { 0x1F, 0x20, 0x40, 0x20, 0x1F } },
    { 'W' , { 0x7F, 0x20, 0x10, 0x20, 0x7F } },
    { 'X' , { 0x63, 0x14, 0x08, 0x14, 0x63 } },
    { 'Y' , { 0x03, 0x04, 0x78, 0x04, 0x03 } },
    { 'Z' , { 0x61, 0x51, 0x49, 0x45, 0x43 } },
    { '0' , { 0x3E, 0x51, 0x49, 0x45, 0x3E } },
    { '1' , { 0x00, 0x42, 0x7F, 0x40, 0x00 } },
    { '2' , { 0x42, 0x61, 0x51, 0x49, 0x46 } },
    { '3' , { 0x41, 0x49, 0x49, 0x49, 0x36 } },
    { '4' , { 0x18, 0x14, 0x12, 0x7F, 0x10 } },
    { '5' , { 0x27, 0x45, 0x45, 0x45, 0x39 } },
    { '6' , { 0x3E, 0x49, 0x49, 0x49, 0x32 } },
    { '7' , { 0x01, 0x71, 0x09, 0x05, 0x03 } },
    { '8' , { 0x36, 0x49, 0x49, 0x49, 0x36 } },
    { '9' , { 0x26, 0x49, 0x49, 0x49, 0x3E } },
    { '.' , { 0x00, 0x60, 0x60, 0x00, 0x00 } },
    { ',' , { 0x00, 0x70, 0x30, 0x00, 0x00 } },
    { ':' , { 0x00, 0x36, 0x36, 0x00, 0x00 } },
    { ';' , { 0x00, 0x76, 0x36, 0x00, 0x00 } },
    { '-' , { 0x08, 0x08, 0x08, 0x08, 0x08 } },
    { '+' , { 0x08, 0x08, 0x3E, 0x08, 0x08 } },
    { '=' , { 0x14, 0x14, 0x14, 0x14, 0x14 } },
    { '!' , { 0x00, 0x00, 0x5F, 0x00, 0x00 } },
    { '?' , { 0x02, 0x01, 0x51, 0x09, 0x06 } },
    { '\'', { 0x00, 0x00, 0x03, 0x00, 0x00 } },
    { '"' , { 0x00, 0x03, 0x00, 0x03, 0x00 } },
    { '/' , { 0x40, 0x30, 0x08, 0x06, 0x01 } },
    { '(' , { 0x00, 0x3E, 0x41, 0x41, 0x00 } },
    { ')' , { 0x00, 0x41, 0x41, 0x3E, 0x00 } },
    { '*' , { 0x2A, 0x1C, 0x3E, 0x1C, 0x2A } },
    { '_' , { 0x40, 0x40, 0x40, 0x40, 0x40 } },
};
#define FONT5X7_N ((int)(sizeof(FONT5X7) / sizeof(FONT5X7[0])))
```
