---
created: 2024-05-15T20:52:41+03:00
modified: 2025-01-04T10:37:09+03:00
tags:
  - inbox
  - linux/disks
  - archlinux/disks
categories:
  - fdisk
  - dd
  - disks
sr-due: 2025-01-02
sr-interval: 3
sr-ease: 250
publish: true
---

Получение информации о разбитие дискового пространства:

```sh
sudo fdisk -l
```

Вывод:

```python
Disk /dev/sda: 232,96 GiB, 250139901952 bytes, 488554496 sectors
Disk model: Storage Device  
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: CFFDD678-307A-4744-9501-BE0911940EFA

Device      Start      End  Sectors  Size Type
/dev/sda1      64     1023      960  480K Linux reserved
/dev/sda2    1024     7167     6144    3M Linux reserved
/dev/sda3    8192   532479   524288  256M EFI System
/dev/sda4  532480 58867711 58335232 27,8G Linux root (ARM-64)

```

Обращаем внимание на `Units` диска и на `End` значение раздела до которого мы хотим создать образ (+1).

```sh
sudo dd if=/dev/sda of=/<path>/<image_name>.img bs=512 count=58867712 status=progress conv=fsync 
```

Эта команда по итогу создает образ всего диска.
