---
title: "cs4140 Notes: 10 Simple Deployment"
date: "2023-09-18"
---

Let's deploy our Joke apps to a VPS.

Basic Overview:

 - Get the app running on the server
   - In production mode, with any build step completed
   - As a system service, so it starts when the server boots
 - Make sure you have an appropriate DNS record pointed at the server.
 - Configure your reverse proxy to point to your app

## Deploying jokes-next

ref: [NextJS Deployment Docs](
https://nextjs.org/docs/app/building-your-application/deploying#nodejs-server)

First, let's confirm that we're set up with an "npm run start" command:

 - Look in package.json
 - The line should say: "start": "next start"
 - Also having a build line is good.

Now let's create a user on the remote server:

```bash
laptop$ pwgen -s 16 1
[...]
laptop$ ssh goblin.homework.quest
server$ sudo su -
server# adduser jokes-next
password: [...]
server# visudo
jokes-next goblin=(root) NOPASSWD: /sbin/service
^D^D
laptop$ ssh-copy-id jokes-next@goblin.homework.quest
```

Carefully consider the security implications of allowing the service
command to be run with sudo. Maybe add a restart-nginx script instead.

Second, let's write a deploy script.

```bash
# deploy.sh

export HOST=goblin.homework.quest
export USER=jokes-next

export DIR=$(basename $(pwd))

npm run build
rsync -avz --delete ../"$DIR" $USER@$HOST:~

ssh $USER@$HOST sudo service nginx restart
```

...


## Deploying jokes-rails
