---
created: 2024-05-15T20:52:41+03:00
modified: 2025-03-30T05:54:25+03:00
tags:
  - inbox
  - archlinux/hyprland
categories:
  - archlinux
  - hyprland
  - waybar
publish: true
sr-due: 2025-03-03
sr-interval: 3
sr-ease: 250
---

[Репозиторий HyDE](https://github.com/Hyde-project/hyde)

> [!info] 
>  [Репозиторий Hyprdots](https://github.com/prasanthrangan/hyprdots/tree/main)  - устаревший репозиторий.
### Установка

Установка полностью соответствует инструкции в репозитории.

### Связанные материалы

[[Исправление проблем с терминалом kitty при работе по ssh]]

[[Настройка панели курса криптовалют в Hyprland]]

[[Настройка кнопки включения и отключения подсветки клавиатуры в панели Hyprland]]

[[Установка Hyprland на Arch Linux для Orange Pi 5]]

---
#### Исправление бага при входе в аккаунт

Добавим в конец `~/.profile`:

```ruby
[[ $(tty) = /dev/tty1 ]] && exec Hyprland
```

[Starting from zsh causes hyprctl issue, but starting from bash works fine · Issue #3681 · hyprwm/Hyprland · GitHub](https://github.com/hyprwm/Hyprland/issues/3681)

Предполагается, что у вас настроена подгрузка файла `~/.profile` при входе в систему.

---
#### Исправление захвата экрана

```sh
sudo pacman -S xwaylandvideobridge xdg-desktop-portal
```

Работает только с *WebCord*.

---
#### Исправление отображение окна буфера обмена

команда `Win + V` вызвает меню быстрого копирования:

```ini
windowrulev2 = float,class:^(.*)(rofi)(.*)$
windowrulev2 = size 622 652,class:^(.*)(rofi)(.*)$
```

---
#### Исправление цвета подсказок в терминале

Добавим в файла `.zprofile` строку:

```sh
nano ~/.zprofile
```

```ruby
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white,bold'
```

---
#### Набор полезных правил отображения окон

```ini title:~/.config/hypr/windowrules.conf ln:true fold
windowrulev2 = opacity 0.80 0.80,class:^(.*)(KeePassXC)$
# chromium
windowrulev2 = center(1),title:^(Select)(.*)$
windowrulev2 = center(1),title:^(Open)(.*)$
windowrulev2 = center(1),title:^(Save)(.*)$
windowrulev2 = center(1),title:^(All Files)$
# GIMP
windowrulev2 = center(1),title:^(Export)(.*)$

windowrulev2 = center(1),title:^(.*)(Writer)$
windowrulev2 = center(1),title:^(TON Wallet)$
windowrulev2 = center(0.8),title:^(.*)(Kando)$
windowrulev2 = center(0.5),opacity 0.80 0.80,class:^(.*)(Nautilus)$

windowrulev2 = float,class:^(.*)(rofi)(.*)$
windowrulev2 = size 622 652,class:^(.*)(rofi)(.*)$

# BalenaEtcher
windowrulev2 = center(1),class:^(.*)(etcher)(.*)$
```
### Ссылки

[Installation – Hyprland Wiki](https://wiki.hyprland.org/Getting-Started/Installation/)