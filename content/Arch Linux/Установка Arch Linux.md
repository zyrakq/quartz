---
tags:
  - inbox
  - archlinux
sr-due: 2025-05-12
sr-interval: 204
sr-ease: 270
cssclasses:
  - clean-embeds
created: 2024-05-15T20:52:41+03:00
modified: 2024-12-07T18:14:37+03:00
publish: true
categories:
  - archlinux
---
[[Шпаргалка по Pacman]]
## Установка

Проверим доступ в интернет:

```sh
ping google.com
```

Можно настроить кабельный интернет или же подключиться к wifi.
#### Настроим кабельного интернета

Выполняем команду:

```sh
dhcpcd
```

Подключаем кабель к смартфону и компьютеру и раздаем интернет по кабелю, после чего повторяем проверку наличия интернета.

#### Настроим подключение к wifi

![[Настройка wifi на Linux с iwctl]]
### Выбираем диск для установки OS

Давайте посмотрим какие диски есть в системе:

```sh
fdisk -l
```

Запомним название нужного нам диска. У меня это `/dev/nvme0n1`.

***

### Создаем таблицу GPT

***Этот шаг можно пропустить, если нужные разделы уже существуют***

Если мы устанавливаем все с нуля, нам нужно задать таблицу разделов gpt:

```sh
fdisk <путь_до_диска>
```

Если на диске уже есть разделы их можно удалить командой `d`. С выбором номеров разделов.

После введите `g` - для выбора gpt и `m` для выхода.
***

### Создаем разделы в таблице

***Этот шаг можно пропустить, если нужные разделы уже существуют***

Давайте произведем разбивку разделов:

```sh
cfdisk <путь_до_диска>
```

Раздел размером *31M* с типом `BIOS boot`. (мне это не потребовалось)

Раздел размером *1G* с типом `EFI System`

Раздел размером *8G* с типом `Swap`. (лучше создать после в виде [[Настройка swap раздела с использованием swapfile|файла]], а не в виде раздела)

Раздел размером *100G* с типом `Linux filesystem` для хранение пользователей.

Раздел размером *100G* с типом `Linux filesystem` для ОС.

Жмем *Write*, после подтверждаем и жмем *Quit*.

Снова смотрим разделы на нашем диске:

```sh
fdisk -l
```

***

### Форматируем разделы

Давайте отформатируем нужные разделы.

EFI:

```sh
mkfs.vfat <путь_до_раздела>
```

Swap (если есть):

```sh
mkswap <путь_до_раздела>
```

```sh
swapon <путь_до_раздела>
```

Основной раздел и раздел Home:

В формате btrfs:

```sh
mkfs.btrfs <путь_до_раздела>
```

Если появляется ошибка, то это скорее всего остались какие то данные до форматирования и в таком случае добавьте ключ `-f`:

```sh
mkfs.btrfs -f <путь_до_раздела>
```

В формате ext4:

```sh
mkfs.ext4 <путь_до_раздела>
```

### Монтируем разделы

```sh
mount <путь_до_корневого_раздела> /mnt
```

```sh
mkdir /mnt/boot
```

```sh
mkdir /mnt/boot/EFI
```

```sh
mount <путь_до_efi_раздела> /mnt/boot/EFI
```

```sh
mkdir /mnt/home
```

```sh
mount <путь_до_домашнего_раздела> /mnt/home
```

### Устанавливаем Arch Linux

```sh
pacstrap -i /mnt base base-devel linux-zen linux-lts linux-zen-headers linux-lts-headers linux-firmware dosfstools intel-ucode iucode-tool nano
```

Для btrfs также добавьте пакет `btrfs-progs`

Если процессор amd, то вместо `intel-ucode` и `iucode-tool` используйте `amd-ucode`

Создаем файл конфигурации нашего диска:

```sh
genfstab -U /mnt >> /mnt/etc/fstab
```

Проверяем содержимое этого файла командой:

```sh
cat /mnt/etc/fstab
```

### Предварительно настраиваем систему

#### Подключаемся к файловой системе OS

```sh
arch-chroot /mnt
```

#### Устанавливаем часовой пояс

```sh
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
```

Синхронизируем время:

```sh
hwclock --systohc
```

Проверяем:

```sh
timedatectl
```

