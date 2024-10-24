---
tags:
  - inbox
  - archlinux/videocards
sr-due: 2024-09-18
sr-interval: 19
sr-ease: 290
created: 2024-08-23T20:53:56+03:00
modified: 2024-10-19T11:47:00+03:00
publish: true
---
### Устанавливаем

```sh
sudo pacman -Syu lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader libva-media-driver xf86-video-intel
```

Если графика гибридная **intel+nvidia** поставте [[Настройка драйверов для дискретной графики nvidia на Arch Linux|драйвера Nvidia]].