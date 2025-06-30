---
tags:
  - inbox
  - devops/docker/services
categories:
  - nginx
  - limit
  - docker
  - dns
created: 2024-12-24T21:28:20+03:00
modified: 2024-12-25T02:43:59+03:00
sr-due: 2024-12-28
sr-interval: 3
sr-ease: 250
publish: true
---
### Инструкция

#### Шаблон для генерации конфигураций nginx

Нам нужен nginx для регулирование доступа к стороннему ресурсу. Ресурсом может выступать любой сторонний сайт.

Подготовим шаблон для nginx. Создадим файл `default.conf.template`:

```ruby title:default.conf.template ln:true
limit_req_zone $binary_remote_addr zone=mylimit:${NGINX_LIMIT_ZONE_SIZE} rate=${NGINX_LIMIT_ZONE_RATE};
resolver ${NGINX_RESOLVER};

server {
    listen        ${NGINX_PORT};
    server_name ${NGINX_HOST};
    location  ~* ^/(.*) {
        limit_req zone=mylimit;
        limit_req_status ${NGINX_LIMIT_REQ_STATUS};
        proxy_pass ${NGINX_PROXY_PASS}$request_uri;
    }
}
```

##### Описание конфигурации

`limit_req_zone $binary_remote_addr zone=mylimit:${NGINX_LIMIT_ZONE_SIZE} rate=${NGINX_LIMIT_ZONE_RATE};` - создает зону ограниченного доступа.

* `${NGINX_LIMIT_ZONE_SIZE}` - размер зоны влияет на количество одновременных соединений или IP-адресов, которые могут быть обрабатываться одновременно. Для небольших веб-сайтов или приложений с низким трафиком можно использовать меньшие зоны (например, 1m или 2m).

* `${NGINX_LIMIT_ZONE_RATE}` - ограничение количество запросов в единицу времени. Например: `7r/s` - лимит 7 запросов в секунду.

`resolver ${NGINX_RESOLVER};` - используйте Google's DNS или другой DNS сервер, например, ваш локальный DNS. Нужен для того, чтобы nginx смог узнать ip адрес к сайту на который будут пересылаться запросы не превысившие лимиты по пропускной способности.

`${NGINX_PORT}` - порт на котором будет работать экземпляр nginx.

`${NGINX_HOST}` - хост на который будут приниматься запросы для nginx.

Так как мы планируем развертывать nginx в контейнере, то для нас подойдут значения `localhost:80`.

`~* ^/(.*)` - регулярное выражение для перехвата всех запросов. В некоторых версиях nginx может потребоваться другой паттерн.

`limit_req zone=mylimit;` указываем что для запросов к этому ресурсу установлен созданный нами лимит.

`limit_req_status ${NGINX_LIMIT_REQ_STATUS};` - указываем какой статус должен возвращаться в случае превышения лимита по запросам. Если не задавать, то по умолчанию будет возвращать 503. Если сервис не использует 429 статус, то он будет более подходящим.

`${NGINX_PROXY_PASS}$request_uri;` - где:
	`${NGINX_PROXY_PASS}` - url сайта на который мы хотим перенаправлять запросы. Например: `https://example.com`.
	`$request_uri` - остальная часть запроса попавшая под соответствие регулярного выражения.

#### Развертывание

Создадим файл `docker-compose.yml`:

```yml title:docker-compose.yml ln:true
services:
  nginx-limit:
    container_name: nginx-limit
    image: nginx
    restart: unless-stopped
    volumes:
      - ./default.conf.template:/etc/nginx/templates/default.conf.template:rw
    environment:
      NGINX_PORT: 80
      NGINX_HOST: localhost
      NGINX_LIMIT_ZONE_SIZE: 10m
      NGINX_LIMIT_ZONE_RATE: 7r/s
      NGINX_RESOLVER: 8.8.8.8
      NGINX_LIMIT_REQ_STATUS: 507
      NGINX_PROXY_PASS: https://example.com
    logging:
      driver: "json-file"
      options:
        max-size: 10m
        max-file: 3
    networks:
      - nginx-limit-network

networks:
  nginx-limit-network:
    name: nginx-limit-network
    driver: bridge
```

```sh
docker-compose up --build -d
```

Для контейнеров, которые должны обращаться к сайту через этот прокси можно добавить сеть таким образом:

```yml title:docker-compose.yml ln:true hl:4-5,7-10
services:
  http-client:
	...
    networks:
      - nginx-limit-network

networks:
  nginx-limit-network:
    name: nginx-limit-network
    external: true
```

Теперь при обращении к `http://localhost:80/*` запросы будут перебрасываться на `https://example.com/*` и в случае если количество запросов за секунду будет превышать указанное значение, будет возвращаться статус 507.

Также добавлено ограничение на размер лога, чтобы контейнер не забил память на хосте.
### Обновление

Так как контейнер использует шаблон конфигурации nginx, а не конфигурации nginx, то для того, чтобы значения в переменной среды изменились или если мы хотим чтобы измения в шаблоне отразились на контейнере, нам потребуется удалить образ контейнера.

```sh
docker-compose down
```

### Проверка

Чтобы убедиться в том, что ограничение действительно работает пробросьте порт на `localhost` и уменьшите ограничение до 1 запросов в секунду:

```yml title:docker-compose.yml ln:true hl:12,17
services:
  nginx-limit:
    container_name: nginx-limit
    image: nginx
    restart: unless-stopped
    volumes:
      - ./default.conf.template:/etc/nginx/templates/default.conf.template:rw
    environment:
      NGINX_PORT: 80
      NGINX_HOST: localhost
      NGINX_LIMIT_ZONE_SIZE: 10m
      NGINX_LIMIT_ZONE_RATE: 1r/s
      NGINX_RESOLVER: 8.8.8.8
      NGINX_LIMIT_REQ_STATUS: 507
      NGINX_PROXY_PASS: https://example.com
	ports:
	  - 8080:80
    logging:
      driver: "json-file"
      options:
        max-size: 10m
        max-file: 3
    networks:
      - nginx-limit-network

networks:
  nginx-limit-network:
    name: nginx-limit-network
    driver: bridge
```

```sh
docker-compose down
```

```sh
docker-compose up --build -d
```

И пользуясь привычным инструментом для выполнения запросов (например **postman** или **insomnia**) выполните несколько быстрых обращений к контейнеру.

![[insomnia_507.png]]