---
title: "Notes: 39 Wrap Up"
date: "2023-11-29"
---

Next time: Sample Final

Remember:

> To encourage more responses, each class has the chance to earn a 1%
> bonus to everyone’s final grade. This bonus applies if at least 75%
> of the students complete their evaluations by 10am on the Monday of
> finals week.

Quick Topic: Networking & Internet

 - Every computer on the internet has an IP address
 - The Internet Protocol delivers packets to IP addresses
 - IPv4 packets are limited to 64kB
 - In practice, they are frequently limited to ~1.2kB because that's
   the limit on Ethernet
 - IP packets are unreliable - they may or may not actually get to
   their destitionation
 - Transmission Control Protocol builds reliable streams on top of IP packets
   - You open a connection
   - Either side can send and recieve arbitrary sized chunks of data
   - Data is delivered reliably and in order.
 - How?
   - Send a packet, reply with a confirmation, resend or send the next packet
   - That's too slow
   - Window: 
     - Send the next 10 packets
     - Send an array of 10 confirmations
     - Resend any missed packets, send any new packets in the shifted 10 packet window
 - HTTP builds sending "files" on top of TCP
   - GET /index.html HTTP/1.0
   - 200 OK/n/n<html ...
   - GET /logo.png HTTP/1.0
   - 200 OK/n/nPNG bytes...
 - Websockets tunnels streams "on top" of HTTP...
 
## Semester Review:

 - Very basics of Java language:
   - Types
   - Classes
   - Methods
 - Design Recipe
 - Records
 - Interfaces
 - Linked Lists (ConsList)
 - Generics
 - Lambda
 - List#map, List#filter
 - Asymptotic Complexity
 - Arrays
 - ArrayList
 - Stacks
 - Queues
 - Deques
 - Sets
 - Binary Trees
 - Iterable, Comparable
 - Binary Search Trees
 - Balancing a BST
 - TreeMap, TreeSet
 - Hash tables
 - HashMap, HashSet
 - Graphs
 - Threads, Parallel Speedup
 - Data structures in the Java stdlib
   - ArrayList, LinkedList, ArrayDeque, HashSet, HashMap, TreeSet, TreeMap
 - Strings, characters, character encoding
 - Networking

How many bits do you need to store a single number between 1 and 10,000?
