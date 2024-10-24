---
tags:
  - inbox
  - linux/networks
  - archlinux/networks
sr-due: 2024-10-10
sr-interval: 37
sr-ease: 270
created: 2024-08-05T14:03:52+03:00
modified: 2024-10-19T11:15:18+03:00
cssclasses:
  - clean-embeds
publish: true
---
### Основные команды
#### Смотрим список доступных сетей и активных подключений

```sh
nmcli connection show
```

#### Подключаемся к сети wifi

```sh
nmcli d wifi connect <имя_точки доступа>
```

#### Отключаемся от сети

```sh
sudo nmcli connection down <имя_соединения>
```

#### Редактируем соединение

```sh
sudo nmcli connection edit <имя_соединения>
```

#### Удаляем соединение

```sh
sudo nmcli connection delete <имя_соединения>
```

### Ставим в режим автоподключение при старте

#### Wireguard

```sh
sudo nmcli connection modify <имя_соединения> autoconnect yes
```

#### OpenVPN

Находим название соединения для которого требуется установить автоподключение к впн и идентификатор впн:
![[Шпаргалка по nmcli#Смотрим список доступных сетей и активных подключений]] 

Модифицируем:

```sh
sudo nmcli connection modify <имя_соединения> secondaries <guid_vpn>
```

[Network-Manager и автоподнятие openvpn соединения клиента? — Хабр Q&A](https://qna.habr.com/q/658564)