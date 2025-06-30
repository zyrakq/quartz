---
tags:
  - archlinux
  - games
  - inbox
  - manjaro
created: 2024-12-05T18:18:15+03:00
modified: 2025-03-02T00:34:47+03:00
categories:
  - moonlight
  - archlinux
  - games
  - sunshine
  - manjaro
sr-due: 2025-01-01
sr-interval: 3
sr-ease: 250
publish: true
---
### Установим moonlight

**Moonlight** нужно устанавливать и на клиенте и на сервере.

В Arch Linux:

```sh
yay -S moonlight-qt
```

В Manjaro:

```sh
sudo pamac install moonlight-qt
```

### Развернем серверную часть

> [!note] 
> Не получилось настроить в контейнере. Пока что работают только альтернативные варианты. 

Сделаем это в docker. Создадим `docker-compose.yml`:

```yml title:docker-compose.yml ln:true
services:
  sunshine:
    image: lizardbyte/sunshine:latest-archlinux
    container_name: sunshine
    restart: unless-stopped
    volumes:
      - config:/config
    environment:
      - TZ=Europe/Moscow
    ipc: host
    ports:
      - "47984-47990:47984-47990/tcp"
      - "48010:48010"
      - "47998-48000:47998-48000/udp"
volumes:
  config:
```

Запустим:

```sh
docker compose up --build -d
```

[Sunshine: Docker](https://docs.lizardbyte.dev/projects/sunshine/en/master/md_DOCKER__README.html)
#### Альтернативные варианты

В Arch Linux:

```sh
yay -S sunshine
```

---

В Manjaro

```sh
pamac install sunshine
```

---

При установке пакета может возникнуть проблема git по http. В этом случае можно попробовать [[Принудительная подмены протокола запросов в git с http на ssh|настроить подмену http запросов на ssh ]].

---

Запустим **sunshine**:

```sh
sunshine
```

Добавьте пользователя, чтобы ограничить доступ к настройкам в локальной сети.
### Подключаем клиент к серверу

```sh
moonlight
```

Если в локальной сети устройство не было найдено, то скорее всего **upnp** в **sunshine** отключен. Но можно добавить сервер вручную по ip. Нажмите добавить устройство и введите ip адрес.

Перейдите в **sunshine** по `https://{ip}:47990` и авторизуйтесь.



