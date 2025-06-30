---
tags:
  - obsidian
  - inbox
created: 2024-10-23T00:24:10+03:00
modified: 2024-10-24T09:30:48+03:00
publish: true
sr-due: 2024-10-26
sr-interval: 2
sr-ease: 210
---
Перед этим выполните:

[[Настройка публикации заметок в Quartz]]

---

Пример стиля для сайта на Quartz: [be-far's Digital Garden](https://be-far.com/)
### Смена цвета фона

В файле `quartz/styles/custom.scss` добавим другой фон в ночном режиме:

```scss title:custom.scss ln:true hl:3-6
@use "./base.scss";

[saved-theme=dark] code[data-theme*=\ ] {
    color: var(--shiki-dark);
    background-color: #3B4252;
}
```

[Layout](https://quartz.jzhao.xyz/layout)
### Смена основных цветов

В файле `quartz.config.ts` сменис цветовую тему для блоков кода в дневном и ночном режимах:

```ts title:quartz.config.ts ln:true hl:8-9,11,13-14
const config: QuartzConfig = {
  configuration: {
	  colors: {
        lightMode: {
		  ...
        },
        darkMode: {
          light: "#2e3440",
          lightgray: "#70778f",
          gray: "#646464",
          darkgray: "#cdd6f4",
          dark: "#ebebec",
          secondary: "#a6e3a1",
          tertiary: "#89dceb",
          highlight: "rgba(143, 159, 169, 0.15)",
          textHighlight: "#b3aa0288",
        },
      },
      ...
  },
  ...
}
```

[SyntaxHighlighting](https://quartz.jzhao.xyz/plugins/SyntaxHighlighting)

[Themes | Shiki](https://shiki.style/themes) - темы для блоков кода в Quartz
### Смена отображения блоков кода

В файле `quartz.config.ts` давайте сменим цвета в ночном режиме:

```ts title:quartz.config.ts ln:true hl:6-9
const config: QuartzConfig = {
  plugins: {
    transformers: [
	  ...
	  Plugin.SyntaxHighlighting({
        theme: {
          light: "light-plus",
          dark: "dark-plus",
        },
        keepBackground: false,
      }),
	  ...
    ],
  },
}
```

### Смена основных данных сайта

В файле `quartz.config.ts` сменим язык и доменное имя:

```ts title:quartz.config.ts ln:true hl:3-4
const config: QuartzConfig = {
  configuration: {
    locale: "ru-RU",
    baseUrl: "quartz.argiago.ru",
    ...
  },
  ...
}
```

[Configuration](https://quartz.jzhao.xyz/configuration)

[Internationalization](https://quartz.jzhao.xyz/features/i18n)

В файле `quartz.layout.ts` заменим ссылки на наши страницы:

```ts title:quartz.layout.ts ln:true hl:10
import { PageLayout, SharedLayout } from "./quartz/cfg"
import * as Component from "./quartz/components"

export const sharedPageComponents: SharedLayout = {
  head: Component.Head(),
  header: [],
  afterBody: [],
  footer: Component.Footer({
    links: {
      GitHub: "https://github.com/erritis/quartz"
    },
  }),
}
...
```

### Замена заголовка на логотип

#### Создание логотипа

Создаем файл `quartz/components/Logo.tsx` и подставляем содержимое своих **svg** файлов с сохранением **id**:

```tsx title:Logo.tsx ln:true fold
import { pathToRoot } from "../util/path"
import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "./types"
import { classNames } from "../util/lang"

const light = (
  <svg
    id="logo-light"
  ></svg>
)

const dark = (
  <svg
    id="logo-dark"
  ></svg>
)

const Logo: QuartzComponent = ({ fileData, displayClass }: QuartzComponentProps) => {
  const baseDir = pathToRoot(fileData.slug!)
  return (
    <a class={classNames(displayClass, "page-logo")} href={baseDir}>
      {light}
      {dark}
    </a>
  )
}

Logo.css = `
:root[saved-theme="dark"] .page-logo {
  & > #logo-light {
    display: none;
  }
  & > #logo-dark {
    display: inline;
  }
}
:root .page-logo {
  & > #logo-light  {
    display: inline;
  }
  & > #logo-dark  {
    display: none;
  }
}
`

export default (() => Logo) satisfies QuartzComponentConstructor
```

Добавляем в список компонентов в файле `quartz/components/index.ts`:

```ts title:index.ts
import Logo from "./Logo"

export {
  Logo,
  ...
}
```
#### Регистрация компонента

В файле `quartz.layout.ts` заменяем отображение заголовка на логотип:

```ts
Component.PageTitle() -> Component.Logo()
```

```ts title:quartz.layout.ts ln:true hl:6,12
import { PageLayout, SharedLayout } from "./quartz/cfg"
import * as Component from "./quartz/components"

export const defaultContentPageLayout: PageLayout = {
  left: [
    Component.Logo()
  ]
}

export const defaultListPageLayout: PageLayout = {
  left: [
    Component.Logo()
  ]
}
...
```

[Creating your own Quartz components](https://quartz.jzhao.xyz/advanced/creating-components)

### Явная публикация

В файле `quartz.config.ts` добавим явную публикацию:

```ts title:quartz.config.ts ln:true hl:3,7
const config: QuartzConfig = {
  configuration: {
    ignorePatterns: [".obsidian", "!(Media)**/!(*.md)", "!(*.md)"],
    ...
  },
  plugins: {
    filters: [Plugin.ExplicitPublish()],
    ...
  },
  ...
}
```

Теперь только заметки со свойством `publish: true` - будут отображаться в итоговом варианте.

`"!(Media)**/!(*.md)", "!(*.md)"` - Для копирования медиа файлов только из одной конкретной папки. В моем случае это излишне.

[ExplicitPublish](https://quartz.jzhao.xyz/plugins/ExplicitPublish)

[Private Pages](https://quartz.jzhao.xyz/features/private-pages)
### Настройка корректого отображения заметок

В файле `quartz.config.ts` включаем вставки html:

```ts title:quartz.config.ts ln:true hl:5
const config: QuartzConfig = {
  plugins: {
    transformers: [
	  ...
      Plugin.ObsidianFlavoredMarkdown({ enableInHtmlEmbed: true }),
	  ...
    ],
  },
  ...
}
```

### Настройка корневого отображения пути на сайте

В файле `quartz.layout.ts` добавим имя корневого элемента (по умолчанию: <mark style="background: #D2B3FFA6;">Home</mark>):

```ts title:quartz.layout.ts ln:true hl:7-9,18
import { PageLayout, SharedLayout } from "./quartz/cfg"
import * as Component from "./quartz/components"

// components for pages that display a single page (e.g. a single note)
export const defaultContentPageLayout: PageLayout = {
  beforeBody: [
    Component.Breadcrumbs({
      rootName: "Главная"
    }),
    ...
  ],
  ...
}

// components for pages that display lists of pages  (e.g. tags or folders)
export const defaultListPageLayout: PageLayout = {
  beforeBody: [
	  Component.Breadcrumbs({ rootName: "Главная" }),
	  ...
  ],
  ...
}
```

[Breadcrumbs](https://quartz.jzhao.xyz/features/breadcrumbs)
### Оптимизация загрузки

В файле `quartz.config.ts` настроим ленивую загрузку:

```ts title:quartz.config.ts ln:true hl:5
const config: QuartzConfig = {
  plugins: {
    transformers: [
	  ...
      Plugin.CrawlLinks({ markdownLinkResolution: "shortest", lazyLoad: true }),
	...
    ],
  },
  ...
}
```

**lazyLoad**: Если <mark style="background: #FFB8EBA6;">true</mark>, добавляет ленивую загрузку к элементам ресурсов (img, video и т. д.) для повышения производительности загрузки страницы. По умолчанию <mark style="background: #FFB8EBA6;">false</mark>.

[CrawlLinks](https://quartz.jzhao.xyz/plugins/CrawlLinks)

---

Далее можно приступить к [[Развертывание Quartz|настройке развертывания Quartz]].

