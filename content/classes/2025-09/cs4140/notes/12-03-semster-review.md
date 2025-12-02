---
title: "cs4140 Notes: 12-03 Semester Review"
date: "2025-12-01"
---

# CS4140 Fall 2025: Semester Review

## Class Goals and Structure

**Software Engineering** focuses on building large projects in teams:
- Agile practices (Kanban via Taiga.io).
- GitHub workflow: Forks, feature branches, PR reviews.
- Continuous Integration/Deployment (GitHub Actions).
- Tools: Inkfish (attendance/assignments), Aider + OpenRouter (LLM coding assist).
- One big team project: **Shard**, a web-based MUD (Multi-User Dungeon) with federation goals.
- Weekly lectures + in-class demos + Taiga stories.

**New this semester**:
- Heavy LLM use for code generation/tests (Aider).
- Vague agile: Collaborative planning, customer talks (in-class), CI/CD.

## Tech Stack

- **Backend**: Elixir/Phoenix (OTP for concurrency/reliability).
  - Ecto/Postgres for DB.
  - Channels/LiveView for real-time.
  - GenServers/Supervisors/Registry for game state.
- **Frontend**: HEEx templates + React (via esbuild/pnpm).
- **Deployment**: Ubuntu VPS (RackNerd/etc.), Nginx, Systemd, prod releases.
- **Other**: Tailwind/Flowbite, Swoosh (email), SQLite for demos.

## Project Timeline: Shard

### Weeks 1-3: Setup & Basics
- GitHub org (psu-cs4140/shard), Taiga board.
- `mix phx.new shard`.
- Add users/auth (`phx.gen.auth`), admins.
- CRUD demo (Goats).
- Deploy to `shard.homework.quest` (VPS checklist: ASDF, env vars, systemd).

### Weeks 4-6: UI & Real-time
- LiveView/Channels for forms/comments.
- React integration (invites list via AJAX).
- Game design: Rooms, zones, chars/mobs/items.
- Async events (GenServer for goblin fights/healing).

### Weeks 7-9: Process & Quality
- Strict PR rules: Single topic, tests preserved, coverage up.
- CI: `mix format --check`, `mix test --cover` (20%+), Credo (style/max file length).
- Hangman demo: React -> Channel -> GenServer (multiplayer, named games, DB scores).

### Weeks 10-12: Features & Polish
- Email: Mailjet API for auth links.
- Invite codes/links.
- Licensing audit, dep security (left-pad, supply chain attacks).
- Performance: TCP slow-start, TTFB, Pagespeed, caching.

### Weeks 13+: Advanced Topics
- **LLMs**: Tokens/embeddings, training/inference, quantization (Q4_K), llama.cpp/OpenAI API.
  - Run local (CPU/GPU), browser (bchat demo).
  - Integration: LangChain/Elixir for tools/agents.
- **Scaling/Replication**: Indexes, read replicas, sharding, CAP theorem, NoSQL (CouchDB/Riak/Cockroach).
- **Distributed State**: Byzantine Generals, single-source truth (server authoritative).
- Final features: Admin invites, zones/quests, multiplayer playtest.

## Key Lessons

### Agile/Process
- Kanban > Waterfall for discovery-heavy projects.
- PR checklists prevent merge hell.
- Coverage/Credo/format in CI catches issues early.
- LLM (Aider) accelerates boilerplate/tests, but review outputs.

### Elixir/Phoenix Strengths
- OTP shines for game servers (fault-tolerant, concurrent).
- LiveView/Chans simplify real-time vs. React+WebSockets.
- Deployment straightforward (releases beat Docker for small VPS).

### Challenges & Wins
- **Wins**: Deployed game early, multiplayer Hangman, email auth, CI at 90%+ coverage.
- **Challenges**: File bloat (refactor!), dep audits, scaling DB reads.
- **LLM Impact**: $5-55/student; sped prototyping, but Elixir learning curve persists.
- **Security**: Auth, supply chain (npm graph horror), replication/backup.

## Final Deliverables
- Midterm reports: Progress, LLM spend, Elixir comfort.
- Advanced features (teams): Zones, federation(?), scaling.
- Presentations: Dec 12 (demo your feature/zone).

## Next Steps
- Playtest Friday.
- Deploy finals, reflect on agile/LLM.
- Post-class: Shard federation, prod scaling?

Thanks for a great semester—built a real game as a team!
