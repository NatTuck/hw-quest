---
title: "cs4250 Notes: 09-11 Fishwaldo"
date: "2026-09-08"
---

## Setup Script (This Host)

Save this as `~/milkv-nat.sh` and run it when the Duo is connected:
```bash
#!/bin/bash
# Enable IP forwarding
sudo sysctl -w net.ipv4.ip_forward=1

# Clear old NAT rules and add new one for the Duo's subnet
sudo iptables -t nat -F POSTROUTING 2>/dev/null
sudo iptables -t nat -A POSTROUTING -s 10.29.30.0/24 -j MASQUERADE

echo "NAT enabled for MilkV Duo"
```

## Setup Script (MilkV Duo)

Save this on the Duo as `/usr/local/bin/setup-net.sh`:
```bash
#!/bin/bash
# Find this host's IP on the USB network
GATEWAY=$(ip route | grep 10.29.30 | head -1 | awk '{print $3}')

# Set default route
ip route del default 2>/dev/null
ip route add default via $GATEWAY

# Add DNS if not present
grep -q '8.8.8.8' /etc/resolv.conf || echo 'nameserver 8.8.8.8' >> /etc/resolv.conf

echo "Network configured via $GATEWAY"
```

Run on the Duo after connecting:
```bash
sudo setup-net.sh
ping -c 2 8.8.8.8
```

## One-Liners

**This host** (run when Duo connects):
```bash
sudo sysctl -w net.ipv4.ip_forward=1 && sudo iptables -t nat -A POSTROUTING -s 10.29.30.0/24 -j MASQUERADE
```

**MilkV Duo** (run after connecting):
```bash
G=$(ip route | grep 10.29.30 | head -1 | awk '{print $3}'); ip route del default; ip route add default via $G; echo 'nameserver 8.8.8.8' >> /etc/resolv.conf
```

## Verify

From MilkV Duo:
```bash
ping -c 2 8.8.8.8
```

## Arduino Blink Sketch

### Install Arduino CLI and Board Support
```bash
# Install Arduino CLI
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh

# Add Sophgo board package
arduino-cli config add board_manager.additional_urls https://github.com/kubuds/sophgo-arduino/releases/download/v0.2.5/package_sg200x_index.json
arduino-cli core update-index

# Install SG200X core
arduino-cli core install sophgo:SG200X
```

### Create Blink Sketch
```cpp
#define LED_PIN 0

void setup() {
  pinMode(LED_PIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_PIN, HIGH);
  delay(500);
  digitalWrite(LED_PIN, LOW);
  delay(500);
}
```

### Compile
```bash
arduino-cli compile --fqbn sophgo:SG200X:duo /path/to/sketch
```

### Flash via USB
```bash
arduino-cli upload -b sophgo:SG200X:duo -p /dev/ttyUSB0 /path/to/sketch
```

### Flash via Network (if SSH configured)
```bash
scp sketch.elf root@10.29.30.1:/tmp/
# Then flash using device utilities
```

**Note:** LED_PIN 0 controls the onboard LED on MilkV Duo.

## Control RTOS Core LED from Linux

The MilkV Duo has a dual-core design: big core (C906 Linux) and small core (RTOS). You can control the RTOS core's LED from the Linux system using the mailbox interface.

### RTOS Blink Program (Linux → RTOS)
```c
#include <stdio.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>

#define RTOS_CMDQU_DEV_NAME "/dev/cvi-rtos-cmdqu"
#define RTOS_CMDQU_SEND_WAIT _IOW('r', 1, unsigned long)

enum SYS_CMD_ID { CMD_DUO_LED = 0x13 };
enum DUO_LED_STATUS { DUO_LED_ON = 0x02, DUO_LED_OFF };

struct cmdqu_t {
    unsigned char ip_id;
    unsigned char cmd_id : 7;
    unsigned char block : 1;
    unsigned short mstime;
    unsigned int  param_ptr;
} __attribute__((packed));

int main() {
    int fd = open(RTOS_CMDQU_DEV_NAME, O_RDWR);
    struct cmdqu_t cmd = {0, 0x13, 1, 100, DUO_LED_ON};
    
    while(1) {
        ioctl(fd, RTOS_CMDQU_SEND_WAIT, &cmd);
        printf("LED ON\n"); sleep(1);
        cmd.param_ptr = DUO_LED_OFF;
        ioctl(fd, RTOS_CMDQU_SEND, &cmd);
        printf("LED OFF\n"); sleep(1);
    }
}
```

### Compile and Run
```bash
# Compile on your host
gcc -o milkv-rtos-blink milkv-rtos-blink.c

# Copy to MilkV Duo
scp milkv-rtos-blink root@10.29.30.1:/tmp/

# Run on MilkV Duo
ssh root@10.29.30.1 "/tmp/milkv-rtos-blink"
```

This will blink the onboard LED by sending commands from Linux to the RTOS core via mailbox.

### Quick Start (already done)
```bash
# Copy RISC-V binary to MilkV Duo
riscv64-linux-gnu-gcc -o milkv-rtos-blink milkv-rtos-blink.c
scp milkv-rtos-blink debian@10.29.30.1:/tmp/

# Run on MilkV Duo (requires sudo for /dev/cvi-rtos-cmdqu access)
ssh debian@10.29.30.1 "sudo /tmp/milkv-rtos-blink"
```

The LED is now blinking! The Linux system (big core) is controlling the RTOS core (small core) LED via the mailbox interface.
