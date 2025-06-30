---
tags:
  - inbox
  - browsers/chromium/extensions
  - proxies/clients
categories:
  - proxy
  - browser
  - chromium
created: 2024-10-30T14:23:07+03:00
modified: 2024-11-02T19:19:46+03:00
publish: true
sr-due: 2024-11-04
sr-interval: 10
sr-ease: 250
---
У вас должен быть прокси-сервер через который мы будем проксировать трафик до разных сайтов. Можно найти бесплатные, купить или настроить свой.

Здесь перечислены статьи по настройки своих прокси-серверов:

[[Настройка cloudfire warp vpn клиента как прокси-сервер в docker]]

[[Настройка wireguard vpn клиента как прокси-сервер в docker]]
### Настройка

Расширение: [GitHub - FelisCatus/SwitchyOmega: Manage and switch between multiple proxies quickly & easily.](https://github.com/FelisCatus/SwitchyOmega)

Заполняем новый профиль данными настроенного прокси сервера:

![[Pasted image 20241102170135.png]]

В моем случае он развернут в docker и раздается на `localhost:6543`. Если в вашем прокси используется авторизация, то  в блоке Server укажите`user:password@localhost`.

Далее переключите плагин в режим **auth switch**:

![[Pasted image 20241102170803.png]]

Теперь при заходе на сайт в этом режиме будет отображаться счетчик с ресурсами (доменами откуда подгружается контент для этого сайта) и при нажатии на значок плагина будет кнопка с соответствующим текстом как на картинке: "6 failed resources". При нажатии на которую можно будет добавить эти ресурсы в список сайтов работающих через настроенный вами профиль (в моем случае это **proxy**):

![[Pasted image 20241102171333.png]]

Теперь сайт в этом браузере будет доступен только через указанный вамии прокси.
### Альтернативные расширения

[GitHub - zero-peak/ZeroOmega: Manage and switch between multiple proxies quickly & easily.](https://github.com/zero-peak/ZeroOmega)

[GitHub - rNeomy/proxy-switcher: Modify Firefox's Proxy Settings from a Toolbar Panel](https://github.com/rNeomy/proxy-switcher/)