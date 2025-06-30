---
tags:
  - inbox
  - orangepi5/archlinux
sr-due: 2025-02-19
sr-interval: 109
sr-ease: 270
created: 2024-05-15T20:52:41+03:00
modified: 2024-11-02T19:40:35+03:00
publish: true
categories:
  - orangepi5
  - archlinux
  - uefi
  - spi
---
### UEFI

#### EDK2 UEFI firmware for Rockchip RK3588 platforms

Для установки сразу нескольких ОС с меню входа можно использовать образ: [GitHub - edk2-porting/edk2-rk3588: EDK2 UEFI firmware for Rockchip RK3588 platforms](https://github.com/edk2-porting/edk2-rk3588?tab=readme-ov-file#supported-platforms)

Но он обнаруживает не все ОС, так у меня не был обнаружен образ от 7Ji.

Этот образ можно установить на [[SPI]].

#### Libre Computer

[Libre Computer](https://libre.computer/)

### Установка образа на SPI

Установка на SPI: [Rock5/install/spi - Radxa Wiki](https://wiki.radxa.com/Rock5/install/spi)

### Список сборок

1. [[Установка Arch Linux на Orange Pi 5|Archlinux от 7Ji]]

2. Archlinux от kwankiu
	[Release b05 · kwankiu/archlinux-installer-rock5 · GitHub](https://github.com/kwankiu/archlinux-installer-rock5/releases/tag/b05) - самый последний проект, который я находил и в котором вроде как больше всего правок.
	
	Первое упоминание: [Built an Arch Linux Installer image for the Orange Pi 5 Series, need someone to help with testing as I don't have the board. : r/OrangePI](https://www.reddit.com/r/OrangePI/comments/1atrn4p/built_an_arch_linux_installer_image_for_the/)

1. Archlinux от SputnikRocket
	[GitHub - SputnikRocket/ArchLinuxARM-rk3588-installer: Arch Linux ARM for rk3588 SBCs, such as the Orange Pi 5(+,B), Indiedroid Nova, Radxa Rock 5(A,B), and others. using UEFI.](https://github.com/SputnikRocket/ArchLinuxARM-rk3588-installer) - предыдущий проект ссылается на этот. Должен работать с UEFI.

4. BredOS
	[Home - BredOS](https://bredos.org/)

5. Официальная сборка от Orange PI 5
	[Папка – Google Диск](https://drive.google.com/drive/folders/12JJgtOL7jfszj2vvbbLEEG4TFjV8fg3p?usp=shar)
	
	Недостатки:
	- Проприентарное решение
	- Единственный репозиторий приложений и является официальным от создателей Orange PI 5 (Не работает)


### Дополнительные материалы

Инструкция по развертыванию ОС, которая работает на SD-карте, но не на SSD: [Booting Orange PI 5 from NVMe SSD : r/OrangePI](https://www.reddit.com/r/OrangePI/comments/10838lw/booting_orange_pi_5_from_nvme_ssd/)
