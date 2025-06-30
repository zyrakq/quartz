---
created: 2024-05-31T18:20:55+03:00
modified: 2025-03-28T18:16:46+03:00
tags:
  - inbox
  - archlinux
publish: true
categories:
  - yay
  - archlinux
  - pacman
  - manjaro
sr-due: 2025-04-10
sr-interval: 88
sr-ease: 259
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

Для редактирования `PKGBUILD` файла перед установкой:

```sh
yay -S --editmenu package_name
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

Также команды идентичны [[Шпаргалка по Pacman|pacman]].

При установке пакетов могут возникнуть проблемы git по http. В этом случае можно попробовать [[Принудительная подмены протокола запросов в git с http на ssh|настроить подмену http запросов на ssh ]].

### Проксирование трафика

В файл оболочки (в моем случае `~/.profile`) можно добавить функцию, которая будет подменять команду. Например:

```sh title:~/.profile ln:true
yay() {
    http_proxy=socks5://127.0.0.1:65434 https_proxy=socks5://127.0.0.1:65434 /usr/bin/yay "$@"
}
```

И перезайдите в аккаунт или перезагрузитесь (в зависимости от того куда вы добавили функцию).

Теперь функция подменяет *alias* команды. В этом можно убедиться выполнив:

```sh
which yay
```

```log
yay () {
	http_proxy=socks5://127.0.0.1:65434 https_proxy=socks5://127.0.0.1:65434 /usr/bin/yay "$@"
}
```

### Связанные материалы

[[Настройка проксирования трафика приложений в Linux]]