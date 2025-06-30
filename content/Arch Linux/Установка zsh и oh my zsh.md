---
tags:
  - inbox
  - archlinux
categories:
  - terminal
  - console
  - zsh
  - zshell
  - oh-my-zsh
created: 2024-05-15T20:52:41+03:00
modified: 2025-04-30T14:19:28+03:00
sr-due: 2025-06-19
sr-interval: 98
sr-ease: 254
publish: true
---
### Настройка

[Настройка Zsh и Oh my Zsh - Losst](https://losst.pro/nastrojka-zsh-i-oh-my-zsh)

```sh
sudo pacman -S zsh git powerline
```

```sh
zsh
```

```sh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
```

Устанавливаем оболочку по умолчанию:

```sh
chsh
```

---

Установка *zsh-syntax-highlighting*:

```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

[zsh-syntax-highlighting/INSTALL.md at master · zsh-users/zsh-syntax-highlighting · GitHub](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)

В случа проблем с цветом автодополнения добавьте в конец файла:

```sh
nano ~/.zshrc
```

```toml title:~/.zshrc
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white,bold'
```

---

Установка *zsh-autosuggestions*:

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

[zsh-autosuggestions/INSTALL.md at master · zsh-users/zsh-autosuggestions · GitHub](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)

---

Добавим плагины и сменим тему:

```sh
nano ~/.zshrc
```

```toml title:~/.zshrc ln:true
ZSH_THEME="agnoster"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white,bold'

plugins=(
  git
  docker
  composer
  sudo
  npm
  zsh-autosuggestions
  dotnet
  pipenv
)
```

---

Проблема: 

```sh
zsh: corrupt history file /home/erritis/.zsh_history
```

Исправить можно:
[How to fix and recover a “corrupt history file” in zsh · GitHub](https://gist.github.com/musale/751cfb132fe6ad05d3a5cc306d72465c)

```sh
fc -R .zsh_history
```