---
title: "cs4140 Notes: 09-14 CI and CD"
date: "2026-09-12"
---

## Where this fits

Back in the [workflow notes](./09-04-workflow) we said a reviewer should confirm
that the tests pass before merging a PR. That's a fine rule, but relying on a
human to run the tests on their laptop has problems:

- The reviewer might forget, or run the wrong command.
- "It works on my machine" - the tests might pass on the author's laptop and
  fail on the reviewer's because of a version difference.
- It's slow and boring for the reviewer.

**Continuous Integration (CI)** means: every time someone pushes a change, a
clean machine builds the project and runs the whole check suite automatically.
The result gets attached to the PR, so the reviewer can see "tests passed"
instead of having to reproduce it.

**Continuous Deployment (CD)** is the next step: when a change lands on `main`,
automatically build it and push it to the production server.

Our example is BotBash: <https://github.com/NatTuck/botbash>

## What CI checks in BotBash

BotBash already has all the pieces; CI just runs them in the right order. The
`package.json` scripts are the source of truth:

```json
"lint": "biome lint && node scripts/max-lines.mjs",
"test": "vitest run",
"test:e2e": "playwright test",
"build": "tsc -p tsconfig.json && tsc -p tsconfig.server.json && vite build",
"check": "pnpm lint && pnpm test && pnpm build"
```

