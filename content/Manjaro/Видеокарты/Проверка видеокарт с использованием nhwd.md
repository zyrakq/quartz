---
created: 2024-05-15T20:52:41+03:00
modified: 2024-12-30T02:18:33+03:00
tags:
  - inbox
  - manjaro/videocards
categories:
  - manjaro
  - videocards
  - videodrivers
  - mhwd
  - pci
publish: true
sr-due: 2025-01-02
sr-interval: 3
sr-ease: 250
---
[[Проверка наличия видеокарт и драйверов к ним]]

Определение установленных драйверов:

```sh
mhwd --listinstalled
```

Списки доступных драйверов для устройств:

```sh
mhwd --usb -l
```

```sh
mhwd --pci -l
```

[Настройка видеокарт - Manjaro](https://wiki.manjaro.org/index.php/Configure_Graphics_Cards/ru)
