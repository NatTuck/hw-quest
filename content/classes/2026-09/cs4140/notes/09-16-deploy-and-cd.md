---
title: "cs4140 Notes: 09-16 Continuous Deployment"
date: "2026-09-14"
---

## Continuous Deployment

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
