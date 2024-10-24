---
tags:
  - inbox
  - archlinux
cssclasses:
  - clean-embeds
sr-due: 2024-09-19
sr-interval: 20
sr-ease: 294
created: 2024-08-25T03:58:21+03:00
modified: 2024-10-19T11:39:58+03:00
publish: true
---
### Добавляем группу sudo

```sh
EDITOR=nano visudo
```

или

```sh
nano /etc/sudoers
```

Снимаем решетку со строки:

```
%wheel ALL=(ALL) ALL
```

### Создаем пользователя с правами администратора

```sh
groupadd <user>
useradd -m -g <user> -G wheel,users <user>
passwd <user>
```

#### Создаем папку пользователя

Если до этого папка пользователя не была создана, например при создании пользователя забыли добавить атрибут `-m`, то папку также можно создать используя команду:

```sh
mkhomedir_helper <user>
```

### Основные команды по работе с пользователями

![[Шпаргалка по работе с пользователями в Linux#Основные команды по работе с пользователями]]
