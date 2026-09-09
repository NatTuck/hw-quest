---
title: "cs4250 Notes: 09-09 Dev Board"
date: "2026-09-07"
---

- Remember: Attendance on Inkfish

## Today, we're going to get GPIO to work on the dev boards.

Follow directions here:

- https://github.com/scpcom/sophgo-sg200x-debian
- Boot by plugging into laptop via USB. This gives you a USB eithernet
  device with an IP assigned by the board. The board is .1 on that
  subnet.

## Blink Script

```
debian@duos-1d1d:~$ cat blink.py 
#!/usr/bin/env python3
"""Blink an LED on the Milk-V Duo S, J3 header pin 7 (GPIO B18).

Run with sudo:  sudo python3 blink.py
Blink rate: 2 Hz (LED on 250 ms, off 250 ms).
"""
import os
import subprocess
import sys
import time

GPIO = 466
SYFS = "/sys/class/gpio"
GPIO_DIR = f"{SYFS}/gpio{GPIO}"
PERIOD_S = 0.5  # 2 Hz -> half period
DUO_PINMUX = "/usr/bin/duo-pinmux"
PIN, FUNC = "B18", "B18"


def shell(cmd):
    return subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)


def sysfs_write(path, value):
    with open(path, "w") as f:
        f.write(value)


def setup():
    if not os.path.exists(DUO_PINMUX):
        print(f"warning: {DUO_PINMUX} not found, skipping pinmux", file=sys.stderr)
    else:
        r = shell([DUO_PINMUX, "-w", f"{PIN}/{FUNC}"])
        print(f"pinmux B18 -> GPIO: rc={r.returncode} {r.stdout.strip()}")
        if r.returncode != 0:
            raise SystemExit("failed to remux B18 as GPIO (need root?)")

    if not os.path.exists(f"{GPIO_DIR}/direction"):
        sysfs_write(f"{SYFS}/export", str(GPIO))
        print(f"exported gpio{GPIO}")

    sysfs_write(f"{GPIO_DIR}/direction", "out")
    sysfs_write(f"{GPIO_DIR}/value", "0")
    print(f"gpio{GPIO} (B18, J3 pin 7) ready as output")


def cleanup():
    try:
        sysfs_write(f"{GPIO_DIR}/value", "0")
    except OSError:
        pass
    try:
        sysfs_write(f"{SYFS}/unexport", str(GPIO))
    except OSError:
        pass
    print("cleaned up, gpio unexported")


def main():
    setup()
    try:
        print("blinking at 2 Hz (Ctrl+C to stop)...")
        while True:
            sysfs_write(f"{GPIO_DIR}/value", "1")
            time.sleep(PERIOD_S / 2)
            sysfs_write(f"{GPIO_DIR}/value", "0")
            time.sleep(PERIOD_S / 2)
    except KeyboardInterrupt:
        pass
    finally:
        cleanup()


if __name__ == "__main__":
    main()
```


## See also

- https://armbian.com/boards/milkv-duos-riscv
- https://github.com/ruyisdk/support-matrix/blob/main/Oz64/Debian/README.md
