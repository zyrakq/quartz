---
tags:
  - inbox
  - linux/networks/dns
  - archlinux/networks/dns
cssclasses:
  - clean-embeds
sr-due: 2025-04-28
sr-interval: 190
sr-ease: 270
created: 2024-08-10T07:56:32+03:00
modified: 2025-06-30T17:42:19+03:00
publish: true
---
[[Установка systemd-resolved в Arch Linux]]

[[Шпаргалка по systemd-resolved]]

### Настраиваем режим stub

Добавляем в автозапуск **systemd-resolved**:

```sh
systemctl enable systemd-resolved
```

Предварительно отключаем **systemd-resolved**:

```sh
systemctl stop systemd-resolved
```

Создаем символьную ссылку:

```sh
ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
```

 Целевой путь символической ссылки, содержащий `../` в начале, является путём _относительно расположения символической ссылки_, а не относительно текущего рабочего каталога.
 
Файл-заглушка `/run/systemd/resolve/stub-resolv.conf` содержит `127.0.0.53` в качестве единственного DNS-сервера на котором собственно и работает.

Запускаем **systemd-resolved**:

```sh
systemctl start systemd-resolved
```

Проверяем текущие настройки **resolver**:

```sh
resolvectl status
```

#### Включаем DNSSEC

Если кратко, то родительские [[DNS записи]] содержат информацию о дочерних и зоны более высокого уровня могут подтвержать, что данный домен принадлежит данному серверу. Таким образом если [[DNS сервер]] у которого вы получается записи попытается вас обмануть, то эти записи будут отклонены. [[DNSSEC]] не шифрует трафик, только предоставляет доказательство владения доменом указаным ip.

Для Шифрования используется DNSOverTLS (DoT) и DNSOverHTTPS (DoH).

Также стоит заменить dns провайдера на тот, которому мы доверяем.

```sh
nano /etc/systemd/resolved.conf
```

```ini
[Resolve]
DNSSEC=true
```

##### Проверяем

Проверяем работает ли [[DNSSEC]], отправив запрос к домену с неправильной подписью:

```sh
resolvectl query badsig.go.dnscheck.tools
```

```log
badsig.go.dnscheck.tools: resolve call failed: DNSSEC validation failed: invalid
```

Затем проверяем домен, подпись которого в порядке:

```sh
resolvectl query go.dnscheck.tools
```

```log hl:"Data is authenticated: yes"
go.dnscheck.tools: 2604:a880:400:d0::256e:b001 -- link: enp2s0
                   142.93.10.179               -- link: enp2s0

-- Information acquired via protocol DNS in 122.2ms.
-- **Data is authenticated: yes**; Data was acquired via local or encrypted transport: no
-- Data from: network
```

**Data is authenticated** должна вернуться со значением **yes**.

[[Исправление DNSEC signature-expired]]

#### Включаем DNS через TLS

Требуется для того, чтобы провайдер не знал какой домен мы запрашиваем. Это имеем мало смысла, если после мы стучимся к полученному ip адресу. Но при использовании [[VPN]] мы всегда обращаемся к одним и тем же серверам никак не связанным с запрашиваемыми ip адресами и поэтому в этом случае стоит включить [[DNSOverTLS]], чтобы не скопрометировать перед провайдером сайты к которым мы хотим получить доступ.

Разумеется [[VPN]] провайдер или провайдер предоставляющий [[VDS]] для [[VPN]] будет знать к каким сайтам мы обращаемся, но так как [[VPN]] зачастую используется для доступа из за рубежа, то это хорошая защита от слежки со стороны государства.

Без [[DNSSEC]] мы все еще подвержены угрозе недобросовестного dns провайдера.

Также стоит заменить [[DNS]] провайдера на тот, которому мы доверяем.

```sh
nano /etc/systemd/resolved.conf
```

```ini
[Resolve]
DNSOverTLS=yes
```

##### Проверяем

```sh
ngrep port 53
```

Должен ничего не выдавать:

```log
interface: wlo1 (192.168.1.0/255.255.255.0)
filter: ( port 53 ) and ((ip || ip6) || (vlan && (ip || ip6)))
```

Так как DNS over TLS всегда используется порт 853.

```sh
ngrep port 853
```

```log hl:4,5
interface: wlo1 (192.168.1.0/255.255.255.0)
filter: ( port 853 ) and ((ip || ip6) || (vlan && (ip || ip6)))
#
T 192.168.1.2:37570 -> 8.8.8.8:853 [S] #1
...
```

### Ссылки

[Настройка кеширования DNS с помощью systemd-resolved - База знаний РЕД ОС](https://redos.red-soft.ru/base/server-configuring/customize-dns/systemd-resolved/)

[systemd-resolved (Русский) - ArchWiki](https://wiki.archlinux.org/title/Systemd-resolved_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9))