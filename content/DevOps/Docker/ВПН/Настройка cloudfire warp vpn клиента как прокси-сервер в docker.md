---
tags:
  - inbox
  - devops/docker/services/vpn
sr-due: 2025-03-29
sr-interval: 89
sr-ease: 250
created: 2024-08-23T10:35:19+03:00
modified: 2025-03-12T04:55:20+03:00
categories:
  - docker
  - vpn
  - warp
  - cloudfire
  - proxy
  - socks5
  - devops
publish: true
---
**Где и для чего лучше использовать?**

Для проксирования трафика основного хоста или устройств в одной локальной сети. При этом если устройства в одной локальной сети, то на каждом устройстве потребуется назначить общий прокси-сервер.

### Настройка

[GitHub - ArcticLampyrid/docker-warp-socks5](https://github.com/ArcticLampyrid/docker-warp-socks5) - образ использует два других популярных репозитория и в его конфигурации мною не был обнаружен вредоносный код. Но я не проверял тот ли скрипт находится в контейнере.
#### Docker

```sh
docker run -d -p 40000:40000 qiqiworld/warp-socks5
```

[[Сайты для диагностики VPN и прокси]]

Проверяем:

```sh
curl -x socks5://localhost:40000 ipinfo.io
```
#### Docker Compose для проксирования на хосте

Создаем `docker-compose.yml` со следующим содержимым:

```yaml title:docker-compose.yml ln:true
services:
  warp:
    image: qiqiworld/warp-socks5:latest
    restart: unless-stopped
    container_name: warp
    ports:
      - 40000:40000
```

Запускаем:

```sh
docker-compose up --build -d
```

В России и [[warp]] и сам протокол [[wireguard]] может блокироваться из за чего контейнер будет постоянно падать. На данный момент это можно обойти включив другой зарубежный [[vpn]] или проксировав обращение к домену`api.cloudflareclient.com` через зарубежный сервер при старте контейнера и как первое подключение будет осуществлено [[vpn]] или [[прокси-сервер]] можно отключить.

[[Сайты для диагностики VPN и прокси]]

Проверяем:

```sh
curl -x socks5://localhost:40000 ipinfo.io
```

Также, если этот контейнер используется другим контейнером, то [[Подключение curl к контейнерам для тестирования сети|здесь]] описано как можно проверить корректность работы впн - как прокси сервера. При таком решении запрос `curl` из контейнера будет выглядеть так:

```sh
curl -x socks5://warp:40000 ipinfo.io
```

### Прокси-клиенты

[[Настройка прокси-клиента в Chromium]]

### Альтернативные образы

[GitHub - cmj2002/warp-docker: Run Cloudflare WARP in Docker.](https://github.com/cmj2002/warp-docker)

[GitHub - kingcc/warproxy: Make Cloudflare WARP your SOCKS5/HTTP proxy server with a single command! Simplest minimal container based on Alpine.](https://github.com/kingcc/warproxy)

Содержимое этих репозиториев мною проверены не были.

### Похожие материалы

[[Настройка wireguard vpn клиента как прокси-сервер в docker]]

[[Настройка amneziawg vpn клиента как прокси-сервер в docker]]

[[Настройка wireguard vpn клиента в docker]]