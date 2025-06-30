---
tags:
  - inbox
  - archlinux
created: 2025-05-20T07:28:13+03:00
modified: 2025-06-14T10:23:31+03:00
categories:
  - docker
  - archlinux
  - nvidia-ctk
  - nvidia-container-toolkit
  - nvidia-container-runtime
  - nvidia
  - socks5
  - proxy
sr-due: 2025-05-23
sr-interval: 3
sr-ease: 250
publish: true
---
### Установка

```sh
sudo pacman -S docker docker-compose
```

Чтобы работать с docker без sudo:

```sh
sudo groupadd docker
```

```sh
sudo usermod -aG docker $USER
```

```sh
newgrp docker
```

Ставим в автозапуск и запускаем:

```sh
sudo systemctl enable --now docker
```

Проверяем:

```sh
sudo systemctl status docker
```

Если наблюдаются проблемы, то скорее всего просто требуется перезагрузка.

### Настройка прокси

```sh
sudo nano ~/.docker/config.json
```

```json title:~/.docker/config.json ln:true
{
   "proxies": {
      "default": {
        "httpProxy": "socks5://127.0.0.1:65432",
        "httpsProxy": "socks5://127.0.0.1:65432"
   }
}
```

```sh
sudo systemctl restart docker
```

### Настройка GPU (Nvidia)

```sh
sudo pacman -S nvidia-container-toolkit
```

Модифицируем `/etc/docker/daemon.json`:

```sh
sudo nvidia-ctk runtime configure --runtime=docker
```

Должно получиться что то вроде этого:

```json title:/etc/docker/daemon.json ln:true
{
    "default-runtime": "nvidia",
    "runtimes": {
        "nvidia": {
            "args": [],
            "path": "nvidia-container-runtime"
        }
    }
}
```

```sh
sudo systemctl restart docker
```