---
tags:
  - inbox
  - archlinux
  - development/dotnet
created: 2025-03-12T04:57:42+03:00
modified: 2025-04-03T05:01:23+03:00
categories:
  - dotnet
  - aspnet
  - yay
  - archlinux
sr-due: 2025-05-03
sr-interval: 30
sr-ease: 250
publish: true
---
### Установка

```sh
yay -S dotnet-host-bin dotnet-sdk-bin aspnet-runtime-bin
```

> [!faq] 
> Пакеты `dotnet-runtime-bin`, `dotnet-targeting-pack-bin `, `aspnet-targeting-pack-bin` и `netstandard-targeting-pack-bin` ставятся автоматически. 

Установка конкретной версии *SDK*:

```sh
yay -S dotnet-sdk-8.0-bin aspnet-runtime-8.0-bin
```

### Удаление

```sh
yay -Rc dotnet-host-bin # all packages
```

### Связанные материалы

[[Установка пакетов Dotnet в Manjaro]]