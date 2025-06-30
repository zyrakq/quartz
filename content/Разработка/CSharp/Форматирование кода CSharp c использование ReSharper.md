---
tags:
  - inbox
  - development/dotnet/scharp
created: 2024-12-17T23:39:16+03:00
modified: 2025-02-12T14:40:14+03:00
sr-due: 2025-04-29
sr-interval: 76
sr-ease: 250
categories:
  - csharp
  - formatting
  - git
  - cleanupcode
  - jb
  - jetbrains
  - resharper
  - editorconfig
publish: true
---
[ReSharper command line tools | JetBrains Rider Documentation](https://www.jetbrains.com/help/rider/ReSharper_Command_Line_Tools.html#install-and-use-resharper-command-line-tools-as-net-core-tools)

### Установка

Arch:

```sh
yay -S jetbrains-resharper-commandlinetools
```

Manjaro:

```sh
pamac install jetbrains-resharper-commandlinetools
```

Other:

```sh
dotnet tool install -g JetBrains.ReSharper.GlobalTools
```

В этом случае команда начинается c префикса `jb`:

```sh
jb cleanupcode -h
```
### Форматирование

`cleanupcode` учитывает конфигурации в файле `.editorconfig`, поэтому, если что то не устраиваем, велика вероятность, что это можно настроить через `.editorconfig`.

---

Можно вызвать форматирование для всего решения:

```sh
cleanupcode solution.sln
```

---

Я сделал простой скрипт для применения форматирования только к файлам, которые еще не были закоммичены в git.

Создаем файл:

```sh
touch cleanupcode.sh
```

Редактируем:

```sh
nano ./cleanupcode.sh
```

```sh title:cleanupcode.sh ln:true
#!/bin/bash

# Проверяем наличие Git
if ! command -v git &> /dev/null; then
    echo "Git не установлен. Пожалуйста, установите Git и повторите попытку."
    exit 1
fi


# Проверяем наличие CleanupCode
if ! command -v cleanupcode &> /dev/null; then
    echo "CleanupCode не установлен. Пожалуйста, установите CleanupCode и повторите попытку."
    exit 1
fi

# Получаем список измененных, но не закоммиченных файлов
uncommitted_changes=$(git diff --name-only --cached)

# Если найдены несохраненные изменения
if [ -n "$uncommitted_changes" ]; then
    echo "Обработка несохраненных изменений:"
    echo "$uncommitted_changes"
    
    # Создаем команду для запуска CleanUpCode для всех измененных файлов
    cleanup_command="cleanupcode $(echo $uncommitted_changes | tr '\n' ' ')"

    echo "Выполняется команда:"
    echo "$cleanup_command"
    
    # Выполняем команду
    eval "$cleanup_command"
    
    echo "Обработка завершена."
else
    echo "Нет несохраненных изменений для обработки."
fi
```

Делаем файл исполняемым:

```sh
chmod +x cleanupcode.sh

```

Запускаем:

```sh
./cleanupcode.sh
```