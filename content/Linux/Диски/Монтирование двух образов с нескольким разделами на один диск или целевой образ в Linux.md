---
tags:
  - inbox
  - linux/disks
categories:
  - dd
  - mount
  - disks
  - linux
  - gpt
  - orangepi5
created: 2025-01-03T13:11:38+03:00
modified: 2025-02-07T10:51:06+03:00
publish: true
sr-due: 2025-01-07
sr-interval: 3
sr-ease: 250
---
Иногда возникает потребность объединить два образа уже содержащие таблицы gpt. В этом случае удобнее всего будет записать сперва вторичные более крупные разделы, произвести сдвиг, чтобы освободить место под начальные разделы, а после записать в начало пустой области новый образ с разделами. Предварительно сохранив состояние разметы до записи и на основе текущего состояния и прошлого создать новое.

Пример данного подхода был взят: [GitHub - 7Ji/orangepi5-rkloader: Automatical builds of RK bootloader for Orangepi 5 (orignal, B, plus, pro, max, etc)](https://github.com/7Ji/orangepi5-rkloader)
### Подготовка образов для записи на диск

Для примера здесь будет использоваться образ для Orange Pi 5. 

Загрузим образ `ArchLinuxARM-aarch64-OrangePi5-*-rkloader-orangepi_5.img.gz` со страницы [релизов](https://github.com/7Ji/orangepi5-archlinuxarm/releases). В моем случае это `ArchLinuxARM-aarch64-OrangePi5-20250103_025005-rkloader-orangepi_5.img.gz`:

```sh
wget ttps://github.com/7Ji/orangepi5-archlinuxarm/releases/download/nightly/ArchLinuxARM-aarch64-OrangePi5-20250103_025005-rkloader-orangepi_5.img.gz
```

```sh
gunzip -d ArchLinuxARM-aarch64-OrangePi5-20250103_025005-rkloader-orangepi_5.img.gz
```

Для удобства переименуем образ:

```sh
mv ArchLinuxARM-aarch64-OrangePi5-20250103_025005-rkloader-orangepi_5.img armlinux-efi.img
```

Предварительно разобьем его на два отдельных образа:

```sh
sudo sfdisk -d armlinux-efi.img
```

Вывод:

```sh hl:12
label: gpt
label-id: 7AD8C5D3-6887-D049-9B42-91E275EA9916
device: armlinux-efi.img
unit: sectors
first-lba: 34
last-lba: 6291422
sector-size: 512

armlinux-efi.img1 : start=          64, size=         960, type=8DA63339-0007-60C0-C436-083AC8230908, uuid=2A641166-EC97-A84D-98A0-C379AFF7DC55, name="idbloader"
armlinux-efi.img2 : start=        1024, size=        6144, type=8DA63339-0007-60C0-C436-083AC8230908, uuid=6AFFB2E6-C1F9-B14A-889E-2AA091972E1D, name="uboot"
armlinux-efi.img3 : start=        8192, size=     1048576, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B, uuid=799B370E-DD70-A642-A512-F971B25D71EE, name="alarmboot"
armlinux-efi.img4 : start=     1056768, size=     5232640, type=B921B045-1DF0-41C3-AF44-4C6F280D3FAE, uuid=E8B1A96A-E89F-1F44-8A60-584DEDB90356, name="alarmroot"
```

```sh
dd if=armlinux-efi.img of=efi.img bs=1M conv=notrunc,noerror,sync status=progress count=$((1056768/1024))
```

```sh
dd if=armlinux-efi.img of=archlinux.img bs=1M conv=notrunc,noerror,sync status=progress skip=$((1056768/1024))
```

### Обединение образов на одном диске или в другом образе

Подключите диск, если планируете записывать образы на сразу на диск, а не на новый общий образ.

```sh
fdisk -l
```

В моем случае это `/dev/sda`.

```sh
sudo dd if=archlinux.img of=/dev/sda bs=4096 conv=noerror,sync status=progress
```

Если запись производится на общий образ незабудьте добавить `notrunc` в `conv`.

Сохраним текущую таблицу разделов:

```sh
sudo sfdisk -d /dev/sda > old_parts.log 
```

```sh
sudo dd if=efi.img of=/dev/sda bs=4096 conv=noerror,sync status=progress
```

```sh
sudo sfdisk -d /dev/sda > loader_parts.log 
```

Скопируем содержимое `loader_parts.log` в файл `new_parts.log`:

```sh
cp loader_parts.log new_parts.log
```

Откроем файл `old_parts.log`:

```sh
nano old_parts.log
```

```python hl:6,9      
label: gpt
label-id: B135F7CB-D0BC-4D41-AFB8-1BDFE06E2DBD
device: /dev/sda
unit: sectors
first-lba: 34
last-lba: 196593664
sector-size: 512

/dev/sda4 : start=    12290048, size=   184303616, type=B921B045-1DF0-41C3-AF44-4C6F280D3FAE, uuid=169C6DE5-E0B2-5040-9E15-198F783C2794, name="alarmroot"
```

Заменяем в `new_parts.log` строку с `last-lba` на значение из `old_parts.log`.
И копируем разделы из `old_parts.log` в конец `new_parts.log`.

Выходит что то вроде этого:

```python hl:6,12
label: gpt
label-id: B135F7CB-D0BC-4D41-AFB8-1BDFE06E2DBD
device: /dev/sda
unit: sectors
first-lba: 34
last-lba: 196593664
sector-size: 512

/dev/sda1 : start=          64, size=         960, type=8DA63339-0007-60C0-C436-083AC8230908, uuid=64FCF957-F25B-9948-85CE-FB429E67F111, name="idbloader"
/dev/sda2 : start=        1024, size=        6144, type=8DA63339-0007-60C0-C436-083AC8230908, uuid=49A14FA9-D0B1-2748-AFD8-C3F59AA5243B, name="uboot"
/dev/sda3 : start=        8192, size=     1048576, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B, uuid=ACE95478-FC40-2E4A-AD91-9497CBC18EA0, name="alarmboot"
/dev/sda4 : start=    12290048, size=   184303616, type=B921B045-1DF0-41C3-AF44-4C6F280D3FAE, uuid=169C6DE5-E0B2-5040-9E15-198F783C2794, name="alarmroot"
```

Записываем новую таблицу на диск:

```sh
sudo sfdisk /dev/sda < new_parts.log
```
