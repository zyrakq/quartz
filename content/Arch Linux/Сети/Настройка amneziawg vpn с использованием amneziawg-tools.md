---
tags:
  - archlinux/networks
  - inbox
categories:
  - vpn
  - amnezia
  - wg
  - awg
  - wireguard
  - amneziawg
  - amneziawg-tools
  - awg-quick
  - wg-quick
  - tun
  - tunel
created: 2024-12-29T00:27:57+03:00
modified: 2025-04-26T21:46:05+03:00
sr-due: 2025-01-01
sr-interval: 3
sr-ease: 250
publish: true
---

### Настройка

Установим:

```sh
yay -S amneziawg-tools amneziawg-go systemd-resolvconf
```

На данный момент нет апплета интерфейса для NetworkManager в котором отображался бы туннель. Он также не отображается в `nm-connection-editor`. Но отображается в `nmcli`.
#### С использованием awg-quick

Добавим файл с конфигурации в директорию `/etc/amnezia/amneziawg`:

```sh
sudo cp ./awg0.conf /etc/amnezia/amneziawg/awg0.conf
```

Запустим:

```sh
sudo awg-quick up awg0
```

Отключение:

```sh
sudo awg-quick down awg0
```

### Проверка

Показать активные туннели amnezia:

```sh
sudo awg show
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