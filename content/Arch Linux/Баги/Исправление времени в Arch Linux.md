---
tags:
  - inbox
  - archlinux/bugs
categories:
  - bug
  - timedatectl
  - certificate
created: 2024-06-18T17:20:27+03:00
modified: 2025-03-05T14:46:45+03:00
sr-due: 2025-01-02
sr-interval: 3
sr-ease: 250
publish: true
---
Время может сбиться и это чревато тем, что многие сайты в интернете перестанут быть доступны. Это легко исправить, достаточно разрешить синхроназиции времени через интернет.

Включения синхронизации через интернет:

```sh
sudo timedatectl set-ntp true 
```