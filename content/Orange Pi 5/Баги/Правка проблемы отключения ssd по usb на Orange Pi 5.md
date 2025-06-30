---
tags:
  - inbox
  - orangepi5
created: 2024-05-15T20:52:41+03:00
modified: 2025-02-12T12:31:36+03:00
categories:
  - ssd
  - usb
  - orangepi5
  - bug
publish: true
sr-due: 2025-02-15
sr-interval: 3
sr-ease: 250
---
Проблема возникала на определенном переходнике. Другой переходник решил проблему.

Но эта проблема также скорее всего может быть решена технически через правильный набор параметров монтирования.

[USB флешка вылетает](https://archlinux.org.ru/forum/topic/11280/?page=2)

```
не только.  
опция discard для правильной работы с ssd,  
+ noatime
```

[Какой-то странный глюк с ssd nvme через type-c — Linux-hardware — Форум](https://www.linux.org.ru/forum/linux-hardware/17416385)

