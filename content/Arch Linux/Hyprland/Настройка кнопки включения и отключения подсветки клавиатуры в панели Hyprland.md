---
tags:
  - inbox
  - archlinux/hyprland
created: 2025-02-28T17:04:32+03:00
modified: 2025-02-28T17:17:50+03:00
categories:
  - brightnessctl
  - asus
  - backlight
  - backlight-slider
  - hyprland
  - waybar
sr-due: 2025-03-03
sr-interval: 3
sr-ease: 250
publish: true
---
[waybar-backlight(5) — Arch manual pages](https://man.archlinux.org/man/waybar-backlight.5.en)
[waybar-backlight-slider(5) — Arch manual pages](https://man.archlinux.org/man/waybar-backlight-slider.5.en)

### Консольная утилита

[Keyboard backlight - ArchWiki](https://wiki.archlinux.org/title/Keyboard_backlight)

```sh
brightnessctl --device='asus::kbd_backlight' info 
```

Включение:

```sh
brightnessctl --device='asus::kbd_backlight' set 1
```

Отключение:

```sh
brightnessctl --device='asus::kbd_backlight' set 0
```


### Настройка

Добавим этот элемент на панель в файле `~/.config/waybar/config.jsonc`:

```sh
nano ~/.config/waybar/config.jsonc
```


```json title:~/.config/waybar/config.jsonc ln:true
"modules-right": [
    "backlight-slider",
],
"backlight/slider": {
    "min": 0,
    "max": 100,
    "orientation": "horizontal",
    "device": "intel_backlight"
}
```

