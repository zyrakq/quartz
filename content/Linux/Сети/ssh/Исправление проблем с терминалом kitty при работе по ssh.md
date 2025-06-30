---
created: 2024-05-20T11:03:39+03:00
modified: 2025-03-18T18:38:09+03:00
tags:
  - inbox
  - linux/bugs
  - archlinux/bugs
  - manjaro/bugs
  - ubuntu/bugs
categories:
  - bug
  - ssh
  - kitty
sr-due: 2025-01-02
sr-interval: 3
sr-ease: 254
publish: true
---
[Error opening terminal: xterm-kitty. · Issue #4164 · kovidgoyal/kitty · GitHub](https://github.com/kovidgoyal/kitty/issues/4164)

При появлении такой ошибки:

```log
Error opening terminal xterm-kitty
```

Установите соответствующий пакет.

Для **archlinux** и **manjaro**:

```sh
sudo pacman -S kitty-terminfo
```

Для **ubuntu**:

```sh
sudo apt-get -y install kitty-terminfo
```

После повторного подключение по ssh сообщение больше не должно появляться.