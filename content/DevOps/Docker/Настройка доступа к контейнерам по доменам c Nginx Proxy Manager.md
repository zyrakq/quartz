---
tags:
  - inbox
  - devops/docker
created: 2024-12-01T21:10:50+03:00
modified: 2024-12-29T07:38:02+03:00
categories:
  - nginx-proxy-manager
  - dns
  - dnsmasq
  - docker
sr-due: 2025-01-01
sr-interval: 3
sr-ease: 250
publish: true
---
[Local DNS for Docker Containers using Pi-hole + Portainer + Nginx Proxy Manager](https://roadtohomelab.blog/local-dns-for-docker-containers-using-pi-hole-portainer-nginx-proxy-manager/) - оригинальная статья на основе которой разбирался как настроить локальное управление доменами.
### Развертывание Nginx Proxy Manager

[GitHub - NginxProxyManager/nginx-proxy-manager: Docker container for managing Nginx proxy hosts with a simple, powerful interface](https://github.com/NginxProxyManager/nginx-proxy-manager)

Создаем `docker-compose.yml` файл:

```yml title:docker-compose.yml ln:true hl:9
services:
  nginx-proxy-manager:
    container_name: nginx-proxy-manager
    image: "jc21/nginx-proxy-manager:latest"
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
      - "81:81"
    volumes:
      - data:/data
      - letsencrypt:/etc/letsencrypt
    networks:
      - nginx-proxy-network

networks:
  nginx-proxy-network:
    name: nginx-proxy-network

volumes:
  data:
  letsencrypt:

```

9 строку после [[Настройка доступа к контейнерам по доменам c Nginx Proxy Manager#Настройка Nginx Proxy Manager|настройки Nginx Proxy Manager]] можно будет удалить или закомментировать, так как доступ будет предоставляться уже по доменному имени.

Запускаем:

```sh
docker-compose up --build -d
```

Заходим на `localhost:81` (или `<ip>:81`, если разворачиваете на удаленном сервере).

Вводим дефолтный логин/пароль:

```
Email:    admin@example.com
Password: changeme
```

После входа приложение сразу же предложит поменять на свои значения.

### Подготавка примера для тестирования

> [!tip] 
> Этот шаг можно пропустить, если доступа к контейнеру `nginx-proxy-manager` по доменному имени вам будет достаточно. Это пример нужен лишь для того, чтобы показать, что контейнер `nginx-proxy-manager` должен быть связан общей сетью c теми контейнерами на которые он ссылается.

Возьмем [[Настройка nginx с дефолтной стартовой страницой|контейнер nginx]] как пример для тестирования установки домена доступного с хоста на котором работает docker.

Создаем `docker-compose.yml` файл:

```yml title:docker-compose.yml ln:true
services:
  nginx:
    container_name: nginx
    image: nginx
    volumes:  
      - ./index.html:/usr/share/nginx/html/index.html
	networks:
      - nginx-proxy-network

networks:
  nginx-proxy-network:
    name: nginx-proxy-network
    external: true
```

Создадим папку со страницей отображаемой в nginx:

```sh
echo "Hello, World!" > ./index.html
```

Запускаем:

```sh
docker-compose up --build -d
```
### Настройка Nginx Proxy Manager

Теперь мы можем задать домен для этого контейнера и для тестового контейнера. Перейдем в `Hosts -> Proxy Hosts`:

![[proxy-hosts.png]]

> [!tip] 
> В моем случае домен верхнего уровня является `.ziq`, но вы можете указать любой другой. Чаще всего используется `.test` Будьте осторожнее с доменами `.local` и `.dev`, так как они часто резервируются браузерами.

И создадим две записи:

![[nginx-manager-ziq.png]]

![[nginx-ziq.png]]

Обратите внимание, что мы используем встроенный dns resolver в docker, чтобы разрешать имена из основного контейнера `nginx-proxy-manager`, который доступен по портам `80` и `443`. И возможно это из за того, что они связаны общей сетью `nginx-proxy-network`.

Теперь вам следует настроить dns сервер так, чтобы он отправлял при запросе этих адресов на сервер, где развернуты эти контейнеры или на `127.0.0.1`, если это требуется только для этого же хоста.

[[Настройка dnsmasq в docker]]
### Ссылки

[GitHub - pi-hole/docker-pi-hole: Pi-hole in a docker container](https://github.com/pi-hole/docker-pi-hole)

[Local DNS for Docker Containers using Pi-hole + Portainer + Nginx Proxy Manager](https://roadtohomelab.blog/local-dns-for-docker-containers-using-pi-hole-portainer-nginx-proxy-manager/)

Альтернатива:

[Site Unreachable](https://www.oodlestechnologies.com/blogs/how-to-configure-dns-proxy-for-docker-containers/)

[GitHub - mageddo/dns-proxy-server: Solve your DNS hosts from your docker containers, then from your local configuration, then from internet](https://github.com/mageddo/dns-proxy-server?tab=readme-ov-file)

