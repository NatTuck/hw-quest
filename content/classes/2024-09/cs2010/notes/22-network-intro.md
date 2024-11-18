---
title: "cs2010 Notes: 22 Network Intro"
date: "2024-11-17"
---

# Network Addresses and Routing

 - Two machines can communicate on one wire.
 - With more machines, there needs to be an address mechanism.
 - Circuit switching vs. packet switching
 - IPv4 addresses
 - LAN, WAN, Subnets and routing
 - IPv6 addresses
 
# Layers

Web browsing

 - Physical (wire / radio)
 - Data (ethernet / wifi)
 - Network (IP)
 - Transport (TCP)
 - Security (TLS)
 - Application (HTTPS)

# Names and DNS

 - DNS lookups
 - DNS cache

# TCP

 - How do we make a reliable stream based protocol using
   unreliable packets?
 - TCP ports
 - Rant about WebSockets


# TLS

 - Cryptography
   - Public key
     - Encryption
     - Signatures
   - Secret key 
     - Encryption
     - Authentication Codes
 - How do we trust a website?
   - The messages are signed, but by who?
   - The certificate is signed, but by who?
   - Certificate authorities
   - Threat model: Great for buying stuff with a credit card,
     not good enough for very serious threats.
   - Letsencrypt
