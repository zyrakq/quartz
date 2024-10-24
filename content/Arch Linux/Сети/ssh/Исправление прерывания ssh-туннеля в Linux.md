---
tags:
  - inbox
  - archlinux/networks/ssh/bugs
created: 2024-09-27T22:54:58+03:00
modified: 2024-10-19T11:49:51+03:00
sr-due: 2024-09-30
sr-interval: 3
sr-ease: 250
categories:
  - ssh
  - NetworkManager
  - system-networkd
  - bug
  - orangepi5
publish: true
---
Одна из причина по которым такая проблема может возникнуть это наличие сразу нескольких сетевых менеджеров.

[[SOLVED] Wired connection dropping randomly for a few seconds / Networking, Server, and Protection / Arch Linux Forums](https://bbs.archlinux.org/viewtopic.php?id=260219)

Чтобы проверить что запущено выполните:

```sh
find /etc/systemd -type l -exec test -f {} \; -print | awk -F'/' '{ printf ("%-40s | %s\n", $(NF-0), $(NF-1)) }' | sort -f
```

Вот список всех сетевых менеджеров используемых в linux:

[Network configuration - ArchWiki](https://wiki.archlinux.org/title/Network_configuration)

В моем случае одновременно работал [[NetworkManager]] и [[systemd-networkd]].

Отключение [[NetworkManager]] помогло. А вот [[systemd-networkd]] нет. То есть в моем случае проблема в [[NetworkManager]]. Но такая проблема возникает только на [[Orange Pi 5]].

```sh
systemctl stop NetworkManager
systemctl disable NetworkManager
```
