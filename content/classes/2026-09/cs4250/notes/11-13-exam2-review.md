---
title: "cs4250 Notes: 11-13 Exam2 Review"
date: "2026-11-13"
---

## Upcoming Meetings

Next Week:

- Monday, Nov 16: Project Work Day
- Wednesday, Nov 18: Lecture (how to pick a dev board?)
- Friday, Nov 20: Exam 2

Thanksgiving Week:

- Monday, Nov 23: Project Work Day

## What's on the Exam

- Realtime OS Scheduling
- Pipelining
- Caches
- Multiprocessors and GPUs

## Scheduling

- We create a static set of tasks, each with a priority.
- Higher numbers are higher priority (in freertos, in linux it's the other way)
- The scheduler is a function that runs the highest priority
ready task
- We start the first task by running the scheduler
- Timers run on the timer interrupt (which the hardware clock does at fix intervals)
- Any time we're in OS code (we did a call into the OS library) is an
opportunity to reschedule.
- Our example will be touch screen multiplayer game.

**Startup**:

- Idle task, prio 0, `while (1) { wait_for_interrupt(); yield(); }`, does nothing, always
scheduleable
- Worker task, prio 1, `while (1) { compute_game_update(); update_state();
yield(); }`
- Network driver, prio 2, `while (1) { get_network_event(); update_state();
yield(); }`
- UI task, prio 3, `while (1) { get_touch_event_or_state_change(); update_ui(); update_state(); yield(); }`

**Runtime**:

- UI task blocks on get()
- Driver blocks on get()
- Worker does some work, blocks until more work.
- Idle thread runs, sleeps.
- Network packet arrives, interrupt, interrupt handler, unblocks network driver,
  update_state unblocks UI, yield()
- UI task runs, UI has changed so update UI, yield()
- etc.

**Critical Sections**

- An interrupt can happen at any time, and it immediately changes what code is
running.
- To avoid data races and the resulting data corruption we need to treat atomic
operations as critical sections:
  - On a multi-core system, that'd be a mutex
  - On a single-core system, it's sufficient to mask interrupts
- Why must critical sections finish ASAP (much faster than a timer tick)?
- Why are all interrupt handlers critical sections?
- When an interrupt triggers and interrupts are masked, what must happen
immediately when interrupts are unmasked?
- Why must interrupt handlers/drivers check for more than one interrupt event
when they are triggered once?

## Pipelining

Key picture: <https://nattuck.github.io/sg2000-hints/pipelining-slides/#/stall>

What causes stalls?

- Data dependencies
- Control hazards
- Loads

How can we avoid stalls?

- Instruction reordering
- Speculative execution
- Simultaneous multithreading

## Caches

We've got a 256 byte, byte addressed RAM. We've got a 16 byte
cache with 4 byte cache lines.

So:

- We have 8 address bits: 4-6 tag, 2-0 index, 2 offset
- See the end for more detail.

Sets:

- Lines in the same set potentially collide.

Ways:

- How many spots in cache a given address can go.
- If we have multiple ways, we need eviction policy.

## Multiprocessors and GPUs

If an embarrassingly parallel task takes 12 seconds on a 2 GHz single-core
processor, how long would we expect it to take on a 1 GHz quad core with
the same processor architecture otherwise?

Alice had a single threaded process that took 20 seconds to run, so she decided
to port it to four threads for her quad core processor. Now it takes 4 seconds
to run. It's the same algorithm, doing the same amount of work, just split
evenly across four cores. How could she have gotten a super-linear speedup?

Draw a 4 core processor where cores 0/1, 2/3 share L2 and all four cores share
L3. Put in arbitrary latencies. If a thread on core 0 is waiting on a mutex
built with atomic compare and swap and a thread on core 3 unlocks that mutex
without having done any write to the assocated data, how long does it take
for the core 0 thread to start running?

## Overflow

We've got a 256 byte RAM with 16-bit addressable words. That means we have 7
address bits...

# The full cache example

## 256B RAM with 16B Cache — Direct Mapped, 2-Way, 4-Way, Fully Associative

Below is a complete, self-contained example. I'll define the geometry, then walk
through identical read sequences for each associativity so you can see the
hit/miss differences side by side.

## Geometry

- **RAM:** 256 bytes → 8-bit address (`0x00`–`0xFF`)
- **Cache size:** 16 bytes
- **Line size:** 4 bytes → **4 cache lines total**
- **Offset bits:** 2 (`addr[1:0]`)
- **Line index bits:** 2 (`addr[3:2]`) — for direct mapped
- **Tag bits:** 4 (`addr[7:4]`)

Line starting addresses in RAM: `0x00, 0x04, 0x08, 0x0C, ... 0xFC` (64 distinct lines in RAM, 4 can be cached at once).

```
Address:  [7 6 5 4 | 3 2 | 1 0]
           tag      index  offset
```

### Set/way layout per associativity

| Associativity | Sets | Ways | Index bits | Which bits select set |
|---|---|---|---|---|
| Direct mapped | 4 | 1 | 2 | `addr[3:2]` |
| 2-way | 2 | 2 | 1 | `addr[2]` |
| 4-way | 1 | 4 | 0 | (none — one set) |
| Fully assoc. | 1 | 4 | 0 | (none — one set) |

> Note: with only 4 lines total, **4-way and fully associative are structurally identical**. That's an important teaching point — fully associative is just "associativity = number of lines." I'll still run both and note the equivalence.

## The Test Sequence

We read four addresses that all map to **different sets in direct-mapped** but **collide in the smaller-set designs**. This is the classic demonstration.

```
Read 0x00   (tag=0, line index=0)
Read 0x10   (tag=1, line index=0)   <- same index as 0x00
Read 0x20   (tag=2, line index=0)   <- same index as 0x00
Read 0x30   (tag=3, line index=0)   <- same index as 0x00
Read 0x00   (re-read to show eviction effects)
```

All four addresses have `addr[3:2] = 00`. In direct-mapped they fight over **line slot 0**. In 2-way they fight over **set 0** (2 ways). In 4-way/full they all fit.

---

## 1. Direct Mapped (4 sets × 1 way)

State: 4 slots, each `{valid, tag}`. Slot = `addr[3:2]`.

| # | Read | Slot | Tag | Result | Cache contents after (slot: tag) |
|---|------|------|-----|--------|----------------------------------|
| 1 | 0x00 | 0 | 0 | **MISS** (cold) | 0:0 |
| 2 | 0x10 | 0 | 1 | **MISS** (tag conflict, evict 0x00) | 0:1 |
| 3 | 0x20 | 0 | 2 | **MISS** (evict 0x10) | 0:2 |
| 4 | 0x30 | 0 | 3 | **MISS** (evict 0x20) | 0:3 |
| 5 | 0x00 | 0 | 0 | **MISS** (evict 0x30) | 0:0 |

**Result: 5 reads, 5 misses, 0 hits.** Every access thrashes the single slot. This is the worst case for direct-mapped — the "conflict miss" problem in its purest form.

---

## 2. Two-Way Set Associative (2 sets × 2 ways)

State: 2 sets, each with 2 ways. Set = `addr[2]`. LRU replacement within a set.

All four addresses have `addr[2]=0`, so they all map to **set 0**.

| # | Read | Set | Tag | Result | Set 0 ways after (tag, LRU order) |
|---|------|-----|-----|--------|-----------------------------------|
| 1 | 0x00 | 0 | 0 | **MISS** (cold) | [0, –] |
| 2 | 0x10 | 0 | 1 | **MISS** (free way) | [0, 1] |
| 3 | 0x20 | 0 | 2 | **MISS** (evict LRU=0) | [2, 1] |
| 4 | 0x30 | 0 | 3 | **MISS** (evict LRU=1) | [2, 3] |
| 5 | 0x00 | 0 | 0 | **MISS** (evict LRU=2) | [0, 3] |

**Result: 5 reads, 5 misses, 0 hits.** Still thrashes, but notice the *pattern* differs — it's evicting by LRU among 2 ways rather than a fixed slot. Add one more read (`0x30` again) and you'd get a hit, because `0x30` survived in way 1. The extra way buys you some resilience, but with 4 addresses cycling through 2 ways you still get evictions every access.

---

## 3. Four-Way Set Associative (1 set × 4 ways)

State: 1 set, 4 ways. No index bits. LRU replacement.

| # | Read | Tag | Result | Set 0 ways after (tags present) |
|---|------|-----|--------|---------------------------------|
| 1 | 0x00 | 0 | **MISS** (cold) | {0} |
| 2 | 0x10 | 1 | **MISS** (free way) | {0,1} |
| 3 | 0x20 | 2 | **MISS** (free way) | {0,1,2} |
| 4 | 0x30 | 3 | **MISS** (free way) | {0,1,2,3} |
| 5 | 0x00 | 0 | **HIT** ✅ | {0,1,2,3} |

**Result: 5 reads, 4 misses, 1 hit.** All four colliding lines coexist. The re-read of `0x00` hits. This is the payoff of associativity — conflict misses are eliminated up to the associativity level.

---

## 4. Fully Associative (4 ways, no index)

Functionally identical to 4-way here because the cache has exactly 4 lines, so "fully associative" = "4-way with one set." The lookup is a tag compare against all 4 lines in parallel; there is no set selection at all.

| # | Read | Tag | Result | Ways after |
|---|------|-----|--------|-----------|
| 1 | 0x00 | 0 | **MISS** | {0} |
| 2 | 0x10 | 1 | **MISS** | {0,1} |
| 3 | 0x20 | 2 | **MISS** | {0,1,2} |
| 4 | 0x30 | 3 | **MISS** | {0,1,2,3} |
| 5 | 0x00 | 0 | **HIT** ✅ | {0,1,2,3} |

**Result: 5 reads, 4 misses, 1 hit** — same as 4-way. To make fully-associative *differ* from 4-way, you'd need a cache with more lines than the set associativity (e.g., 8 lines, 4-way vs. fully assoc 8-way). With 16B cache / 4B lines, the two collapse together. **Worth calling out explicitly in whatever you're building.**

---

## Side-by-Side Summary

| Scheme | Sets | Ways | Misses | Hits | Hit rate | Key failure mode |
|---|---|---|---|---|---|---|
| Direct mapped | 4 | 1 | 5 | 0 | 0% | Conflict thrash on same index |
| 2-way | 2 | 2 | 5 | 0 | 0% | Conflict thrash, softer (LRU) |
| 4-way | 1 | 4 | 4 | 1 | 20% | Only capacity/compulsory miss |
| Fully assoc. | 1 | 4 | 4 | 1 | 20% | Same as 4-way at this size |

## Suggested Next Experiments (to differentiate the designs)

To make the four schemes produce **four distinct** results, pick addresses that spread across sets differently:

1. **Hit-rate sweep:** Read `0x00,0x04,0x08,0x0C` (four distinct direct-mapped slots) then re-read all four. Direct-mapped: 4M+4H. 2-way: needs 2 sets × 2 ways → also 4M+4H. All schemes hit 50%. Not differentiating.
2. **The killer pattern for 2-way vs 4-way:** Read `0x00, 0x08, 0x10, 0x18` — all have `addr[3:2]=00`, so all hit set 0 in direct-mapped (index bits `[3:2]`), but only `addr[2]` distinguishes 2-way sets. Compute both to see 2-way split them 2-and-2 while direct-mapped crushes all into one slot.
3. **Add an LRU trace table** per set so students can watch replacement decisions, not just hit/miss counts.

## Reference Implementation Sketch (Python, cache-agnostic core)

```python
class Cache:
    def __init__(self, num_sets, ways, line_size=4, name=""):
        self.num_sets, self.ways, self.line_size = num_sets, ways, line_size
        self.name = name
        # each way: {'valid': bool, 'tag': int, 'lru': int}
        self.sets = [[{'valid': False, 'tag': None, 'lru': 0}
                      for _ in range(ways)] for _ in range(num_sets)]
        self.clock = 0
        self.hits = self.misses = 0

    def access(self, addr):
        offset_bits = self.line_size.bit_length() - 1          # 2
        index_bits  = self.num_sets.bit_length() - 1           # 0..2
        tag   = addr >> (offset_bits + index_bits)
        index = (addr >> offset_bits) & (self.num_sets - 1)
        s = self.sets[index]
        self.clock += 1

        for w in s:                                    # hit?
            if w['valid'] and w['tag'] == tag:
                w['lru'] = self.clock; self.hits += 1
                return f"HIT  (set {index}, tag {tag})"

        # miss -> pick invalid way, else LRU
        victim = next((w for w in s if not w['valid']),
                      min(s, key=lambda w: w['lru']))
        victim.update(valid=True, tag=tag, lru=self.clock)
        self.misses += 1
        return f"MISS (set {index}, tag {tag})"

configs = [
    Cache(4, 1, name="direct mapped"),
    Cache(2, 2, name="2-way"),
    Cache(1, 4, name="4-way"),
    Cache(1, 4, name="fully assoc"),
]
seq = [0x00, 0x10, 0x20, 0x30, 0x00]
for c in configs:
    print(f"--- {c.name} ---")
    for a in seq:
        print(f"  read 0x{a:02X}: {c.access(a)}")
    print(f"  totals: {c.hits} hits, {c.misses} misses\n")
```

Running that reproduces the tables above exactly. The `Cache(1, 4, ...)` twice is the concrete demonstration that fully-associative and 4-way are the same machine when lines == ways.

Want me to extend this into a SystemVerilog testbench, or add a working-set sweep that plots hit rate vs. associativity?
