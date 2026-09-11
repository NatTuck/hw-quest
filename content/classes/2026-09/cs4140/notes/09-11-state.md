---
title: "cs4140 Notes: 09-11 State Management"
date: "2026-09-09"
---

## First Thing: Review some PRs

Let's take a look, we're reviewing for:

- Does the PR address the issue?
- Do the automatic tests pass, including lints?
- Does the code look reasonable?
  - Correctness, style, efficiency, etc.
  - Anything obviously missing?
- Is the code mostly on-topic?
  - Cleanups / refactoring is okay, but it should be related.
  - General refactors can and should be their own issue, and issues
  can inspire and depend on other issues.
- Manual test.


## Application State

We can split the data in a computer program into two parts:

- Static data doesn't change when the program runs.
  - The card list and card art in BotBash
  - The levels in Super Mario Brothers
- Dynamic data, or application state, does change.
  - The current decks and board in BotBash
  - The player and enemy positions in Super Mario Brothers

The key thing to have a working, non-buggy app is to correctly design
and manage this data, especially the application state.

State is annoying because it changes. Anything you can move from state to
static data is something that you don't need to worry about changing.

Two questions about state:

- How is it shaped? (data type)
  - Partially a technical data structures / efficiency question.
  - Mostly a design / systems analysis / "what are we doing?" question. 
- Where does it live?
  - Almost the same question: How long does it live?

Where can state live? Considering Botbash, we've got three computers:

- The one with the server (one of these)
  - Trusted, we control the code and data
- One with a user's browser (two of these)
  - Untrusted, the user could change code/data

And for each of those we physically have two places to put data:

- RAM - Fast, doesn't survive crashes/reboots
- Disk - Slower, does survive crashes/reboots

On disk on the server is the safest place to put data, but it's also
a real potential performance bottleneck if we misuse it.

Necessarily we have multiple copies of data:

- The board in BotBash needs to be visible to both players, so to actually
render it it needs to be in RAM on both browsers.
- The structure doesn't let the players communicate directly, so there must be a
copy on the server too.
- We could, conceptually, have a system where the copies can change
independently and then get merged. That's really, really hard.
- Instead, we want to declare one copy the primary copy. In this case, the one
on the server. The others are just local caches. The server copy is our single
source of truth.

## Gemini Says

Here are four distinct, well-known interactive multi-user applications illustrating how application state is distributed across **Server Disk**, **Server RAM**, **Client Disk**, and **Client RAM**.

---

### 1. Google Docs (Collaborative Document Editing)

* **Server Disk (Persistent & Authoritative):**
  * The canonical document history (log of all accepted Operational Transformation / CRDT operations).
  * Document access control lists (ACLs), ownership permissions, and user comments/resolved comment history.
* **Server RAM (Volatile & High-Throughput):**
  * The active editing session's document state, used to order and reconcile simultaneous incoming edits before flushing them to disk.
  * Active WebSocket connections and presence tracking (which users currently have the document open).
* **Client Disk (e.g., `IndexedDB` / `localStorage`):**
  * Cached document chunks for offline editing and faster re-opening.
  * Queued offline edits waiting to be synchronized when connectivity returns.
  * User editor preferences (e.g., show ruler, dark mode, spell-check dictionary additions).
* **Client RAM (Volatile & Immediate):**
  * Rendered layout tree / DOM and current viewport scroll position.
  * Local cursor coordinates and current text selection range.
  * The optimistic local edit buffer (keystrokes applied visually before the server has acknowledged them).
  * Current positions and labels of remote collaborators' colored cursors.

---

### 2. Discord (Real-Time Group Messaging & Voice)

* **Server Disk (Persistent & Authoritative):**
  * Historical text message logs, guild/server hierarchy, roles, permissions, and media attachments.
  * User profile records and persistent channel configurations.
* **Server RAM (Volatile & High-Throughput):**
  * Active gateway WebSocket connections and heartbeat monitors.
  * Real-time presence states (e.g., Online, Idle, "Playing *Elden Ring*").
  * Ephemeral voice channel state (routing tables for who is speaking and connected to which voice server).
