---
tags:
  - inbox
  - archlinux/networks/ssh/bugs
  - orangepi5/archlinux
created: 2024-09-27T22:54:58+03:00
modified: 2025-04-26T14:07:58+03:00
sr-due: 2025-05-01
sr-interval: 168
sr-ease: 270
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

---

В моем случае одновременно работал [[NetworkManager]] и [[systemd-networkd]].

> [!tldr] 
> На [[Orange Pi 5]] если нет проблем с загрузкой последнего ядра, то отключение [[systemd-networkd]] решает проблему. Если с загрзкой ядра все же наблюдаются проблемы, то отключение [[NetworkManager]] будет более правильным решением до момента, пока вы не разберетесь с ядром. 

```sh
systemctl stop systemd-networkd
```

```sh
systemctl disable systemd-networkd
```

### Связанные материалы

[[Установка статического MAC адреса вместо динамического]]
