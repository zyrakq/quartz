---
created: 2024-05-31T18:20:55+03:00
modified: 2024-10-19T12:53:21+03:00
tags:
  - inbox
  - archlinux
publish: true
---
### Установка

```sh
sudo pacman -S base-devel
```

```sh
git clone https://aur.archlinux.org/yay.git
```

```sh
cd ~/yay
```

```sh
makepkg -si
```
###### Испавление ошибки

```log
yay: error while loading shared libraries: libalpm.so.13: cannot open shared object file: No such file or directory
```

[yay: error while loading shared libraries: libalpm.so.12 - Josh Sherman](https://joshtronic.com/2021/06/06/yay-error-while-loading-shared-libraries-libalpm/)

### Основные команды

#### Поиск

```sh
yay -Ss package_name
```

#### Установка

```sh
yay -S package_name
```

#### Установка и игронированием хеша файла

```sh
yay -S --mflags "--skipchecksums --skippgpcheck" package_name
```

#### Удаление

```sh
yay -R package_name
```

#### Удаление нежелательных зависимостей

```sh
yay -Yc
```
