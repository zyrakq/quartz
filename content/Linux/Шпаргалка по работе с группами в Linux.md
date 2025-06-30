---
tags:
  - inbox
  - linux
  - archlinux
created: 2024-05-15T20:52:41+03:00
modified: 2025-04-21T11:56:26+03:00
categories:
  - groups
  - archlinux
  - linux
publish: true
sr-due: 2024-11-18
sr-interval: 3
sr-ease: 250
---
### Основные команды по работе с группы
#### Получение текущего списка групп

```sh
getent group | awk -F: '{ print $1}'
```
или
```sh
getent group | cut -d: -f1
```

#### Создание группы

```sh
sudo groupadd groupname
```

#### Удаление группы

```sh
groupdel groupname
```

#### Проверка наличия группы

```sh
getent group | grep groupname
```

[How to List Groups in Linux | Linuxize](https://linuxize.com/post/how-to-list-groups-in-linux/)

[How to Delete Group in Linux (groupdel Command) | Linuxize](https://linuxize.com/post/how-to-delete-group-in-linux/#:~:text=the%20command's%20options.-,Deleting%20a%20Group%20in%20Linux,followed%20by%20the%20group%20name.&text=The%20command%20above%20removes%20the,does%20not%20print%20any%20output.)