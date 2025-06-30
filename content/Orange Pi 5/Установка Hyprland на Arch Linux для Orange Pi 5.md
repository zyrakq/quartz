---
tags:
  - inbox
  - orangepi5/archlinux/hyprland
sr-due: 2025-11-25
sr-interval: 270
sr-ease: 270
created: 2024-08-03T11:09:39+03:00
modified: 2025-03-02T12:27:41+03:00
categories:
  - hyprland
  - orangepi5
  - mesa
  - archlinux
  - rk3588
  - boot
  - joshua
  - 7ji
publish: true
---
[[Установка Arch Linux на Orange Pi 5]]

### Установка

*Hyprland* не работает с ядром `linux-aarch64-rockchip-rk3588-bsp5.10-orangepi-git` поставляемое из образа. Для корректной работы *Hyprland* потребуется поставить ядро `linux-aarch64-rockchip-bsp6.1-joshua-git`.

```sh
sudo pacman -S linux-aarch64-rockchip-bsp6.1-joshua-git
```

> [!hint] 
>  Возможно другие ядра также подходят для *Hyprland*, но мне об этом неизвестно, так как на данный момент я пробовал только от *7Ji* и от *Joshua*.

И [[Смена ядра Linux при старте системы в Orange Pi 5 на Arch Linux|поменяем ядро по умолчанию при старте ОС]].

---

Устанавливаем *Hyprland*:

```sh
sudo pacman -Syu hyprland
```

> [!hint] 
> Полагаю установка [[Установка HyDE (Hyprland) на Arch Linux|HyDE]] или любой другой [[Сборки Hyprland|сборки]] также не станет проблемой.

---

Если вы ставили чистный *Hyprland*, то для проверки выполните:

```sh
Hyprland # or `exec Hyprland`
```

> [!tip] 
> Чтобы завершить сеанс *Hyprland* нажмите сочетание клавиш: `Ctrl + M`. В конфигурации *HyDE* `SUPER + Del`.

---

Просмотр устройств:

```sh
ls -l /dev/dri/
```

```sh
journalctl -xe | grep -i drm
```
