---
tags:
  - inbox
  - archlinux/networks
  - linux/networks
  - network-manager
  - orangepi5/bugs
created: 2025-04-26T13:47:08+03:00
modified: 2025-04-30T09:43:34+03:00
categories:
  - bug
  - orangepi5
  - archlinux
  - linux
  - NetworkManager
  - mac-address
  - ssh
publish: true
sr-due: 2025-04-29
sr-interval: 3
sr-ease: 250
---
### Временная смена MAC адреса

При включении/перезапуске устройства, отключени и повторном включении сети *MAC* адрес обновлялся.

Это мешало подключаться к устройству удаленно, так как каждый раз адрес был другим.

Чтобы исправить это и сделайте *MAC* адрес статическим.

#### Отключите устройство

```sh
sudo ip link set dev <device> down
```

#### Обновите адрес

```sh
sudo ip link set dev <device> address <mac>
```

Например:

```sh
sudo ip link set dev end1 address 0a:ae:19:2d:13:a0
```

#### Включите устройство

```sh
sudo ip link set dev <device> up
```

### Постоянная смена MAC адреса

[[Solved] Network interfaces change places after every reboot. / Networking, Server, and Protection / Arch Linux Forums](https://bbs.archlinux.org/viewtopic.php?id=77079)

[Making sure you're not a bot!](https://wiki.archlinux.org/title/Udev)