- **Lint** runs [Biome](https://biomejs.dev/) plus a small custom script,
  `scripts/max-lines.mjs`, that fails if any file under `src`, `server`, or
  `shared` has more than 300 lines of *code* (blank lines and comments don't
  count). Keeping files small keeps them reviewable.
- **Unit tests** are Vitest (`*.test.ts`).
- **Build** typechecks the client and server with `tsc` (both `noEmit`, so it
  only typechecks) and then runs `vite build` to produce `dist/`.
- **End-to-end tests** are Playwright. `playwright.config.ts` has a `webServer`
  block that starts `pnpm dev` on port 3000 automatically, so the tests just
  need a browser installed.

`pnpm check` is `lint && test && build`. We run the e2e tests as a separate
step because they're slower and need the browser.

## Demo: adding CI

Before wiring anything up, make sure the checks pass locally:

```sh
pnpm install --frozen-lockfile
pnpm check
pnpm test:e2e:install   # once, to download Chromium
pnpm test:e2e
```

If those don't pass locally, they won't pass in CI. Fixing the local failures
first is the whole game.

Now add `.github/workflows/ci.yml`. Here are the interesting parts.

**When it runs.** On every PR, and on every push to `main`. The `concurrency`
block cancels an in-progress run when a new commit is pushed to the same branch,
so we don't waste time on stale commits:

```yaml
on:
  pull_request:
  push:
    branches: [main]

concurrency:
  group: ci-${{ github.ref }}
  cancel-in-progress: true
```

**The job.** One job named `test` on a fresh Ubuntu runner, with a timeout so a
hung test can't burn the whole hour:

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    timeout-minutes: 20
```

**Tool setup.** Check out the code, install the exact pnpm version, and install
Node 24. `cache: pnpm` tells `setup-node` to cache the pnpm store between runs:

```yaml
      - uses: actions/checkout@v4

      - uses: pnpm/action-setup@v4
        with:
          version: 11

      - uses: actions/setup-node@v4
        with:
          node-version: 24
          cache: pnpm

      - name: Install dependencies
        run: pnpm install --frozen-lockfile
```

`--frozen-lockfile` is important: CI fails if `pnpm-lock.yaml` doesn't match
`package.json`, instead of silently resolving different versions than you have
locally.

**Playwright.** Downloading Chromium takes a while, so cache it, then install
the browser and its system dependencies:

```yaml
      - name: Cache Playwright browsers
        uses: actions/cache@v4
        with:
          path: ~/.cache/ms-playwright
          key: ${{ runner.os }}-playwright-${{ hashFiles('pnpm-lock.yaml') }}
          restore-keys: |
            ${{ runner.os }}-playwright-

      - name: Install Playwright (chromium)
        run: pnpm exec playwright install --with-deps chromium
```

**Run everything.** `pnpm check` does lint + unit + build, then the e2e suite.
The report is uploaded even on failure so you can download it from the run
summary:

```yaml
      - name: Lint, unit tests, build
        run: pnpm check

      - name: End-to-end tests
        run: pnpm test:e2e

      - name: Upload Playwright report
        if: ${{ !cancelled() }}
        uses: actions/upload-artifact@v4
        with:
          name: playwright-report
          path: playwright-report/
          retention-days: 7
```

Commit, push, and open a PR. GitHub will show the `test` check running, and the
PR gets a green check or a red X. Click through to the run to read the logs.

One thing to expect: the very first CI run on an existing project usually finds
real problems. When CI was added to BotBash (commit `950c286`) it immediately
caught pre-existing test and build failures that nobody had noticed. That's the
point.

## Making CI count: required checks

A green check that nobody enforces is just decoration. On GitHub we make it a
gate with a **branch ruleset** on `main`:

- **Require a pull request** before merging.
- **Required approvals: 1**, and the author's own approval doesn't count.
- **Required status check: `test`** (the job name from the workflow).
- **Squash merges only** - one clean commit per PR.
- **Dismiss stale approvals** when new commits are pushed.
- **Block force pushes** and **restrict deletions**.
- A **bypass list** for the repo owner, so there's an emergency escape hatch.

The required check is matched by *name*. If you rename the `test` job in
`ci.yml`, the required check silently disappears until you update the ruleset.
This coupling trips people up.

There's also a GitHub quirk with forks: a `pull_request` workflow from a public
fork starts in `action_required` and waits for a maintainer to approve the run.
That's a security gate, not a code review - it's GitHub deciding whether to
spend runner minutes on a stranger's code. You can loosen it under **Settings ->
Actions -> General** so that only brand-new contributors need approval.

## Troubleshooting

| Symptom | Likely cause / fix |
| --- | --- |
| `pnpm install --frozen-lockfile` fails | `pnpm-lock.yaml` is stale; run `pnpm install` locally and commit it. |
| `max-lines` failure | A file under `src`, `server`, or `shared` exceeds 300 code lines; split it. |
| Playwright fails on canvas timing | Re-run the job; if it's consistently flaky, add `retries` to `playwright.config.ts`. |
| Everything is slow | The browser cache is cold; the first run after a lockfile change is the slow one. |

The BotBash suite runs single-worker (`workers: 1`), so a bigger runner wouldn't
help much. The browser install is the slow part, and the cache handles that.

## Continuous Deployment (if we have time)

Once CI is green and `main` is protected, CD is: **on every merge to `main`,
build the app and push it to the production server, then restart it.**

For BotBash the target is `botbash@ettin.homework.quest`. nginx terminates TLS
for `botbash.homework.quest` and reverse-proxies to the app on `localhost:3100`.

```
merge to main
      |
      v
 GitHub Actions CD
 build -> rsync -> restart systemd --user
      |
      v
 nginx :443 --> botbash.service :3100
```

### How the app runs in production

`pnpm build` emits the client bundle to `dist/`. The Express server runs
directly from TypeScript with `vite-node`; when `NODE_ENV=production`,
`vite-express` serves the built files from `dist/` instead of starting a Vite
dev server.

That means the production host needs `vite-node` at runtime. It's currently a
dev dependency, and there's no `start` script, so two small repo changes are
needed first.

### Repo changes before the first deploy

1. Add a production start script to `package.json`:

   ```json
   "start": "NODE_ENV=production vite-node server/index.ts"
   ```

2. Move `vite-node` from `devDependencies` to `dependencies`, so a
   production-only install still has it. `vite-node` pulls in `vite`, but not
   Playwright, Biome, or TypeScript.

3. Commit the systemd unit at `deploy/botbash.service`.

### The deploy workflow

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy

on:
  push:
    branches: [main]
  workflow_dispatch:

concurrency:
  group: deploy-production
  cancel-in-progress: false

env:
  DEPLOY_HOST: ettin.homework.quest
  DEPLOY_USER: botbash
  DEPLOY_PATH: /home/botbash/botbash
  APP_PORT: "3100"

jobs:
  deploy:
    runs-on: ubuntu-latest
    timeout-minutes: 15
    steps:
      - uses: actions/checkout@v4

      - uses: pnpm/action-setup@v4
        with:
          version: 11

      - uses: actions/setup-node@v4
        with:
          node-version: 24
          cache: pnpm

      - name: Install dependencies
        run: pnpm install --frozen-lockfile

      - name: Build
        run: pnpm build

      - name: Load deploy key
        uses: webfactory/ssh-agent@v0.9.0
        with:
          ssh-private-key: ${{ secrets.SSH_KEY }}

      - name: Trust host key
        run: ssh-keyscan -H "$DEPLOY_HOST" >> ~/.ssh/known_hosts

      - name: Sync built client
        run: |
          rsync -az --delete dist/ "$DEPLOY_USER@$DEPLOY_HOST:$DEPLOY_PATH/dist/"

      - name: Sync server sources
        run: |
          rsync -az --delete server/ "$DEPLOY_USER@$DEPLOY_HOST:$DEPLOY_PATH/server/"
          rsync -az --delete shared/ "$DEPLOY_USER@$DEPLOY_HOST:$DEPLOY_PATH/shared/"
          rsync -az package.json pnpm-lock.yaml pnpm-workspace.yaml \
            tsconfig.json tsconfig.server.json \
            "$DEPLOY_USER@$DEPLOY_HOST:$DEPLOY_PATH/"

      - name: Install dependencies and restart
        run: |
          ssh "$DEPLOY_USER@$DEPLOY_HOST" \
            "set -euo pipefail && \
             cd $DEPLOY_PATH && \
             export PATH=\$HOME/.local/share/mise/shims:\$PATH && \
             pnpm install --frozen-lockfile --prod && \
             export XDG_RUNTIME_DIR=/run/user/\$(id -u) && \
             systemctl --user restart botbash && \
             sleep 2 && \
             curl -fsS http://localhost:$APP_PORT/api/state"
```

Things worth noticing:

- Only the private key is a secret. Host, user, and path live in the `env:`
  block, so they're easy to review and change. **For your project, this is the
  part you edit** - your own host, user, and path.
- `dist/` is synced with `--delete` so stale hashed asset files go away.
  `server/` and `shared/` are synced the same way. The root files are copied
  *without* `--delete` so `node_modules/` on the host is preserved.
- `systemctl --user` needs a session bus. Over a non-interactive SSH command,
  `XDG_RUNTIME_DIR` is usually unset, so we set it explicitly.
- `pnpm install --prod` on the host is what makes moving `vite-node` to
  `dependencies` necessary.
- The final `curl` fails the job if the service didn't come back up.

### One-time server setup

All of this is done once, on the server.

**1. Create the user and enable lingering:**

```sh
sudo adduser --disabled-password --gecos "" botbash
sudo loginctl enable-linger botbash
```

Lingering keeps the user's systemd manager (and the service) running when
`botbash` isn't logged in.

**2. Install mise, Node 24, and pnpm:**

```sh
su - botbash
curl https://mise.run | sh
mise use -g node@24
npm install -g pnpm
```

The service unit looks for tools under `~/.local/share/mise/shims`.

**3. Put the code on the host:**

```sh
git clone git@github.com:NatTuck/botbash.git /home/botbash/botbash
```

The host doesn't need repo credentials for deploys - `rsync` pushes the files
over SSH.

**4. Install and start the service:**

```sh
mkdir -p ~/.config/systemd/user
cp /home/botbash/botbash/deploy/botbash.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now botbash
systemctl --user status botbash
```

The unit runs `pnpm start` with `NODE_ENV=production` and `PORT=3100`.

**5. nginx and TLS:**

```sh
sudo ln -s /etc/nginx/sites-available/botbash.conf /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx
sudo certbot --nginx -d botbash.homework.quest
```

The nginx config already sets the `Upgrade`/`Connection` headers that Socket.IO
needs.

### The deploy key

CD needs to SSH into the server without a password. Make a dedicated key pair:

```sh
ssh-keygen -t ed25519 -C botbash-deploy -f botbash_deploy -N ""
```

Install the public half on the host:

```sh
cat botbash_deploy.pub | ssh botbash@ettin.homework.quest \
  'mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys'
```

Store the private half as the repository secret `SSH_KEY`:

```sh
gh secret set SSH_KEY < botbash_deploy
```

Then delete the local key files. The private key should only ever exist on your
machine long enough to upload it, and in GitHub's secret store.

### Verifying and rolling back

```sh
# On the host
systemctl --user status botbash
journalctl --user -u botbash -f

# From anywhere
curl -fsS https://botbash.homework.quest/api/state
```

A healthy response looks like `{"playerCount":0,"gameCount":0}`.

If a deploy goes bad:

- **Re-run a previous deploy:** Actions -> Deploy, pick the last good run,
  **Re-run jobs**. GitHub checks out that run's commit and redeploys it.
- **Revert the change:** `git revert <sha>` and push to `main`; CI and CD run
  again.
- **Stop the bleeding:** `systemctl --user stop botbash`; nginx returns `502`
  until it's restarted.

## Wrap-up

CI is the part that matters most: get your checks running automatically on every
PR, and make the `test` check required so a red PR can't merge. CD is a bonus -
it's mostly plumbing once CI is solid, and the exact host/user/path in the
`env:` block is the only thing that changes from project to project.
