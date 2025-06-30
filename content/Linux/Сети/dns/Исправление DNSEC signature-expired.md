---
created: 2024-09-28T18:59:22+03:00
modified: 2024-11-14T22:28:49+03:00
tags:
  - linux/networks/dns/bugs
  - inbox
categories:
  - wireguard
  - dnssec
  - dns
  - bug
  - systemd-resolved
sr-due: 2025-04-27
sr-interval: 164
sr-ease: 270
publish: true
---
Сайты не открывались. [[VPN]] не подключались. Уже подумал, что [[РКН]] то ли подменяют [[DNS]] сервера, то ли блочат трафик с проверками [[DNSSEC]].

Проверка статуса [[systemd-resolved]]:

```sh
systemctl status systemd-resolved
```

Возникла следующая ошибка:

```log
systemd-resolved[508]: [🡕] DNSSEC validation failed for question go
ogle.com IN A: signature-expired
```

В итоге в ОС просто слетело время:

```sh
timedatectl status
```

Чтобы исправить запустите синхронизацию времени:

```sh
systemctl start systemd-timesyncd
```

После синхронизации лучше отключить:

```sh
systemctl start systemd-timesyncd
```