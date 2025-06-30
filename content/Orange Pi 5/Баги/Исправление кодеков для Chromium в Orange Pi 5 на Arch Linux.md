---
tags:
  - inbox
  - orangepi5/archlinux
  - orangepi5/bugs
sr-due: 2026-02-03
sr-interval: 356
sr-ease: 270
created: 2024-08-19T22:19:47+03:00
modified: 2025-02-12T12:35:04+03:00
categories:
  - chromium
  - archlinux
  - orangepi5
  - codecs
publish: true
---
Прежде чем что то ставить, обновим репозитории:

```sh
sudo pacman -Syu
```

```sh
sudo pacman -Syu ffmpeg-mpp-git
```

```sh
sudo pacman -Syu chromium-mpp
```

Зависимость `libv4l-rkmpp-git` требует для корректной работы запущенной службы:

```sh
sudo systemctl enable --now libv4l-rkmpp-setup.service
```

Ознакомьтесь с [настройками](https://github.com/7Ji-PKGBUILDs/chromium-mpp) подробнее.

Также браузер с этими кодеками можно запустить еще и на [[Смена драйвера на проприентарный в Orange Pi 5 на Arch Linux|проприентарных драйверах]].