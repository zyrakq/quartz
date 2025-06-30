---
created: 2024-05-15T20:52:41+03:00
modified: 2025-02-12T12:27:08+03:00
tags:
  - inbox
  - linux/disks
categories:
  - udisksctl
  - mount
sr-due: 2025-02-15
sr-interval: 3
sr-ease: 250
publish: true
---
### Монтирование

```sh
# Автоматическое монтирование
udisksctl loop-setup -f образ_диска.iso
# Система сама выберет свободное устройство /dev/loopX
```

```sh
# Ручное монтирование
sudo mount -o loop,rw образ_диска.iso /mnt
# Вы явно указываете точку монтирования
```

### Размонтирование

```sh
sudo umount -R /mnt
```