---
tags:
  - inbox
  - orangepi5/archlinux
created: 2024-11-14T22:05:41+03:00
modified: 2025-01-02T03:53:23+03:00
categories:
  - videocards
  - videodrivers
  - archlinux
  - orangepi5
sr-due: 2024-11-17
sr-interval: 3
sr-ease: 250
publish: true
---
### GPU/3D-ускорение (BLOB-объект поставщика))

```sh
sudo pacman -Syu mesa-panfork-git mali-valhall-g610-firmware
```

Для DE ставим:

```sh
sudo pacman -Syu libmali-valhall-g610-{dummy,gbm,wayland-gbm,x11-gbm,x11-wayland-gbm}
```

Но он не устанавливается как глобальный из за того, что он не предоставляет **OpenGL** поэтому приложение стоит запускать так:

```sh
LD_LIBRARY_PATH=/usr/lib/mali-valhall-g610/x11-gbm [program]
```

Если вы хотите запустить программу **OpenGL**, то ставим:

```sh
sudo pacman -Syu gl4es-git
```

И запускаем:

```sh
LD_LIBRARY_PATH=/usr/lib/gl4es:/usr/lib/mali-valhall-g610/x11-gbm [program]
```

Но это решение все же не предназначено для запуска **OpenGL** и оно менее производительнее, чем даже *mesa*.

Если вы установили [[Исправление кодеков для Chromium в Orange Pi 5 на Arch Linux|кодеки для Chromium]], то можно запустить chromium на `mali-valhall-g610`:

```sh
LD_LIBRARY_PATH=/usr/lib/mali-valhall-g610/x11-wayland-gbm chromium --use-gl=angle --use-angle=gles-egl --use-cmd-decoder=passthrough
```

Проверить, что в браузере используются нужные кодеки можно:

```http
chrome://gpu/
```

При запуске можно также [[Смена ядра Linux при старте системы в Orange Pi 5 на Arch Linux|сменить ядро]] на то, что с `mali-valhall-g610`, но не стоит это делать. Многое может перестать работать.