---
tags:
  - inbox
  - devops/docker
categories:
  - docker
created: 2024-10-31T08:56:28+03:00
modified: 2024-11-03T00:14:17+03:00
sr-due: 2024-11-06
sr-interval: 3
sr-ease: 250
publish: true
---
Как правильно писать `Dockerfile`, чтобы другим не приходилось [[Локальная сборка образов docker для большей надежности|собирать образы локально]], а можно было просто посмотреть на файл сборки в [[репозитории образов]] и убедиться, что в нем нет потенциального вредоносного кода?
### Инструкция

Заходим в репозиторий проекта, образ которого мы хотим собрать. Здесь, как пример, будет использован репозиторий: [GitHub - pufferffish/wireproxy: Wireguard client that exposes itself as a socks5 proxy](https://github.com/pufferffish/wireproxy). Который используется для настройки [[Настройка wireguard vpn клиента как прокси-сервер в docker|wireguard как прокси-сервер]].

Смотрим есть ли готовые [релизы](https://github.com/pufferffish/wireproxy/releases) в виде архивов?

Если да, то мы можем создать `Dockerfile` не требующий доверия.

Также нужно разобраться для каких архитектур есть собранные решения? В случае данного репозитория у нас есть сборки для:
- 386
- arm
- arm64
- amd64
- mips
- mipsle

Теперь мы можем составить команду для загрузки архива:

```yaml title:docker-compose.yml ln:true hl:4-9
FROM alpine:latest

RUN apk add --no-cache curl \
    && ARCH=$(uname -m) \
    && if [ "${ARCH}" = "i386" ]; then ARCH="386"; fi \
    && if [ "${ARCH}" = "i686" ]; then ARCH="386"; fi \
    && if [ "${ARCH}" = "x86_64" ]; then ARCH="amd64"; fi \
    && if [ "${ARCH}" = "aarch64" ]; then ARCH="arm64"; fi \
    && WIREPROXY_URL=$(curl -fsSL https://api.github.com/repos/pufferffish/wireproxy/releases/latest | grep 'browser_download_url' | cut -d'"' -f4 | grep "wireproxy_linux_${ARCH}.tar.gz") \
    && curl -fsSL "${WIREPROXY_URL}" -o ./wireproxy.tar.gz \
    && tar -xzf wireproxy.tar.gz \
    && rm wireproxy.tar.gz \
    && chmod +x ./wireproxy \
    && mv ./wireproxy /usr/bin

VOLUME [ "/etc/wireproxy"]
ENTRYPOINT [ "/usr/bin/wireproxy" ]
CMD [ "--config", "/etc/wireproxy/config" ]

LABEL org.opencontainers.image.title="wireproxy"
LABEL org.opencontainers.image.description="Wireguard client that exposes itself as a socks5 proxy"
LABEL org.opencontainers.image.licenses="ISC"
```

где:

- `| grep 'browser_download_url'`
    - Эта часть фильтрует выходные данные curl, оставляя только строки, содержащие 'browser_download_url'.

- `| cut -d'"' -f4`
    - Вырезает четвертое поле из каждой строки, используя двойную кавычку как разделитель. (в данном случае отбрасывает ключ "browser_download_url" и оставляет Value коим является URL)
    - Это извлекает фактический URL загрузки.

- `| grep "wireproxy_linux_${ARCH}.tar.gz"`
    - Финальный grep фильтрует результаты, оставляя только строку, содержащую URL архива с правильным названием файла для конкретной архитектуры.

Далее разархивируем архив, удаляем его, делаем исполняемым и переносим в папку, где он по стандарту хранится. После копируем стандартные строки запуска из `Dockerfile` хранящемся в репозитории.