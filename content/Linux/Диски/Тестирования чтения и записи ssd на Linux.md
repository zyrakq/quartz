---
tags:
  - inbox
  - linux/disks
  - archlinux/disks
categories:
  - ssd
  - dd
  - disks
  - speed-testing
created: 2024-05-15T20:52:41+03:00
modified: 2024-12-30T07:12:57+03:00
sr-due: 2025-01-02
sr-interval: 3
sr-ease: 250
publish: true
---
Проверка скорости чтения:

```sh
dd if=tempfile of=/dev/null bs=1M count=1024
```

Проверка скорости записи:

```sh
sync; dd if=/dev/zero of=tempfile bs=1M count=1024; sync
```