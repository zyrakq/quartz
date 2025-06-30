---
created: 2024-05-31T18:24:26+03:00
modified: 2025-03-28T16:42:36+03:00
tags:
  - archlinux
  - inbox
sr-due: 2024-10-23
sr-interval: 4
sr-ease: 270
publish: true
---
### Основные команды

#### Поиск

```sh
pacman -Ss package_name
```

#### Установка

```sh
pacman -S package_name
```

#### Удаление

```sh
pacman -R package_name
```

#### Удаление нежелательных зависимостей

```sh
pacman -Yc
```

#### Добавление зеркал

```sh
nano /etc/pacman.d/mirrorlist
```

[[Переустановка Pacman]]

#### Обновление PGP ключей репозиториев

```sh
pacman-key --refresh-keys
```

### Исправление проблем

#### Переустановка

[Cant install software · Issue #19 · manjaro-pinephone/phosh · GitHub](https://github.com/manjaro-pinephone/phosh/issues/19)

```sh
rm -r /etc/pacman.d/gnupg  
pacman-key --init  
pacman-key --populate  
pacman-key --refresh-keys  
pacman -Sc  
pacman-mirrors --geoip  
pacman -Syyu
```