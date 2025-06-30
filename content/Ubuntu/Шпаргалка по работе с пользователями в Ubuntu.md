---
tags:
  - inbox
  - ubuntu
cssclasses:
  - clean-embeds
sr-due: 2025-09-20
sr-interval: 310
sr-ease: 314
created: 2024-08-25T03:59:20+03:00
modified: 2024-11-20T17:22:04+03:00
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
