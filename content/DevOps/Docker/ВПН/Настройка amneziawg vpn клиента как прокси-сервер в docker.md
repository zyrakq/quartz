---
tags:
  - inbox
  - devops/docker/services/vpn
created: 2024-10-30T14:49:16+03:00
modified: 2025-03-12T04:55:07+03:00
categories:
  - wireguard
  - docker
  - vpn
  - proxy
  - devops
  - amnezia
  - amneziawg
  - socks5
sr-due: 2025-03-16
sr-interval: 76
sr-ease: 250
publish: true
---
[GitHub - artem-russkikh/wireproxy-awg: AmneziaWG compatible wireguard client that exposes itself as a socks5 proxy](https://github.com/artem-russkikh/wireproxy-awg)

**Где и для чего лучше использовать?**

Для проксирования трафика основного хоста или устройств в одной локальной сети. При этом если устройства в одной локальной сети, то на каждом устройстве потребуется назначить общий прокси-сервер.

### Настройка

Собираем образ [[Локальная сборка образов docker для большей надежности|локально]] на основе `Dockerfile` из репозитория или используем один из собранных другими пользователями:

[hub.docker.com/search?q=wireproxy-awg](https://hub.docker.com/search?q=wireproxy-awg)

Например: `dgst/wireproxy-awg:latest`.

#### Локальная сборка

```sh
docker build -t wireproxy-awg:v1.0.11 .
```

```sh
docker tag wireproxy-awg:v1.0.11 localhost/wireproxy-awg:v1.0.11
```

#### Развертывание

Создаем `docker-compose.yml` со следующим содержимым:

```yaml title:docker-compose.yml ln:true
services:
  wireproxy-awg:
    image: localhost/wireproxy-awg:v1.0.11
    restart: unless-stopped
    container_name: wireproxy-awg
    ports:
      - 65433:65433
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
BindAddress = 0.0.0.0:65433
```

Добавляем файл конфигурации ващего впн в папку `wireproxy` по именем `wg0.conf`:

```sh
cp <path_to_your_vpn_config> ./wireproxy/wg0.conf
```

Запускаем:

```sh
docker-compose up --build -d
```

[[Сайты для диагностики VPN и прокси]]

Проверяем:

```sh
curl -x socks5://localhost:65433 ipinfo.io
```

Также, если этот контейнер используется другим контейнером, то [[Подключение curl к контейнерам для тестирования сети|здесь]] описано как можно проверить корректность работы впн - как прокси сервера. При таком решении запрос `curl` из контейнера будет выглядеть так:

```sh
curl -x socks5://wireproxy-awg:65433 ipinfo.io
```
### Прокси-клиенты

[[Настройка прокси-клиента в Chromium]]

### ### Похожие материалы

[[Настройка wireguard vpn клиента как прокси-сервер в docker]]

[[Настройка cloudfire warp vpn клиента как прокси-сервер в docker]]

[[Настройка wireguard vpn клиента в docker]]

