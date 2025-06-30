---
tags:
  - inbox
  - development/rust
categories:
  - rust
  - cargo
  - config.toml
  - toml
created: 2025-02-05T21:38:16+03:00
modified: 2025-02-06T22:40:42+03:00
publish: true
sr-due: 2025-02-08
sr-interval: 3
sr-ease: 250
---
### Смена директории пакетов проекта

[Configuration - The Cargo Book](https://doc.rust-lang.org/cargo/reference/config.html)

В `.cargo/config.toml` можно указать директорию сборки проекта:

```toml title:.cargo/config.toml ln:true
[build]
target-dir = "target"
```