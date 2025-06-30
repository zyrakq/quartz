---
tags:
  - inbox
  - devops/docker/services/vpn
created: 2024-05-15T20:52:41+03:00
modified: 2025-05-02T00:03:46+03:00
categories:
  - wg
  - wireguard
  - docker
  - subnet
  - nmcli
  - NetworkManager
sr-due: 2025-06-14
sr-interval: 94
sr-ease: 250
publish: true
---
[wireguard - LinuxServer.io](https://docs.linuxserver.io/images/docker-wireguard/#site-to-site-vpn)
### Развертывание

Заменим `<ip_host>` на IP адрес хоста на котором разворачивается впн. Именно на этот IP адрес будет стучаться клиент для подключения.

Создать папку `config` в той же папке, где и файл `docker-compose.yml`:

```yml title:docker-compose.yml ln:true

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
      - SERVERURL=<ip_host> #optional
      - SERVERPORT=51820 #optional
      - PEERS=Laptop,Mobile,Pc,Tablet
      - PEERDNS=auto #optional
      - INTERNAL_SUBNET=10.13.13.0 #optional
      - ALLOWEDIPS=0.0.0.0/0 #optional
      # - SERVER_ALLOWEDIPS_PEER_Pc=10.13.13.2,10.13.13.5
      # - SERVER_ALLOWEDIPS_PEER_Tablet=10.13.13.2,10.13.13.3
      - LOG_CONFS=true #optional
    volumes:
      - ./config:/config:rw
      - /lib/modules:/lib/modules
    ports:
      - 51820:51820/udp
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1
    restart: unless-stopped
```

---

> [!faq] 
>  
Это создаст 4 клиента и соответствующие конфиги к ним в папке `config`.
>
В `PEERS` мы указываем наименования клиентов и так как в данном примере для внутренней подсети мы используем `10.13.13.0`, то сам сервер во внутренней подсети будет иметь IP: `10.13.13.1`, а клиентам будут присваиваться адреса по очередности  `Laptop`: `10.13.13.2`, `Mobile`: `10.13.13.3` и т. д.

Если мы хотим разрешить одним клиентам подключаться к другим (например, по *ssh*), то мы можем добавить **env** формата: 

```yml ln:true hl:3
environment:
	...
	- SERVER_ALLOWEDIPS_PEER_<client_name>=<another_client_ip>,<another_client_ip>,...
```

где:

* `<client_name>` - наименование клиента указаннного в `PEERS` к которому мы хотим предоставить доступ другим клиентам.

* `<another_client_ip>` - присвоенный внутренний IP адрес клиенту, которому требуется предоставить доступ к другому клиенту.

> [!attention] 
>  
Также бывают случаи, когда мы не хотим подменять наш настоящий IP адрес клиента IP адресом сервера. Это потребует дополнительных настроек и в этом случае для доступа к другим клиентам потребуется указывать не IP адрес внутренней подсети клиента, а тот же, что будет указан в разрешенных IP адресах для подключения к серверу.

---

Запустим:

```sh
docker-compose up --build -d
```

Теперь мы можем найти в папке `config` соответствующие конфиги и подключиться к серверу используя их.

### Импорт

Для быстрого добавление соединения в *NetworkManager* можно использовать команду `nmcli`:

```sh
nmcli connection import type wireguard file <filename.conf>
```

После вы можете провести [[Сайты для диагностики VPN и прокси|диагностику]] работы впн.

### Настройка клиентов

[[Настройка wireguard vpn клиента в docker]]

[[Настройка wireguard vpn клиента как прокси-сервер в docker]]

### Ссылки

[WireGuard in NetworkManager – Thomas Haller's Blog](https://blogs.gnome.org/thaller/2019/03/15/wireguard-in-networkmanager/)