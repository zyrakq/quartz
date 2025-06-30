---
tags:
  - inbox
  - archlinux/networks/dns
sr-due: 2024-10-29
sr-interval: 9
sr-ease: 230
created: 2024-08-25T11:23:38+03:00
modified: 2025-06-30T16:21:12+03:00
publish: true
---
### Устанавливаем systemd-resolved

```sh
pacman -S systemd-resolved systemd-resolvconf ngrep
```

**systemd-resolvconf** - требуется  при наличии [[NetworkManager]] или другого [сетевого менеджера](https://wiki.archlinux.org/title/Network_configuration_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)#%D0%A1%D0%B5%D1%82%D0%B5%D0%B2%D1%8B%D0%B5_%D0%BC%D0%B5%D0%BD%D0%B5%D0%B4%D0%B6%D0%B5%D1%80%D1%8B) .

Это создает сивольную ссылку `/usr/bin/resolvconf` в которые будут отправляться пользовательские настройки [[Сетевой менеджер|сетевого менеджера]].

**ngrep** - для проверки правильной работы [[DNS клиент|dns клиента]].

[[Шпаргалка по systemd-resolved]]

[[Переключение systemd-resolved в режим stub]]

