---
tags:
  - inbox
  - development/rust
categories:
  - rust
  - enum
  - equal
  - eq
  - mem
  - discriminant
created: 2025-02-15T20:29:47+03:00
modified: 2025-02-15T20:37:58+03:00
publish: true
sr-due: 2025-02-18
sr-interval: 3
sr-ease: 250
---
### Сравнение перечислений без трейта Eq

```rust ln:true
use std::mem;

enum Status {
    Loading(u32),
    Ready(String),
    Error,
}

fn is_same_variant(a: &Status, b: &Status) -> bool {
    mem::discriminant(a) == mem::discriminant(b)
}
```

В `enum`, содержащем разные варианты, дискриминант — это внутренний числовой идентификатор (обычно целочисленный), который отличает один вариант от другого.

Функция `mem::discriminant` позволяет сравнивать **типы вариантов** без учёта данных, которые они могут хранить.

```rust ln:true unwrap
use std::mem;

#[derive(Debug)]
enum Status {
    Loading(u32),
    Ready(String),
    Error,
}

fn is_same_variant(a: &Status, b: &Status) -> bool {
    mem::discriminant(a) == mem::discriminant(b)
}

fn main() {
    let s1 = Status::Loading(42);
    let s2 = Status::Loading(100);
    let s3 = Status::Ready("Hello".to_string());
    let s4 = Status::Error;

    println!("{}", is_same_variant(&s1, &s2)); // true (оба Loading)
    println!("{}", is_same_variant(&s1, &s3)); // false (Loading vs Ready)
    println!("{}", is_same_variant(&s3, &s4)); // false (Ready vs Error)
}
```