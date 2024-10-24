---
tags:
  - inbox
  - ubuntu
cssclasses:
  - clean-embeds
sr-due: 2024-09-17
sr-interval: 18
sr-ease: 294
created: 2024-08-25T03:59:20+03:00
modified: 2024-10-19T11:34:51+03:00
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
%sudo ALL=(ALL) ALL
```

### Создаем пользователя с правами администратора

```sh
groupadd <user>
useradd -m -g <user> -G sudo,users <user>
passwd <user>
```

### Основные команды по работе с пользователями

![[Шпаргалка по работе с пользователями в Linux#Основные команды по работе с пользователями]]
