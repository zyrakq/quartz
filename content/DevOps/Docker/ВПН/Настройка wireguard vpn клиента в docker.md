---
tags:
  - inbox
  - devops/docker/services/vpn
created: 2024-10-30T14:49:16+03:00
modified: 2025-03-13T05:13:59+03:00
categories:
  - wireguard
  - docker
  - vpn
  - devops
  - tinyproxy
sr-due: 2026-06-21
sr-interval: 465
sr-ease: 250
publish: true
---
[wireguard - LinuxServer.io](https://docs.linuxserver.io/images/docker-wireguard/#site-to-site-vpn)

[Routing Docker Host And Container Traffic Through WireGuard | LinuxServer.io](https://www.linuxserver.io/blog/routing-docker-host-and-container-traffic-through-wireguard#routing-a-containers-traffic-through-the-wireguard-container-via)

**Где и для чего лучше использовать?**

Для маршрутизации трафика других контейнеров через впн.

### Настройка

#### Настройка клиента

Собираем образ [[Локальная сборка образов docker для большей надежности|локально]] на основе `Dockerfile` из репозитория или используем уже собранный образ.

Создаем `docker-compose.yml` со следующим содержимым:

```yaml title:docker-compose.yml ln:true
services:
  wireguard:
    image: lscr.io/linuxserver/wireguard:latest
    container_name: wireguard
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Moscow
    volumes:
      - ./config:/config:rw
      - /lib/modules:/lib/modules
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1
    restart: unless-stopped
    networks:
      - wireguard-network

networks:
  wireguard-network:
    name: wireguard-network
    driver: bridge
```

Создаем папку `config` :

```sh
mkdir config
```

Добавляем файл конфигурации вашего *VPN* в `config/wg0.conf`:

```sh
cp <path_to_your_vpn_config> ./config/wg0.conf
```

Запускаем:

```sh
docker-compose up --build -d
```

---

В России протокол *Wireguard* может блокироваться из за чего контейнер будет постоянно падать. На данный момент это можно обойти включив другой зарубежный впн при старте контейнера и как первое подключение будет осуществлено впн можно отключить.

Также можно попробовать настроить, чтобы первое обращение осуществлялось через впн или прокси.

#### Проверка

[[Сайты для диагностики VPN и прокси]]

Проверяем:

```sh
docker exec -it wireguard bash 
```

```sh
curl ipinfo.io
```

```json ln:true hl:3-4,9
{
  "ip": "<ip>",
  "city": "Amsterdam",
  "region": "North Holland",
  "country": "NL",
  "loc": "<loc>",
  "org": "<org>",
  "postal": "<postal>",
  "timezone": "Europe/Amsterdam",
  "readme": "https://ipinfo.io/missingauth"
}
```

Также, если этот контейнер используется другим контейнером, то [[Подключение curl к контейнерам для тестирования сети|здесь]] описано как можно проверить корректность работы впн.
#### Настройка контейнера потребителя VPN

Добавим другой контейнер. что будет выходить в сеть через наш *VPN*:

```yaml title:docker-compose.yml ln:true fold
services:
  wireguard:
    image: lscr.io/linuxserver/wireguard:latest
    container_name: wireguard
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Moscow
    volumes:
      - ./config:/config:rw
      - /lib/modules:/lib/modules
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1
    restart: unless-stopped
    networks:
      - wireguard-network
  
  curl:
    image: curlimages/curl:latest
    container_name: curl
    command: sleep infinity
    network_mode: "service:wireguard"

networks:
  wireguard-network:
    name: wireguard-network
    driver: bridge
```

Запускаем:

```sh
docker-compose up --build -d
```

[[Настройка wireguard vpn клиента в docker#Проверка|Проверка]] осуществляется аналогичным образом.

---

> [!tldr] 
> Обратитие внимание, что если ваш конфиг требует использование определенный *DNS* сервер, то контейнеры связанные общей сетью (мостом) могут быть не доступны из конейнера *Wireguard* и контейнеров включенных в эту же сетевую группу ( то есть с установленным: `network_mode: "service:wireguard"`). 

Например:

```yaml title:docker-compose.yml ln:true fold
services:
  wireguard:
    image: lscr.io/linuxserver/wireguard:latest
    container_name: wireguard
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Moscow
    volumes:
      - ./config:/config:rw
      - /lib/modules:/lib/modules
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1
    restart: unless-stopped
    networks:
      - wireguard-network
  
  curl:
    image: curlimages/curl:latest
    container_name: curl
    command: sleep infinity
    network_mode: "service:wireguard"
  
  tinyproxy:
    image: vimagick/tinyproxy
    container_name: tinyproxy
    volumes:
      - ./data:/etc/tinyproxy
    restart: unless-stopped
    networks:
      - wireguard-network

networks:
  wireguard-network:
    name: wireguard-network
    driver: bridge
```

> [!attention] 
>  Не обязательно использовать *tinyproxy*, например вы можете использовать еще один контейнер *curl*, но с другим именем. *tinyproxy* используется здесь для демонстрации выхода в сеть минуя *VPN*.

Создаем папку `data` :

```sh
mkdir data
```

Добавляем файл конфигурации *tinyproxy* в`data/tinyproxy.conf`:

```toml title:data/tinyproxy.conf ln:true fold
User nobody
Group nogroup

Port 8888
Timeout 600
DefaultErrorFile "@pkgdatadir@/default.html"
StatFile "@pkgdatadir@/stats.html"

LogLevel Info

MaxClients 1024

ViaProxyName "tinyproxy"
DisableViaHeader Yes
```

[dockerfiles/tinyproxy at master · vimagick/dockerfiles · GitHub](https://github.com/vimagick/dockerfiles/blob/master/tinyproxy/)

Запускаем:

```sh
docker-compose up --build -d
```

---

Проверяем:

```sh
docker exec -it curl bash 
```

```sh
ping tinyproxy
```

```log
ping: bad address 'tinyproxy'
```

Чтобы это исправить требуется добавить *DNS* сервер от *Docker* в конфиг файл клиента *Wireguard*. По умолчанию *DNS* сервер это `127.0.0.11`. И в нашем случае его требуется добавить в `config/wg0.conf`:

```toml title:config/wg0.conf ln:true hl:5
[Interface]
Address = <Address>
PrivateKey = <PrivateKey>
ListenPort = <ListenPort>
DNS = 127.0.0.11 <DNS>

[Peer]
PublicKey = <PublicKey>
PresharedKey = <PresharedKey>
Endpoint = <Endpoint>
AllowedIPs = <AllowedIPs>
```

Проверяем:

```sh
docker exec -it curl bash 
```

```sh
ping tinyproxy
```

```log
PING tinyproxy (172.18.0.2): 56 data bytes
64 bytes from 172.18.0.2: seq=0 ttl=42 time=0.210 ms
64 bytes from 172.18.0.2: seq=1 ttl=42 time=0.167 ms
64 bytes from 172.18.0.2: seq=2 ttl=42 time=0.167 ms
```

---

Если вы использовали *tinyproxy* из примера, то вы также можете использовать его для выхода в сеть минуя соединение *Wireguard*:

```sh
curl -x http://tinyproxy:8888 ipinfo.io
```

```json ln:true hl:3-4,9
{
  "ip": "<ip>",
  "city": "Moscow",
  "region": "Moscow",
  "country": "RU",
  "loc": "<loc>",
  "org": "<org>",
  "postal": "<postal>",
  "timezone": "Europe/Moscow",
  "readme": "https://ipinfo.io/missingauth"
}
```


### Связанные материалы

[[Настройка wireguard vpn сервера в docker]]

[[Настройка wireguard vpn клиента как прокси-сервер в docker]]

[[Настройка cloudfire warp vpn клиента как прокси-сервер в docker]]

[[Настройка amneziawg vpn клиента как прокси-сервер в docker]]
