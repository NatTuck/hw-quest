---
title: "Virtual Private Server Setup"
date: "2024-09-25"
---


## Creating a VPS

First, select a commodity VPS provider.

Here are some high quality, reliable, and trustworthy options:

 - https://vultr.com/
 - https://linode.com/
 - https://digitalocean.com/

Here are some cheaper options that are less reliable and/or harder to use:

 - https://www.ovhcloud.com/en/
 - https://my.racknerd.com/index.php?rp=/store/black-friday-2023

Minimum specs:

 - 1 GB of RAM
 - A public IPv4 address
 - 20 GB of SSD disk
 - Debian 12 or Ubuntu 24.04
 - Vultr charges $6/month for an appropriate VPS


## Initial Setup

Once you've created a VPS, there's some initial setup to do.

Get logged in to the machine with as root (via ssh or web console) and:

## Add a non-root login user

 - Pick a name that isn't "admin" or "debian" or something else that will
   be in existing wide-scale SSH attack scripts.
 - This should be separate from your application account.
 - I'll use "alice" for my examples.

```
root@vps:~# apt install pwgen
root@vps:~# pwgen -s 16 1
(save-this-random-password)
root@vps:~# adduser alice
...
password: (save-this-random-password)
```

Let the new user sudo, and verify that it works:

```
root@vps:~# adduser alice sudo
root@vps:~# su - alice
alice@vps:~$ sudo su -
password: (save-this-random-password)
root@vps:~#
```

Create a local ssh key if you don't have one and copy it to
the new account:

```
you@yourpc:~$ ssh-keygen -t ed25519
passphrase: (blank)
...
you@yourpc:~$ ssh-copy-id alice@vps
password: (save-this-random-password)
```

Verify that you can log in and get to root with the new account:

```
you@yourpc:~$ ssh alice@vps
alice@vps:~$ sudo su -
password: (save-this-random-password)
root@vps:~# 
```

Disable root logins via SSH:


```
root@vps:~# nano /etc/ssh/sshd_config
```

In the config file, find or add:

```
PermitRootLogin no
```

Restart ssh

```
root@vps:~# systemctl restart sshd
```

Keep your existing ssh session to root open in case you
need it to recover, and verify that you can't log in
directly as root but can still log in as your new user.


## Set up a software firewall

Make sure you allow port 22 (ssh) before enabling the firewall.

```
root@vps:~# apt install ufw
root@vps:~# ufw allow 22
root@vps:~# ufw allow 80
root@vps:~# ufw allow 443
root@vps:~# ufw enable
root@vps:~# ufw status
...
```


## Set up Nginx

```
root@vps:~# apt install nginx certbot python3-certbot-nginx
```

Site configuration files for nginx go in /etc/nginx/sites-available

To enable a site, symlink it's config from /etc/nginx/sites-available to
/etc/nginx/sites-enabled and restart nginx.

Once you have your sites working with HTTP, you can use LetsEncrypt to
move them to HTTPS by running "certbot" which will get you certificates
and automatically update your nginx configs.

Sample nginx config for a Phoenix app in dev mode: 
https://github.com/NatTuck/party_animal/blob/main/party.nginx


## Set up a swap file

If you have less than about 3GB of RAM on your VPS, you'll run into
trouble trying to build JavaScript assets on the sever when we get there.

Adding a swap file gives some extra virtual memory.


## Install some pre-reqs

This will let you build Erlang as part of the app user install process.

I think this list is for Debian 12:

```
sudo apt-get -y install build-essential autoconf m4 libncurses5-dev \
  libwxgtk3.0-gtk3-dev libwxgtk-webview3.0-gtk3-dev libgl1-mesa-dev \
  libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop \
  libxml2-utils libncurses-dev openjdk-11-jdk git wget curl
```

If that doesn't work, try:

```
sudo apt-get -y install build-essential autoconf m4 libncurses5-dev \
  libpng-dev libssh-dev unixodbc-dev xsltproc fop \
  libxml2-utils libncurses-dev default-jdk git wget curl
```


## Set up a user for a Phoenix app

First, add a user (e.g. "party") and copy in an SSH key for that user
just like with the login account above.

Then run the install-asdf.sh script to install recent Erlang, Elixir,
and NodeJS on this account:
https://github.com/NatTuck/party_animal/blob/main/install_asdf.sh

```
party@vps:~$ wget https://raw.githubusercontent.com/NatTuck/party_animal/refs/heads/main/install_asdf.sh
party@vps:~$ bash install_asdf.sh
```


## Set up your Phoenix app for deploy.

Create a SSH key for the app user:

```
party@vps:~$ ssh-keygen -t ed25519
passphrase: (blank)
...
party@vps:~$ cat ~/.ssh/id_ed25519.pub
(here's your SSH public key)
```

Configure that key as a deploy key in your Github repo.

Then you can clone your git repo to the server.

```
party@vps:~$ git clone git@github.com:NatTuck/party_animal.git
```

Finally, figure out how to repicate / install the following files
and scripts for your app:

 - https://github.com/NatTuck/party_animal/blob/main/party.service
 - https://github.com/NatTuck/party_animal/blob/main/start.sh
 - https://github.com/NatTuck/party_animal/blob/main/update.sh
 - https://github.com/NatTuck/party_animal/blob/main/ship.sh


## Start your app and check that it works

```
party@vps:~$ systemctl --user start party
party@vps:~$ systemctl --user --no-pager status party
party@vps:~$ journalctl --user --no-pager -n 20 -u party
```

This should show enabled, working, and listening on localhost:4000

You should now be able to visit your app at http://(your-domain)


## Confirm your deploy script

 - Make a simple change to your app on your local machine.
 - Get the change to main on your Github repo.
 - Run your "ship.sh" script from your local machine.
 - This should result in the update being visible on the instance of
   your app running on the server.
