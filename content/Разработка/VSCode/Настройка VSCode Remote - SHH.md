---
created: 2024-05-15T20:52:41+03:00
modified: 2025-03-11T22:34:09+03:00
tags:
  - inbox
  - development/ide/vscode
categories:
  - vscode
  - ssh
  - vscode-remote
  - ssh-agent
sr-due: 2025-02-15
sr-interval: 3
sr-ease: 250
publish: true
---
### Настройка подключения

Чтобы подключиться под правильным пользователем требуется указать дефолтного пользователя при подключении к серверу в `~/.ssh/config`:

Создайте файл, если он еще не создан:

```sh
touch ~/.ssh/config
```

> [!check] 
> Убедитесь что [[Шпаргалка по ssh#Права|права папки и вложенных файлов]] заданы корректно.

```sh
nano ~/.ssh/config
```

```ini title:~/.ssh/config ln:true hl:3,6
Host <ip1>
  HostName <ip2>
  User <username1>
Host <ip2>
  HostName <ip2>
  User <username2>
```

Здесь же можно указать путь к приватному ключу и другие настройки. Но мы опустим [[Шпаргалка по ssh|настройку доступа по SSH]].

Теперь мы можем подключиться, но прежде чем это делать в **VSCode** советую предварительно для проектов [[Настройка VSCode Remote - SHH#Настройка доступа к репозиториям по SSH|настроить подключения к репозиториям]].
### Настройка доступа к репозиториям по SSH

На сервере к которому мы будем подключаться удаленно из нашей *IDE* нам скорее всего потребуется возможность получать изменения из репозитория и отправлять их. Для этого [[Шпаргалка по ssh#Генерация новой пары ключей|сгенерируйте приватный ключ]] и оставьте его в директории `~/.ssh`. Добавьте публичный ключ в настройки своего аккаунта удаленного репозитория.

Произведите настройку одним из следующих способов и после все должно заработать.
#### Настраиваем с ssh-agent

[[Настройка ssh-agent on Arch Linux]]

[[Настройка ssh-agent on Ubuntu]]

#### Настраиваем без ssh-agent

Есл мы работаем в контейнере и не настроили агента на хосте, то `$SSH_AUTH_SOCK` должны определять весь путь до ключей так как `ssh-agent.socket` для **VSCode** может не работать:

```sh
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/keyring/ssh
```

Проверить результат:

```sh
echo $SSH_AUTH_SOCK
```

```log
/run/user/1000/keyring/ssh
```

#### Исправление бага

Если `$SSH_AUTH_SOCK` не был создан до инициализации контейнера *vscode-server*, то в последствии `$SSH_AUTH_SOCK` так и останется пустым.

Если по какой то причине `$SSH_AUTH_SOCK` пуст, то требуется снос контейнера *vscode-server*:

```sh
rm -rf .vscode-server
```

### Исправление проблемы с наличием промежуточного прокси

Ошибка:

```log
Failed to load resource: net::ERR_CONTENT_LENGTH_MISMATCH
```

Решение:

[javascript - Failed to load resource: net::ERR\_CONTENT\_LENGTH\_MISMATCH - Stack Overflow](https://stackoverflow.com/questions/23521839/failed-to-load-resource-neterr-content-length-mismatch)

```sh
nano ~/.config/Code/User/settings.json
```

```json title:~/.config/Code/User/settings.json ln:true hl:3
{
	...
	"remote.SSH.useExecServer": false
}
```

### Связанные материалы

[[Исправление конфликта Azure Data Studio и VSCode]]