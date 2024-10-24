---
tags:
  - inbox
  - archlinux/videocards
sr-due: 2024-09-19
sr-interval: 20
sr-ease: 292
created: 2024-08-25T03:49:39+03:00
modified: 2024-10-19T11:47:11+03:00
publish: true
---
### Устанавливаем

```sh
sudo pacman -Syu nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader lib32-opencl-nvidia opencl-nvidia libxnvctrl
```

Если графика гибридная поставьте также [[Настройка драйверов для встроенной графики Intel на Arch Linux|драйвера Intel]].