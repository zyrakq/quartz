---
tags:
  - inbox
  - linux
  - archlinux
  - manjaro
  - ubuntu
created: 2024-05-15T20:52:41+03:00
modified: 2025-04-26T21:58:49+03:00
publish: true
sr-due: 2025-04-29
sr-interval: 3
sr-ease: 250
categories:
  - hibernate
  - sleep
  - suspend
  - shutdown
---

[Как отключить спящий режим в Ubuntu - Академия Selectel](https://selectel.ru/blog/tutorials/how-to-disable-hibernation-in-ubuntu/)

Отключение:
```sh
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target 
```
Включение:
```sh
sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target 

```

