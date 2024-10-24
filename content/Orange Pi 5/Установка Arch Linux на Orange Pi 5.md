---
tags:
  - inbox
  - orangepi5/archlinux
sr-due: 2025-05-19
sr-interval: 211
sr-ease: 290
created: 2024-08-02T21:42:07+03:00
modified: 2024-10-20T11:30:27+03:00
publish: true
---

### Установка

[GitHub - 7Ji/orangepi5-archlinuxarm: ArchLinuxARM for OrangePi 5 / 5B / 5 plus with vendor kernel](https://github.com/7Ji/orangepi5-archlinuxarm)

Записываем образ 5.img с помощью [[BalenaEtcher]] на будущий носитель OS

Можем удалить первые три раздела на носителе с OS

Увеличиваем объем основного диска и создаем дополнительный раздел home. Копируем uuid раздела home.

Монтируем OS:

```sh
mount /dev/<device> /mnt
```

```sh
sudo mv /mnt/home /mnt/home_old
sudo mkdir /mnt/home
sudo nano /mnt/etc/fstab
```

```
UUID=<uuid> /home ext4 rw,noatime 0 2
```

```sh
mount /dev/<device> /mnt/home
sudo mv /mnt/home_old/* /mnt/home/
sudo rm -Rf /mnt/home_old
umount -R /mnt
```

Записываем с помощью [[BalenaEtcher]] образ 5.img на загрузочный флеш накопитель и удаляем последний раздел с OS

- [[Шпаргалка по работе с пользователями в Linux|Cоздайте пользователя]]
- [[Исправление проблем с терминалом kitty при работе по ssh|Если пользуетесь kitty, установите пакет исправляющий баг дублирования текста]]
- [[SSH|Настройте удаленный доступ по ssh]]

Переименовать устройство:

```sh
sudo nano /etc/hostname
```

Установите часовой пояс:

```sh
sudo ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
```

Установите местную кодировку:

```sh
sudo nano /etc/locale.gen
```

```sh
sudo locale-gen
```

Синхронизируйте время:

```sh
sudo hwclock --systohc
```

Проверьте:

```sh
timedatectl
```

- [[Установка zsh и oh my zsh|Устанавливаем zsh и oh my zsh]]
- [[Настройка ssh-agent on Arch Linux|Настройте ssh-agent]]
- [[VSCode SSH Remote|Настройте VSCode Server]]
- [[Шпаргалка по yay|Установите yay]]

### Исправляем возможные проблемы

[[Исправление прерывания ssh-туннеля в Linux]]

[[Как исправить проблему с Hyprland для Orange Pi 5]]

[[Как настроить кодеки для Orange Pi 5 на Arch Linux]]

### Ссылки

Также могут пригодиться ссылки на другия связанные репозитории для будущей доработке инструкции:

[GitHub - 7Ji/orangepi5-rkloader: Automatical builds of RK bootloader for Orangepi 5 / 5B / 5 plus](https://github.com/7Ji/orangepi5-rkloader) - лоадер ОС.

[GitHub - 7Ji/archrepo: A pacman repo focusing on Arch as media center, for ArchLinux on x86\_64 and ArchLinux ARM on aarch64, updated hourly](https://github.com/7Ji/archrepo) - репозиторий с пакетами для arm от автора. Уже стоит в этом образе.

[GitHub - 7Ji/arch\_repo\_builder: A naive Arch repo builder, for AUR-like packages](https://github.com/7Ji/arch_repo_builder) - решение для создания своего репозитория.

