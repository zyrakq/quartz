---
tags:
  - inbox
  - linux/bugs
created: 2024-05-15T20:52:41+03:00
modified: 2025-02-12T12:26:54+03:00
categories:
  - bug
  - mkinitcpio
  - i915
  - xset
  - dpms
  - screen-flickering
publish: true
sr-due: 2025-02-15
sr-interval: 3
sr-ease: 250
---
### Возможная причина и способы решения проблемы

```sh
 sudo gedit /etc/mkinitcpio.conf
```

Добавляем `i915` в переменную `MODULES`.

```sh
sudo mkinitcpio -P
```

---

Еще возможно поможет: 

```sh
xset dpms force off
```

### Ссылки

[Debian 10. «Моргание экрана» после загрузки рабочего стола. — Desktop — Форум](https://www.linux.org.ru/forum/desktop/15389265)