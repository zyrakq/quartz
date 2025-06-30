---
tags:
  - inbox
  - manjaro
  - development/dotnet
created: 2025-03-12T04:57:42+03:00
modified: 2025-04-03T00:15:05+03:00
categories:
  - dotnet
  - aspnet
  - pamac
  - manjaro
sr-due: 2025-05-04
sr-interval: 31
sr-ease: 250
publish: true
---
### Установка

```sh
sudo pamac install dotnet-host-bin dotnet-sdk-bin aspnet-runtime-bin
```

> [!faq] 
> Пакеты `dotnet-runtime-bin`, `dotnet-targeting-pack-bin `, `aspnet-targeting-pack-bin` и `netstandard-targeting-pack-bin` ставятся автоматически. 

Установка конкретной версии *SDK*:

```sh
sudo pamac install dotnet-sdk-8.0-bin aspnet-runtime-8.0-bin
```
### Удаление

```sh
sudo pamac remove -c dotnet-host-bin # all packages
```

### Связанные материалы

[[Установка пакетов Dotnet в Arch Linux]]