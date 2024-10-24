---
tags:
  - inbox
  - linux
  - archlinux
sr-due: 2025-04-14
sr-interval: 185
sr-ease: 290
created: 2024-05-31T01:03:07+03:00
modified: 2024-10-19T11:32:32+03:00
publish: true
---

### Добавляем swap

Требуются права администратора.

```sh
touch /swapfile
```

```sh
 chattr +c /swapfile
```

```sh
fallocate -l 8G /swapfile
```

```sh
chown root /swapfile
```

```sh
chmod 600 /swapfile
```

```sh
mkswap /swapfile
```

```sh
swapon /swapfile
```

```sh
echo '/swapfile none swap defaults 0 0' >> /etc/fstab
```

### Проверяем наличие swap

```sh
swapon --show
```

```sh
free -h
```

Права администратора не требуются.
### Отключаем swap

```sh
swapoff -a &&` `sleep` `3 && swapon -a
```

Права администратора не требуются.