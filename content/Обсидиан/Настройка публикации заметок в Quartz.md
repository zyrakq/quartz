---
tags:
  - inbox
  - obsidian
sr-due: 2024-10-28
sr-interval: 4
sr-ease: 230
modified: 2024-10-24T09:33:03+03:00
created: 2024-08-25T06:23:13+03:00
publish: true
---
### Создание и настройка проекта

Создаем форк:

 [GitHub - jackyzha0/quartz: 🌱 a fast, batteries-included static-site generator that transforms Markdown content into fully functional websites](https://github.com/jackyzha0/quartz)

Клонируем:

```sh
git clone REMOTE-URL
```

В моем случае **REMOTE-URL** - это `git@github.com:zeritiq/quartz.git`

Связываем:

```sh
git remote set-url origin REMOTE-URL
```

Добавляем оригинальный удаленный репозиторий для получения обновлений:

```sh
git remote add upstream https://github.com/jackyzha0/quartz.git
```

Теперь в случае появления обновлений можно выполнить:

```sh
git fetch upstream
```

```sh
git checkout v4
```

```sh
git rebase upstream/v4
```

Это несколько излишне, но я создал ветки **develop** и **master**. И установил локально и в [github](https://github.com/) основной веткой **master**.

Локально:

```sh
git remote set-head origin master
```

В ветке хранятся только изменения по коду и конфигурациям. А в мастере заметки, изменения приходящие с **v4** и мои изменения подтягиваемые из **develop**.

[Setting up your GitHub repository](https://quartz.jzhao.xyz/setting-up-your-GitHub-repository)
### Вытягивание и публикаци заметок

#### Настройка вытягивания заметок

Для вытягивания только тех заметок, что готовы к публикации я написал следующий скрипт:

```sh title:sync.sh ln:true fold
#!/bin/bash

# Source directory path
source_dir="$1"
target_dir="$2"

# Check for missing arguments
if [ -z "$source_dir" ] || [ -z "$target_dir" ]; then
    echo "Please specify paths to source and target directories."
    exit 1
fi

# Function to check metadata of a file
check_metadata() {
    local file="$1"
    local publish=false

    # Read the contents of the file
    content=$(cat "$file")

    # Search for "publish: true"
    if grep -q "publish: true" <<< "$content"; then
        echo "true"
        return 0
    fi

    echo "false"
    return 1
}

# Main loop to find files
find "$source_dir" -type f -name "*.md" | while read -r file; do
    result=$(check_metadata "$file")
    if [ "$result" = "true" ]; then
        relative_path=$(realpath --relative-to="$source_dir" "$file")
        target_path="${target_dir}/${relative_path}"
        mkdir -p "$(dirname "$target_path")"
        cp "$file" "$target_path"
        echo "Copying $file to $target_path"
    else
        echo "Skipping $file"
    fi
done

echo "Copy completed."
```

И добавил его в корень проекта с именем `sync.sh`.

Этот скрипт будет копировать только те заметки в метаданных которых указано свойство `publish: true`.

Далее установите [[Just]].

Добавьте в проект файл `.justfile`:

```ruby
import? 'ext.just'

set dotenv-load

sync:
  rm -Rf ./content
  [ -n $SOURCE_DIR ] && ./sync.sh $SOURCE_DIR ./content
  [ -n $MEDIA_DIR ] && cp -R $MEDIA_DIR ./content/Media

```

А также`ext.just` для последующего расширения списка личных команд.

После чего добавьте в проект `.env`:

```sh
SOURCE_DIR=/home/$USER/Obsidian
MEDIA_DIR=/home/$USER/Obsidian/PublicMedia
```

Где:
`SOURCE_DIR` - папка или подпапка с заметками
`MEDIA_DIR` - папка с файлами используемых для публикации. Стоит отделять публичные файлы от не публичных так как для [[Quartz]] требуется, чтобы файлы фиксировались в [github](https://github.com/).


#### Вытягивание заметок

Выполните из корня проекта (в моем случае в ветке **master**):

```sh
just sync
```

Зафиксируйте изменения:

```sh
npx quartz sync
```

#### Публикация

```sh
git push
```

---

Далее можно приступить к [[Кастомизация Quartz|кастомизации Quartz]] и к [[Развертывание Quartz|настройке развертывания Quartz]].

---
### Ссылки

[Obsidian — Notion свободного человека / Хабр](https://habr.com/ru/companies/ozonbank/articles/838990/)