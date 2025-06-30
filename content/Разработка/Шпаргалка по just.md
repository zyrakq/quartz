---
tags:
  - inbox
  - development
created: 2024-10-22T04:42:24+03:00
modified: 2025-01-10T11:10:03+03:00
sr-due: 2025-01-13
sr-interval: 3
sr-ease: 250
categories:
  - just
  - rust
  - linux
  - kubernetes
  - dotnet
  - nuget
publish: true
---

### Расширение списка команд

Добавьте пустой файл `ext.just`. Этот файл с расширенным списком команд.

Для того, чтобы добавляемые вами команды распозновались, добавьте в начало файла`.justfile`:

```cpp title:.justfile
import? 'ext.just'
```

> [!warning] 
> Обратите внимание, что не все версии just поддерживают **import**. Убедитесь, что поставили самую свежую версию. 

В случае проекта с несколькими разработчиками полезно держать такой файл, чтобы каждый мог расширить свой личный список команд. Но так как они предназначены только для вас, то они не должны попасть в git, поэтому добавьте файл в `.gitignore`:

```.gitignore title:.gitignore hl:2
...
ext.just
```
### Примеры

#### Kubernetes

```r title:.justfile ln:true
import? 'ext.just'

_k8s-convert:
  rm ./.helm/templates/*.yaml;
  kompose convert -f docker-compose.k8s.yml -o ./.helm/templates;
  rm ./.helm/templates/*persistentvolumeclaim.yaml;
  find ./.helm/templates -type f -exec sed -i "s/'{{{{ \(.*\) }}'/{{{{ \1 }}/g" {} +;
  find ./.helm/templates -type f -exec sed -i "s/\.values/\.Values/g" {} +;
  find ./.helm/templates -type f -exec sed -i '/hostPort/d' {} +;


up: _k8s-convert
  kubectl create namespace skud &>/dev/null || exit 0;
  kubectl config set-context --current --namespace=skud;
  kubectl apply -Rf './.helm/templates/*';

down:
  kubectl config set-context --current --namespace=skud;
  kubectl delete -Rf './.helm/templates/*';

k8s +args:
  just _k8s-{{args}}
```


#### Nuget

```cpp title:.justfile ln:true
import? 'ext.just'

_nuget-clear:
  dotnet nuget locals --clear all

nuget *args:
  just _nuget-{{args}}
```

#### Dotnet

```cpp title:.justfile ln:true
import? 'ext.just'

_migrations-add *name:
  dotnet ef migrations add {{name}} \
  -p ./SamokatHrSyncer.Database \
  -s ./SamokatHrSyncer.App \
  --context SyncerDbContext -- --environment Development

_migrations-remove:
  dotnet ef migrations remove \
  -p ./SamokatHrSyncer.Database \
  -s ./SamokatHrSyncer.App \
  --context SyncerDbContext -- --environment Development

migrations *args:
  just _migrations-{{args}}
```

#### Linux

Завершение процесса занимающего порт **7180**. Полезно когда проект иногда не завершается, ты знаешь какой порт занимает проект и требуется принудительно завершить его выполнение.

```cpp title:.justfile ln:true
import? 'ext.just'

kill:
  kill $(lsof -t -i:7180);
```

Ну или можно сделать более общую команду:

```cpp title:.justfile ln:true
import? 'ext.just'

kill *port:
  kill $(lsof -t -i:{{port}});
```