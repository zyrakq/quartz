---
tags:
  - inbox
  - orangepi5/manjaro
created: 2024-05-15T20:52:41+03:00
modified: 2024-12-30T06:26:36+03:00
categories:
  - rk3588
  - manjaro
  - arm
  - orangepi5
  - balena
  - hdmi
  - de
sr-due: 2025-01-02
sr-interval: 3
sr-ease: 250
publish: true
---
### Установка

[manjaro-arm-tools](https://gitlab.manjaro.org/manjaro-arm/applications/manjaro-arm-tools) - инструмент для сборки образа из репозитория: [arm-profiles](https://gitlab.manjaro.org/manjaro-arm/applications/arm-profiles). Готовые образы на github по ссылке: [opi5-images](https://github.com/manjaro-arm/opi5-images).

Для прямого записи на флешку есть инструмент: [manjaro-arm-installer](https://gitlab.manjaro.org/manjaro-arm/applications/manjaro-arm-installer).

Записывать желательно через **BalenaEtcher**.

> [!warning] 
>  На данный момент не поддерживается [hdmi](https://github.com/manjaro-arm/opi5-images/issues/5), так как его поддержка не включена в последнее ядро linux используемое для manjaro arm. То есть графическую оболочку (DE) бесполезно ставить. Проверить статус поддержки **RK3588** можно по [ссылке](https://gitlab.collabora.com/hardware-enablement/rockchip-3588/notes-for-rockchip-3588/-/blob/main/mainline-status.md).

Примеры:

[https://forum.pine64.org/showthread.php?tid=12060](https://forum.pine64.org/showthread.php?tid=12060)

[https://forum.radxa.com/t/manjaro-arm-for-rock5b/11603](https://forum.radxa.com/t/manjaro-arm-for-rock5b/11603)

### Похожие материалы

[[Установка Arch Linux на Orange Pi 5]]
