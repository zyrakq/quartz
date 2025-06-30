---
tags:
  - inbox
  - linux/networks
  - archlinux/networks
sr-due: 2025-09-17
sr-interval: 307
sr-ease: 310
created: 2024-08-23T20:05:07+03:00
modified: 2024-11-14T21:56:34+03:00
publish: true
categories:
  - ping
---
### Основные команды
#### Проверяем есть ли доступ в интернет

```sh
ping google.com
```

#### Расширенный пинг

```sh ln:true title:ping.sh
#! /bin/bash

HOST_RES=$(host yandex.ru)
PING_RES=$(ping -c4 yandex.ru)
PING_TAIL=$(ping -c4 yandex.ru | tail -n 2)

if [[ $HOST_RES =~ 'yandex.ru has address' ]]; then
 echo "Connection with DNS: SUCCESS"
else
 echo "Something wrong with you internter connection!"
 exit 1
fi

if [[ $PING_RES =~ '0% packet loss' ]]; then
 echo "PING to yandex.ru: SUCCESS"
else

 echo "Something wrong with you internter connection!"
 exit 1
fi

echo "The result of yandex.ru PING:"
echo "$PING_TAIL"
```