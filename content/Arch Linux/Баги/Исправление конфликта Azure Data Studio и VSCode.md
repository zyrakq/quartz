---
created: 2024-08-12T08:12:55+03:00
modified: 2025-02-12T13:24:39+03:00
tags:
  - inbox
  - archlinux/bugs
  - manjaro/bugs
categories:
  - vscode
  - azuredatastudio
  - bug
publish: true
sr-due: 2025-02-15
sr-interval: 3
sr-ease: 250
---
### Установка пакетов

При сборке новой версии vscode или azuredatastudio, если оба приложения установлены или если вы желаете установить оба приложения, нужно предварительно удалить сборочные файлы:

```sh
sudo rm -Rf /usr/lib/debug/.build-id/c1/
```