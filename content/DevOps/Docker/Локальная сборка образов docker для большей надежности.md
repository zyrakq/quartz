---
tags:
  - inbox
  - devops/docker
categories:
  - docker
created: 2024-10-31T08:48:31+03:00
modified: 2025-03-16T09:09:52+03:00
sr-due: 2024-11-03
sr-interval: 3
sr-ease: 250
publish: true
---
Большинство образов на [docker.com](https://hub.docker.com) собираются локально и у скачивающего нет возможности убедиться, что в образах нет вредоносного кода. Для того, чтобы у скачивающих образы было доверие к источнику требуется [[Организация файла сборки docker не требующего доверия|правильно составлять файл сборки]]. Но не все этому правилу следует, поэтому требуется выработать последовательность действий в случае, если образ не вызывает доверие, но он все же требуется для выполнение задачи.

### Инструкция

На примере репозитория: [GitHub - pufferffish/wireproxy: Wireguard client that exposes itself as a socks5 proxy](https://github.com/pufferffish/wireproxy)

Итак, мы пытаемся найти контейнер, который был собран без использования локальных файлов:

[hub.docker.com/search?q=wireproxy](https://hub.docker.com/search?q=wireproxy)

Мы не находим такой и тогда нам требуется собрать его локально из репозитория, код которого мы проверили или же доверяем по другим причинам.

```sh
git clone https://github.com/pufferffish/wireproxy.git
```

```sh
cd wireproxy
```

Собираем образ:

```sh
docker build -t wireproxy:v1.0.9 .
```

```sh
docker tag wireproxy:v1.0.9 localhost/wireproxy:v1.0.9
```

Теперь этот образ можно использовать для запуска:

```yaml title:docker-compose.yml ln:true
services:
  wireproxy:
    image: localhost/wireproxy:v1.0.9
    restart: unless-stopped
    container_name: wireproxy
    ports:
      - 40000:40000
```

```sh
docker-compose up --build -d
```

Но можно пойти дальше и создать репозиторий, где будет храниться [[Организация файла сборки docker не требующего доверия|файл сборки не требующий доверия]].

### Замена образа

Для замены образа достаточно собрать новый образ с тем же тегом:

```sh
docker build -t wireproxy:v1.0.9 .
```

```sh
docker tag wireproxy:v1.0.9 localhost/wireproxy:v1.0.9
```

Старые образы потеряют эти теги и чтобы их удалить требуется выполнить:

```sh
docker image prune -f
```