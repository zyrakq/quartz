---
tags:
  - inbox
  - linux
  - archlinux
sr-due: 2025-06-03
sr-interval: 226
sr-ease: 310
publish: true
created: 2024-05-15T20:52:41+03:00
modified: 2024-10-20T11:31:09+03:00
---
### Основные команды по работе с пользователями

#### Получием текущий список пользователей

```sh
getent passwd | awk -F: '{ print $1}'
```
или
```sh
getent passwd | cut -d: -f1
```

#### Получаем текущую информацию о пользователе

```sh
id <user>
```

#### Создаем пользователя

```sh
groupadd <user>
useradd -m -g <user> -G <groups> <user>
passwd <user>
```

#### Добавляем пользователя в группу уже после создания пользователя

```sh
usermod -a -G <group> <user>
```

#### Создаем папки пользователя, если до этого она не была создана

```sh
mkhomedir_helper <user>
```


#### Удаляем пользователя

```sh
userdel <user>
```

С папкой:

```sh
userdel -r <user>
```

Предварительное завершение всех процессов:

```sh
killall -u <user>
```

#### Проверяем наличие пользователя

```sh
getent passwd | grep <user>
```


### Ссылки

[How to Create Users in Linux (useradd Command) | Linuxize](https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/)

[How to List Users in Linux | Linuxize](https://linuxize.com/post/how-to-list-users-in-linux/)

[Fetching Title#26rn](https://linuxize.com/post/how-to-delete-users-in-linux-using-the-userdel-command/)