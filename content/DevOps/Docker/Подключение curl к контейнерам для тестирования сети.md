---
created: 2024-08-05T13:38:03+03:00
modified: 2024-12-29T09:32:03+03:00
tags:
  - inbox
  - devops/docker/services
categories:
  - docker
  - curl
sr-due: 2025-01-01
sr-interval: 3
sr-ease: 250
publish: true
---
Для выполнения запросов из внутренней сети контейнеров добавьте в `docker-compose.yml`:

```yml title:docker-compose.yml ln:true
curl:
  image: curlimages/curl:latest
  container_name: curl
  command: sleep infinity
  networks:
    - <network>
```

где `<network>` требуется заменить на сеть в которой работает контейнер.

сервису `curl` необязательно находиться в том же файле `docker-compose.yml`, но тогда сеть к которой подключается `curl` должна быть помечена как *external*:

```yml title:docker-compose.yml ln:true hl:6,8-11
curl:
  image: curlimages/curl:latest
  container_name: curl
  command: sleep infinity
  networks:
    - app-network
      
networks:
  app-network:
    name: app-network
	external: true
```

После достаточно подключиться к контейнеру:

```sh
docker exec -it <имя_контейнера> /bin/bash
```

И выполнить запрос [[Сайты для диагностики VPN и прокси|к сайту для диагностики]].