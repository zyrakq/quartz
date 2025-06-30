---
created: 2024-05-15T20:52:41+03:00
modified: 2025-01-12T02:57:06+03:00
categories:
  - spi
  - orangepi5
  - dd
  - gzip
  - wget
  - md5sum
tags:
  - orangepi5/linux
  - inbox
sr-due: 2025-01-15
sr-interval: 3
sr-ease: 250
publish: true
---
### Очистка старого загрузчика

[Rock5/install/spi - Radxa Wiki](https://wiki.radxa.com/Rock5/install/spi)

```sh
wget https://dl.radxa.com/rock5/sw/images/others/zero.img.gz
```

```sh
gzip -d zero.img.gz
```

Проверяем:

```sh
md5sum zero.img
```

```log
2c7ab85a893283e98c931e9511add182  zero.img
```

Очищаем SPI:

```sh
sudo dd if=zero.img of=/dev/mtdblock0 bs=4K
```

### Установка загрузчика

```sh
sudo dd if=spi-image.img of=/dev/mtdblock0 bs=4K
```