---
tags:
  - devops/docker
  - inbox
created: 2024-11-28T22:52:37+03:00
modified: 2024-12-29T07:37:53+03:00
sr-due: 2024-12-18
sr-interval: 3
sr-ease: 252
categories:
  - dns
  - dnsmasq
  - linux
  - docker
  - systemd-resolved
  - stub
publish: true
---
### Настройка контейнера

#### Локальная сборка образа

> [!tip] 
> Этот шаг можно пропустить, если вы готовы взять на себя риски того, что в [контейнере](https://hub.docker.com/r/4km3/dnsmasq) могут быть иньекции.

Получаем репозиторий с `.Dockerfile`:

```sh
git clone git@github.com:4km3/docker-dnsmasq.git
```

Собираем образ [[Локальная сборка образов docker для большей надежности|локально]].

```sh
docker build -t dnsmasq:v2.86 .
```

```sh
docker tag dnsmasq:v2.86 localhost/dnsmasq:v2.86
```

#### Созадние контейнера

Создается `docker-compose.yml` файл:

```yml title:docker-compose.yml ln:true
services:
  dnsmasq:
    image: localhost/dnsmasq:v2.86 # 4km3/dnsmasq:2.86-r0
    cap_add:
      - NET_ADMIN
    ports:
      - "53:53/tcp"
      - "53:53/udp"
    environment:
      #/<domain>/<ipaddr>,/<domain>/<ipaddr>
      DNSMASQ_SERVERS: /<domain>/<ipaddr>
    command: ["-S", "${DNSMASQ_SERVERS}"]
```

Запускаем:

```sh
docker-compose up --build -d
```

Далее требуется добавить `127.0.0.1:53` в `/etc/resolv.conf`. Но указания  dns сервера в клиента может различаться в зависимости от ваших настроек. В случае если вы используете **systemd-resolved**  в режиме [[Переключение systemd-resolved в режим stub|stub]], то из него не получится ссылаться на локальный **dnsmasq**, так как в этом режиме порт `53` уже занят.


[hub.docker.com/r/4km3/dnsmasq](https://hub.docker.com/r/4km3/dnsmasq)

[Dnsmasq - network services for small networks.](https://thekelleys.org.uk/dnsmasq/doc.html)

[GitHub - 4km3/docker-dnsmasq: My dnsmasq brings all the boys to the yard, and they're like, it's smaller than yours! -- @andyshinn](https://github.com/4km3/docker-dnsmasq)

[network programming - Pass current local ip to dnsmasq command in docker-compose - Stack Overflow](https://stackoverflow.com/questions/56816042/pass-current-local-ip-to-dnsmasq-command-in-docker-compose)

[How to Set Up a Local DNS Server with Docker - DEV Community](https://dev.to/victoramit/how-to-set-up-a-local-dns-server-with-docker-280n)

Альтернатива:

[Setting Up a Local DNS Service with Docker on Ubuntu 22.04 - DEV Community](https://dev.to/mich0w0h/setting-up-a-local-dns-service-with-docker-on-ubuntu-2204-290i)




