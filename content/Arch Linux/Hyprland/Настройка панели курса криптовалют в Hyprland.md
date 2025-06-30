---
tags:
  - archlinux/hyprland
  - inbox
created: 2025-02-28T16:51:37+03:00
modified: 2025-02-28T17:18:15+03:00
categories:
  - waybar
  - hyprland
  - archlinux
  - waybar-crypto
  - yay
publish: true
sr-due: 2025-03-03
sr-interval: 3
sr-ease: 250
---
[Репозиторий](https://github.com/Chadsr/waybar-crypto)

### Установка

```sh
yay -S waybar-crypto
```

Добавим этот элемент на панель в файле `~/.config/waybar/config.jsonc`:

```sh
nano ~/.config/waybar/config.jsonc
```

```json title:~/.config/waybar/config.jsonc ln:true
"modules-right": [
    "custom/crypto",
],
"custom/crypto": {
    "format": "{}",
    "interval": 600,
    "return-type": "json",
    "exec": "waybar-crypto", // change this if you installed manually
    "exec-if": "ping pro-api.coinmarketcap.com -c1"
}
```

Настроить список валют и отображаемые данные можно в `~/.config/waybar/config`:

```sh
nano ~/.config/waybar/config
```