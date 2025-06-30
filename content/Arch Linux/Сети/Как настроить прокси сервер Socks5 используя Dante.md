---
tags:
  - inbox
  - archlinux/networks
created: 2024-08-31T02:29:09+03:00
modified: 2024-11-23T01:04:16+03:00
sr-due: 2024-11-18
sr-interval: 3
sr-ease: 256
publish: true
categories:
  - dante
  - proxy
  - server
  - archlinux
---
[GitHub - wernight/docker-dante: Dante SOCKS proxy server](https://github.com/wernight/docker-dante)
### Устанавливаем

```sh
pacman -S dante
```

#### Проверяем

```sh
sockd -v
```
### Настраиваем

#### Настраиваем прокси сервер с авторизацией

##### Создаем пользователя для подключения

Если нужно ограничить по логину и паролю, то можно создать пользователя, который не сможет войти в систему, но будет использоваться прокси сервером:

```sh
groupadd dante
```

```sh
useradd -U -G dante -r -s /bin/false dante-user
```

```sh
passwd dante-user
```

А для существующих пользователей группа добавляется:

```sh
sudo usermod -aG dante dante-user
```

[[Шпаргалка по работе с пользователями в Linux]]

Также можно попробовать [[Запуск Dante не из под root пользователя|запустить Dante без использования root пользователя]].
##### Редактируем файл конфигураций

Смотрим наименование интерфейса:

```sh
ip a
```

В моем случае это `end1`.

Прежде чем что то менять, сохраним дефолтные конфигурации:

```sh
mv /etc/sockd.conf /etc/sockd.conf.bak
```

```sh
nano /etc/sockd.conf
```

```ruby title:/etc/sockd.conf fold ln:true
logoutput: /var/log/sockd.log
internal: end1 port = 1080
external: end1
clientmethod: none
socksmethod: username
user.privileged: root
user.notprivileged: nobody

client pass {
        from: 0.0.0.0/0 to: 0.0.0.0/0
        log: error connect disconnect
}
client block {
        from: 0.0.0.0/0 to: 0.0.0.0/0
        log: connect error
}

# you probably don't want people connecting to loopback addresses,
# who knows what could happen then.
socks block {
        from: 0.0.0.0/0 to: lo0
        log: connect error
}

# unless you need it, you could block any bind requests.
socks block {
        from: 0.0.0.0/0 to: 0.0.0.0/0
        command: bind
        log: connect error
}

socks pass {
	from: 0.0.0.0/0 to: 0.0.0.0/0
	udp.portrange: 40000-45000
	log: error connect disconnect
	socksmethod: username
}
socks block {
	from: 0.0.0.0/0 to: 0.0.0.0/0
	log: connect error
}
```

#### Открываем порты

Добавляем разрешения в **iptables**:

```sh
iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 1080 -j ACCEPT
```

```sh
iptables -I INPUT -p udp --dport 40000:45000 -j ACCEPT
```

##### Добавляем на повторную установку после перезагрузки

Войдите в режим суперпользователя, если находитесь под другим пользователем:

```sh
sudo su
```

```sh
iptables-save > /etc/iptables/rules.v4
```
#### Ставим в автозапуск службу и запускаем

```sh
sudo systemctl enable --now sockd
```
##### Проверяем работу сервиса

```sh
systemctl status sockd
```
#### Проверяем проксирование трафика

```sh
curl -x socks5://<your_ip_server>:<your_danted_port> ifconfig.co
```

Если есть какие то проблемы, смотрим логи:

```sh
cat /var/log/sockd.log
```


[centos - Tor & cURL: Can't complete SOCKS5 connection to 0.0.0.0:0 - Stack Overflow](https://stackoverflow.com/questions/11246770/tor-curl-cant-complete-socks5-connection-to-0-0-0-00)
### Ссылки

[sockd(8) — Arch manual pages](https://man.archlinux.org/man/extra/dante/sockd.8.en)

[Dante configuration -- Authentication](https://www.inet.no/dante/doc/latest/config/auth.html)

[Dante in Oracle Cloud – NT KERNEL](https://www.ntkernel.com/dante-in-oracle-cloud/)

[Dante - A free SOCKS server](https://www.inet.no/dante/)