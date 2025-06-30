---
tags:
  - archlinux/networks
  - inbox
categories:
  - vpn
  - wg
  - wireguard
  - wireguard-tools
  - wg-quick
  - tun
  - tunel
created: 2024-12-29T00:27:57+03:00
modified: 2025-04-26T14:39:25+03:00
sr-due: 2025-01-01
sr-interval: 3
sr-ease: 250
publish: true
---

### Настройка

Установим:

```sh
sudo pacman -S wireguard-tools
```

#### С использованием wg-quick

Добавим файл с конфигурации в директорию `/etc/wireguard`:

```sh
sudo cp ./wg0.conf /etc/wireguard/wg0.conf
```

Запустим:

```sh
sudo wg-quick up awg0
```

Отключение:

```sh
sudo wg-quick down awg0
```

### Проверка

Показать активные туннели:

```sh
sudo wg show
```

Список существующих интерфейсов:

```sh
ip link
```

```sh
ip a
```

Список активных подключений:

```sh
nmcli connection show --active
```

Запрос данных информации о соединении с сайта проверки:

```sh
curl ipinfo.io
```