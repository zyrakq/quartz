---
tags:
  - inbox
  - archlinux/videocards
sr-due: 2025-09-18
sr-interval: 308
sr-ease: 312
created: 2024-08-25T03:49:39+03:00
modified: 2024-12-07T18:37:56+03:00
publish: true
categories:
  - nvidia
  - vulkan
  - videodrivers
  - videocards
  - archlinux
---
### Устанавливаем

```sh
sudo pacman -Syu nvidia-dkms nvidia-utils nvidia-settings vulkan-icd-loader opencl-nvidia libxnvctrl libvdpau libnvidia-container nvidia-container-toolkit
```

Если графика гибридная поставьте также [[Настройка драйверов для встроенной графики Intel на Arch Linux|драйвера Intel]].