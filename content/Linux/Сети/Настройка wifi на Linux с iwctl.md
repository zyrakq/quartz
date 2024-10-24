---
tags:
  - inbox
  - linux/networks
  - archlinux/networks
sr-due: 2025-05-23
sr-interval: 215
sr-ease: 290
cssclasses:
  - clean-embeds
created: 2024-08-20T18:54:12+03:00
modified: 2024-10-20T11:26:25+03:00
publish: true
---
### Настройка
#### Ищем имя нашего устройство

```sh
ip a
```

Чаще всего это `wlan0`.

#### Разблокируем wifi

```sh
rfkill unblock wifi
```

Так wi-fi может быть заблокирован.
#### Включаем устройство

```sh
ip link set <имя_устройства> up
```

#### Подключаемся

```sh
iwctl
```

```sh
station <имя_устройства> connect <имя_точки_доступа>
```

```sh
exit
```

```sh
ping google.com
```