* **Client Disk (e.g., `localStorage` / Cache Storage):**
  * Authentication token (`token`) and session identifiers.
  * Draft message text saved per-channel (so switching servers doesn't erase your half-typed message).
  * Cached recent messages and channel listings to avoid cold network requests on launch.
* **Client RAM (Volatile & Immediate):**
  * Real-time "Alice is typing..." indicator timers.
  * Decoded incoming/outgoing WebRTC audio buffers.
  * Current scroll position in the active chat channel.
  * In-memory UI state: open emoji pickers, popovers, and focused input elements.

---

### 3. Chess.com (Turn-Based Multiplayer Board Game)

* **Server Disk (Persistent & Authoritative):**
  * Archived finished games in PGN format with full move timestamps.
  * Player rating records (Elo/Glicko) and historical win/loss statistics.
  * Account credentials and player matchmaking preferences.
* **Server RAM (Volatile & High-Throughput):**
  * The authoritative current board state (FEN string) and the active countdown clocks for ongoing games.
  * The matchmaking queue (active search requests pairing players of similar ratings).
  * Live spectator and player socket connections for active matches.
* **Client Disk (e.g., `localStorage` / Cookies):**
  * Session cookies for authentication.
  * Visual and audio settings (selected piece set, board theme, sound effects volume, auto-queen preference).
* **Client RAM (Volatile & Immediate):**
  * Drag-and-drop coordinates of the chess piece currently held by the user's mouse/finger.
  * Client-side clock interpolation (ticking down smoothly between authoritative server sync packets).
  * Valid move indicator highlights (dots showing legal destination squares for the currently picked-up piece).
  * Local premove queue (moves the player has entered before their opponent has finished their turn).

---

### 4. Figma (Collaborative Vector Design Tool)

* **Server Disk (Persistent & Authoritative):**
  * Canonical file scene graph and persistent version history/snapshots.
  * Shared design libraries, published team components, and asset files (images/SVGs).
* **Server RAM (Volatile & High-Throughput):**
  * The active multiplayer room state reconciling simultaneous vector transform operations.
  * Active pub/sub channels routing live participant viewport positions and tool states.
* **Client Disk (e.g., `IndexedDB` / `localStorage`):**
  * Local file cache to quickly restore large vector files on page reload.
  * Workspace configuration (panel visibility, snapping preferences, grid visibility).
  * Offline modification queue for recovery if the tab crashes.
* **Client RAM (Volatile & Immediate):**
  * The WebGL/Canvas scene graph and GPU texture memory actively rendering the canvas.
  * Current pan/zoom matrix and the selection box being dragged across the screen.
  * Local Undo/Redo stack for the active user's uncommitted or undoable operations.
  * Interpolated coordinate smoothing for other collaborators' moving mouse pointers.

Here are two more distinct video games—from vastly different genres—showing how dynamic application state is handled across the four locations.

---

### 1. *Minecraft* (Multiplayer Sandbox / Survival)

* **Server Disk (Persistent & Authoritative):**
  * **Region files (`.mca`):** Saved block state of every modified chunk in the world (placed blocks, destroyed terrain, redstone wiring).
  * **Player data files (`<UUID>.dat`):** Saved inventory contents, Ender Chest items, XP level, health, hunger, and spawn bed coordinates.
  * Server configuration, whitelist/ban lists, and the master world seed.
* **Server RAM (Volatile & High-Throughput):**
  * **Active loaded chunks:** The ring of chunks kept in memory around active players within the server's view distance.
  * **Tick loop simulation (20 Hz):** Living entity states (mob AI pathfinding, positions, health, velocity), active redstone propagation, in-flight arrows, and falling gravity blocks.
  * Open network socket table mapping active client connections to player entities.
* **Client Disk (Local App Data / Storage):**
  * Cached server assets (server-provided resource/texture packs).
  * Local user settings (`options.txt`: render distance, keybindings, FOV, sound volume, GUI scale).
  * Saved server list and cached server ping/status icons.
* **Client RAM (Volatile & Immediate):**
  * **Tessellated chunk meshes:** Polygon and texture data sent to GPU/VRAM for the blocks currently visible on screen.
  * **Block-breaking progress:** Current damage stage (the cracking animation 0–9) of the block the player is actively mining.
  * **Client-side player prediction:** Local coordinate updates as you walk/jump, smoothing movement before server confirmation.
  * Positional audio buffers playing ambient cave sounds and step audio.

---

### 2. *Rocket League* (Fast-Paced Physics / Competitive Sports)

* **Server Disk (Persistent & Authoritative):**
  * Player profile and inventory (unlocked car bodies, goal explosions, decals, titles).
  * Competitive ranking data (Matchmaking Rating/MMR, rank tier, division) and historical match records.
  * Account punishment status, report logs, and matchmaking queue configurations.
* **Server RAM (Volatile & High-Throughput):**
  * **Authoritative physics engine (120 Hz tick):** The true vectors, velocities, angular momentum, and positions of the ball and all cars on the field.
  * **Live match state:** Match clock, goal counters, boost pad active/recharging cooldown timers, and demolition respawn countdowns.
  * Active UDP socket sessions routing low-latency inputs to/from all players in the match.
* **Client Disk (Local Game Storage / Save Data):**
  * **Car presets:** Local garage loadouts (which body, paint colors, and wheels are assigned to the Blue vs. Orange team).
  * Camera and control settings (camera distance, stiffness, swivel speed, controller deadzones).
  * Saved match replays (`.replay` files downloaded from completed games).
* **Client RAM (Volatile & Immediate):**
  * **Client-side physics prediction buffer:** Local physics running ahead of the server so steering, jumping, and boosting feel instantaneous without waiting for network latency.
  * **Reconciliation/rollback state:** A ring buffer of recent inputs used to rewind and re-simulate car trajectories when a server correction arrives.
  * Ephemeral rendering states: active tire skid marks on the field, supersonic trail particle effects, and ball trajectory prediction line (if in training mode).
  * Active quick-chat selection wheel state (e.g., holding D-pad for *"What a save!"*).
