---
created: 2024-05-15T20:52:41+03:00
modified: 2025-05-26T11:22:29+03:00
tags:
  - inbox
  - linux/networks
  - archlinux/networks
categories:
  - ssh
  - sshd
  - ssh-keygen
sr-due: 2025-01-01
sr-interval: 3
sr-ease: 254
publish: true
---
### Права

```sh
chmod 700 ~/.ssh && \
chmod 600 ~/.ssh/* && \
chmod 644 -f ~/.ssh/*.pub ~/.ssh/authorized_keys ~/.ssh/known_hosts ~/.ssh/config
```

или

```sh
# Fix directory permissions
chmod 700 ~/.ssh

# Fix all key permissions
chmod 600 ~/.ssh/*
chmod 644 ~/.ssh/*.pub

# Fix special files permissions
chmod 644 ~/.ssh/authorized_keys
chmod 644 ~/.ssh/known_hosts
chmod 644 ~/.ssh/config
```

```sh
chown username:usergroup ~/.ssh
chown username:usergroup ~/.ssh/*
```

### Генерация новой пары ключей

```sh
ssh-keygen -t ed25519 -C <device_name>
```

### Добавление ключа на сервер

Заходим на сервер.

Создаем файл `~/.ssh/authorized_keys`:

```sh
mkdir ~/.ssh
```

```sh
touch ~/.ssh/authorized_keys
```

```sh
chmod 700 ~/.ssh && \
chmod 600 ~/.ssh/* && \
chmod 644 ~/.ssh/authorized_keys
```

Добавляем публичный ключ:

```sh
nano ~/.ssh/authorized_keys
```

### Отключение аутентификации по паролю

```sh
sudo nano /etc/ssh/sshd_config
```

```ini title:sshd_config ln:true hl:2
# To disable tunneled clear text passwords, change to no here!
PasswordAuthentication no
#PermitEmptyPasswords no
```

```sh
sudo systemctl restart sshd
```

### Связанные материалы

[[Настройка VSCode Remote - SHH]]
