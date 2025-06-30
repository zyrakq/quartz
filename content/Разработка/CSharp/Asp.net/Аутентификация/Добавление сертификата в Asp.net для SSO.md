---
tags:
  - inbox
  - development/dotnet/scharp/aspnet/auth
categories:
  - certificate
  - auth
  - sso
  - keycloak
  - lets-encrypt
  - service-collection
created: 2025-02-13T03:40:16+03:00
modified: 2025-03-04T18:42:00+03:00
sr-due: 2025-02-16
sr-interval: 3
sr-ease: 250
publish: true
---
Если вы решили настроить аутентификацию одним из следующих способов:

[[Аутентификация по Bearer в Asp.net]]

При работе со своим собственным *SSO* сервером, например, разворачиваемым локально экземпляр *Keycloak* в контейнере. Для такого *SSO* сервера требуется сертификат и если он доступен из сети, то его можно подписать используя *Let's Encrypt*. Но если нет, то нам потребуется добавить свой сертификат и сообщить хосту на котором разворачивается приложение то, что используемый *SSO* сертификат доверенный.

По идее его можно добавить тремя способами:

- Добавить в сборку приложения и в коде приложения добавить в хранилише сертификатов при старте
- Добавить в хранилище при сборке образа в `.Dockerfile`
- Добавить монтирование файла в `docker-compose.yml`

Здесь мы рассмотрим первый вариант.
### Настройка

#### Добавим сертификат в проект

Добавим в папку проекта наш сертификат, пусть это будет `certificate.crt`.

Сделает так, чтобы этот файл попадал в папку сборки. Для этого в файл проекта, в моем случае это `WebApi.csproj` добавим следующий блок:

```xml title:WebApi.csproj ln:true hl:2-6
<Project Sdk="Microsoft.NET.Sdk.Web">
  <ItemGroup>
    <None Update="certificate.crt">
      <CopyToOutputDirectory>Always</CopyToOutputDirectory>
    </None>
  </ItemGroup>
</Project>
```

#### Создадим расширение для подключения сертификата

Создадим *Extensions* для подключения сертификата. В моем случае это файл `DependencyInjection/Certificate.cs` в основном проекте *Asp.net*:

```csharp titile:DependencyInjection/Certificate.cs ln:true unwrap
using System.Security.Cryptography.X509Certificates;

public static class Certificate
{
    private static IServiceCollection ConfigureCertificate(
        this IServiceCollection services,
        string certificatePath
    )
    {
        if (File.Exists(certificatePath))
        {
            // Загрузка корневого сертификата
            var certificate = new X509Certificate2(certificatePath);

            // Добавление корневого сертификата в доверенные
            using var store = new X509Store(StoreName.Root, StoreLocation.CurrentUser);
            store.Open(OpenFlags.ReadWrite);
            store.Add(certificate);
        }

        return services;
    }
}
```

#### Подключим сертификат

В `Program.cs`:

```csharp titile:Program.cs ln:true hl:5 unwrap
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();

builder.Services.ConfigureCertificate("certificate.crt");

var app = builder.Build();

app.UseHttpsRedirection();
app.MapControllers();

app.Run();
```

Теперь при аутентификации не должно быть жалоб на недоверенный сертификат.