---
tags:
  - inbox
  - orangepi5/archlinux
created: 2024-09-15T22:00:06+03:00
modified: 2025-03-02T00:07:24+03:00
categories:
  - archlinux
  - orangepi5
  - boot
  - extlinux
  - rk3588
sr-due: 2024-11-18
sr-interval: 3
sr-ease: 250
publish: true
---
### Смена ядра при старте системы

Иногда нам может потребоваться сменить ядро запускаемое при старте системы на одно из предустоновленных.

Чтобы это сделать отредактируйте файл `/boot/extlinux/extlinux.conf`:

```sh
nano /boot/extlinux/extlinux.conf
```

```ini title:/boot/extlinux/extlinux.conf ln:true hl:3,4,10 unwrap
MENU TITLE Select the kernel to boot
TIMEOUT 30
DEFAULT linux-aarch64-rockchip-rk3588-bsp5.10-orangepi-git
LABEL   linux-aarch64-rockchip-rk3588-bsp5.10-orangepi-git
        LINUX   /vmlinuz-linux-aarch64-rockchip-rk3588-bsp5.10-orangepi-git
        INITRD  /booster-linux-aarch64-rockchip-rk3588-bsp5.10-orangepi-git.img
        #FDTDIR /dtbs/linux-aarch64-rockchip-rk3588-bsp5.10-orangepi-git
        FDT     /dtbs/linux-aarch64-rockchip-rk3588-bsp5.10-orangepi-git/rockchip/rk3588s-orangepi-5.dtb
        APPEND  root=UUID=3eb11c5e-a874-4494-97d0-88711fbb1cc6 rw
LABEL   linux-aarch64-rockchip-bsp6.1-joshua-git
        LINUX   /vmlinuz-linux-aarch64-rockchip-bsp6.1-joshua-git
        INITRD  /booster-linux-aarch64-rockchip-bsp6.1-joshua-git.img
        #FDTDIR /dtbs/linux-aarch64-rockchip-bsp6.1-joshua-git
        FDT     /dtbs/linux-aarch64-rockchip-bsp6.1-joshua-git/rockchip/rk3588s-orangepi-5.dtb
        APPEND  root=UUID=3eb11c5e-a874-4494-97d0-88711fbb1cc6 rw
```

Вы можете заменить значение *DEFAULT* на одно из значений *LABEL*.
В этом примере значение `linux-aarch64-rockchip-rk3588-bsp5.10-orangepi-git` можно заменить на `linux-aarch64-rockchip-bsp6.1-joshua-git`.