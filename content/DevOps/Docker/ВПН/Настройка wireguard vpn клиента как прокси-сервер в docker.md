---
tags:
  - inbox
  - devops/docker/services/vpn
created: 2024-10-30T14:49:16+03:00
modified: 2025-05-04T22:06:39+03:00
categories:
  - wireguard
  - docker
  - vpn
  - proxy
  - devops
  - socks5
sr-due: 2025-03-15
sr-interval: 75
sr-ease: 250
publish: true
---
[GitHub - pufferffish/wireproxy: Wireguard client that exposes itself as a socks5 proxy](https://github.com/pufferffish/wireproxy)

**Где и для чего лучше использовать?**

Для проксирования трафика основного хоста или устройств в одной локальной сети. При этом если устройства в одной локальной сети, то на каждом устройстве потребуется назначить общий прокси-сервер.

### Настройка

Собираем образ [[Локальная сборка образов docker для большей надежности|локально]] на основе `Dockerfile` из репозитория или используем один из собранных другими пользователями:

[hub.docker.com/search?q=wireproxy](https://hub.docker.com/search?q=wireproxy)

Например: `otocon/wireproxy:latest`.

Создаем `docker-compose.yml` со следующим содержимым:

```yaml title:docker-compose.yml ln:true
services:
  wireproxy:
    image: localhost/wireproxy:v1.0.9
    restart: unless-stopped
    container_name: wireproxy
    ports:
      - 65432:65432
    volumes:
      - ./wireproxy:/etc/wireproxy
```

Создаем папку `wireproxy` :

```sh
mkdir wireproxy
```

Создаем файл `config`:

```sh
touch wireproxy/config
```

```sh
nano wireproxy/config
```

Со следуюзим содержимым:

```ini
WGConfig = /etc/wireproxy/wg0.conf

[Socks5]
BindAddress = 0.0.0.0:65432
```

Добавляем файл конфигурации вашего впн в папку `wireproxy` по именем `wg0.conf`:

```sh
cp <path_to_your_vpn_config> ./wireproxy/wg0.conf
```

Запускаем:

```sh
docker-compose up --build -d
```

В России протокол *Wireguard* может блокироваться из за чего контейнер будет постоянно падать. На данный момент это можно обойти включив другой зарубежный впн при старте контейнера и как первое подключение будет осуществлено впн можно отключить.

Также можно попробовать настроить, чтобы первое обращение осуществлялось через впн или прокси.

[[Сайты для диагностики VPN и прокси]]

Проверяем:

```sh
curl -x socks5://localhost:65432 ipinfo.io
```

Также, если этот контейнер используется другим контейнером, то [[Подключение curl к контейнерам для тестирования сети|здесь]] описано как можно проверить корректность работы впн - как прокси сервера. При таком решении запрос `curl` из контейнера будет выглядеть так:

```sh
curl -x socks5://wireproxy:65432 ipinfo.io
```
### Прокси-клиенты

[[Настройка прокси-клиента в Chromium]]

### Похожие материалы

[[Настройка cloudfire warp vpn клиента как прокси-сервер в docker]]

[[Настройка amneziawg vpn клиента как прокси-сервер в docker]]

### Связанные материалы

[[Настройка wireguard vpn сервера в docker]]

[[Настройка wireguard vpn клиента в docker]]
