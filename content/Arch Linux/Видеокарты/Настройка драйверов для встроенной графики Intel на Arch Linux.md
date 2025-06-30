---
tags:
  - inbox
  - archlinux/videocards
sr-due: 2025-09-16
sr-interval: 306
sr-ease: 310
created: 2024-08-23T20:53:56+03:00
modified: 2024-11-14T21:48:24+03:00
publish: true
categories:
  - intel
  - mesa
  - vulkan
  - videodrivers
  - videocards
  - archlinux
---
### Устанавливаем

```sh
sudo pacman -Syu lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader libva-media-driver xf86-video-intel
```

Если графика гибридная **intel+nvidia** поставте [[Настройка драйверов для дискретной графики nvidia на Arch Linux|драйвера Nvidia]].