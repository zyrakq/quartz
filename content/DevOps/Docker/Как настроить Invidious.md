---
tags:
  - inbox
  - devops/docker/services
sr-due: 2024-10-03
sr-interval: 34
sr-ease: 290
created: 2024-08-20T23:02:23+03:00
modified: 2024-10-19T11:37:04+03:00
publish: true
---
### Развернем Invidious

```yaml
services:
  invidious:
    build:
      context: .
      dockerfile: docker/Dockerfile.arm64
    restart: unless-stopped
    ports:
      - "127.0.0.1:3000:3000"
      - "192.168.31.36:80:3000"
    environment:
      INVIDIOUS_CONFIG: |
        db:
          dbname: invidious
          user: kemal
          password: kemal
          host: invidious-db
          port: 5432
        check_tables: true
        # external_port:
        # domain:
        # https_only: false
        # statistics_enabled: false
        # popular_enabled: false
        registration_enabled: false
        quality_dash: 1080p
        save_player_pos: true
        local: true
        feed_menu: ["Subscriptions", "Playlists"]
        hmac_key: "goozehaD1Eekaviet1AS"
    healthcheck:
      test: wget -nv --tries=1 --spider http://127.0.0.1:3000/api/v1/trending || exit 1
      interval: 30s
      timeout: 5s
      retries: 2

  invidious-db:
    image: docker.io/library/postgres:14
    restart: unless-stopped
    volumes:
      - postgresdata:/var/lib/postgresql/data
      - ./config/sql:/config/sql
      - ./docker/init-invidious-db.sh:/docker-entrypoint-initdb.d/init-invidious-db.sh
    environment:
      POSTGRES_DB: invidious
      POSTGRES_USER: kemal
      POSTGRES_PASSWORD: kemal
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U $$POSTGRES_USER -d $$POSTGRES_DB"]

volumes:
  postgresdata:

```

Так как я разворачиваю на [[Orange Pi 5]], то использую версию для `arm64`: *Dockerfile.arm64*.

Также я раздаю на `192.168.31.36:80`, чтобы получать доступ из локальной сети.

Подбробнее со всеми настройками можно ознакомиться на: 

[invidious/config/config.example.yml at master · iv-org/invidious · GitHub](https://github.com/iv-org/invidious/blob/master/config/config.example.yml).

### Экспорт данных с Youtube

Данные просмотров и подписок можно получить с [этой страницы](https://takeout.google.com/takeout/custom/youtube).

При экспорте истории просмотров укажите формат **json**.