#### Установливаем местную кодировку и язык в системе

```sh
nano /etc/locale.gen
```

Убираем решетку с `en_US.UTF-8` и `ru_RU.UTF-8`

```sh
locale-gen
```

```sh
nano /etc/locale.conf
```

```
LANG=en_US.UTF-8
```

```sh
nano /etc/vconsole.conf
```

```
KEYMAP=ru
FONT=cyr-sun16
```

#### Устанавливаем имя компьютера

```sh
nano /etc/hostname
```

Пишем имя компьютера, как пример:

```
user-dhgh53454
```

Обязательно в нижнем регистре (мое личное требование) и без каких либо символов и пробелов.

```sh
nano /etc/hosts
```

```
127.0.0.1 localhost
::1       localhost
127.0.0.1 user-dhgh53454.localdomain user-dhgh53454
```

Устанавливаем пароль для root пользователя:

```sh
passwd
```

#### Настраиваем загрузку

##### Собираем ядро

Если при загрузке было указано только одно ядро:

```sh
mkinitcpio -P
```

Если при загрузке было указано два ядра:

```sh
mkinitcpio -p <linux-zen или linux-lts>
```

##### Настраиваем загрузчик

Скачиваем загрузчик и утилиты по работе с сетями:

```sh
pacman -S grub efibootmgr dhcpcd dhclient networkmanager
```

Установка загрузчика:

```sh
grub-install <путь_до_диска> 
```

Если не сработало, то можно попробовать:

```sh
grub-install <путь_до_диска> --boot-directory=/boot/EFI
```

```sh
grub-mkconfig -o /boot/grub/grub.cfg
```

```sh
exit
```

```sh
umount -R /mnt
```

Перезагружаем систему:

```sh
reboot
```

### Настраиваем систему

Заходим из под root и выполняем следующие действия:

![[Шпаргалка по работе с пользователями в Arch Linux#Добавляем группу sudo]]

Выполняем без sudo и в группы пользователя добавляем **wheel**:

![[Шпаргалка по работе с пользователями в Linux#Создаем пользователя]]

Выходим из под root:

```sh
exit
```

Логинимся под созданным пользователем.

```sh
sudo systemctl enable NetworkManager
```

Перезагружаем систему:

```sh
sudo reboot
```

```sh
ping google.com
```

![[Шпаргалка по nmcli#Подключаемся к сети wifi]]

##### Добавляем multilib

```sh
nano /etc/pacman.conf
```

Убираем решетку со строки с *Include* для `multilib`.

***

#### Устанавливаем графическую оболочку
##### Устанавливаем драйвера для видеокарты

[[Настройка драйверов для встроенной графики Intel на Arch Linux]]

[[Настройка драйверов для дискретной графики nvidia на Arch Linux]]

[[Настройка драйверов для дискретной графики amd на Arch Linux]]

##### Устанавливаем графический интерфейс для сетей

```sh
sudo pacman -S network-manager-applet
```

##### Перезагружаем систему

```sh
sudo reboot
```

##### Устанавливаем plasma

```sh
sudo pacman -S xorg xorg-server plasma plasma-wayland-session kde-applications sddm sddm-kcm packagekit-qt5
```

```sh
sudo systemctl enable sddm
```

#### Добавляем модули для файловой системы btrfs

```sh
sudo nano /etc/mkinitcpio.conf
```

Добавляем `crc32c licrc32c zlib_deflate btrfs` для лучшей работы btrfs.

Добавляем `nvidia nvidia_modeset nvidia_uvm nvidia_drm` для пользования всеми возможностями nvidia.

```
MODULES=(crc32c licrc32c zlib_deflate btrfs nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```

##### Пересобираем ядро

![[Установка Arch Linux#Собираем ядро]]

#### Дополнительные настройки

##### Устанавливаем yay

![[Шпаргалка по yay#Установка]]
### Ссылки

[Installation guide (Русский) - ArchWiki](https://wiki.archlinux.org/title/Installation_guide_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9))

[Как установить Arch с минимальной болью? / Хабр](https://habr.com/ru/articles/510158/)

[Arch Linux install 2021 | Установка Arch Linux 2021 подробный гайд - YouTube](https://www.youtube.com/watch?v=aMnaM7llZhM)

