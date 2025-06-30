---
tags:
  - inbox
  - development/dotnet/scharp/aspnet/auth
categories:
  - auth
  - aspnet
  - bearer
  - sso
  - service-collection
created: 2025-02-12T21:53:44+03:00
modified: 2025-02-15T04:16:47+03:00
sr-due: 2025-02-16
sr-interval: 3
sr-ease: 250
publish: true
---
### Настройка

Добавим пакет `Microsoft.AspNetCore.Authentication.JwtBearer`:

```sh
dotnet add Microsoft.AspNetCore.Authentication.JwtBearer
```

#### Подготовим данные конфигураций

Добавим в конфигурационный файл необходимую информацию о *SSO* используемую для аутентификации по схеме `Bearer`:

```json title:appsettings.json ln:true
{
	"Auth": {
	    "Authority": "http://keycloak.test/realms/test",
	    "Audience": "webapi"
	}
}
```

Создадим модель с данными аутентификации для конфига `Configuration/AuthSettings.cs`:

```csharp title:Configuration/AuthSettings.cs ln:true
public class AuthSettings
{
    public string Authority { get; set; }
    public string Audience { get; set; }
}
```

Создадим корневую модель для конфига `Configuration/ApiConfiguration.cs`:

```csharp title:Configuration/ApiConfiguration.cs ln:true
public class ApiConfiguration
{
    public AuthSettings Auth { get; set; }
}
```

#### Создадим расширение для подключения схемы аутентификации

Создадим *Extensions* для подключения схемы аутентификации. В моем случае это файл `DependencyInjection/Authentication.cs` в основном проекте *Asp.net*:

```csharp titile:DependencyInjection/Authentication.cs ln:true unwrap
public static class Authentication
{
    /// <summary>
    ///     Конфигурация аутентификации
    /// </summary>
    public static IServiceCollection ConfigureAuthentication(
        this IServiceCollection services,
        IConfiguration configuration
    )
    {
        var config = configuration.Get<ApiConfiguration>();

        services
            .AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
            .AddJwtBearer(x =>
            {
                x.RequireHttpsMetadata = false;
                x.Authority = config.Auth.Authority;
                x.Audience = config.Auth.Audience;
                x.IncludeErrorDetails = true;
                x.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateAudience = false,
                    ValidateIssuer = false,
                    ValidateLifetime = true,
                    RequireExpirationTime = true
                };
            });

        return services;
    }

    public static IApplicationBuilder UseConfigureAuthentication(this IApplicationBuilder builder) =>
        builder
            .UseAuthentication();
}
```

#### Подключим расширение схемы аутентификации

В `Program.cs`:

```csharp titile:Program.cs ln:true hl:5,10 unwrap
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();

builder.Services.ConfigureAuthentication(builder.Configuration);

var app = builder.Build();

app.UseHttpsRedirection();
app.UseConfigureAuthentication();
app.MapControllers();

app.Run();
```

Если *SSO* использует собственный сертификат, то нам также требуется добавить сертификат через [[Добавление сертификата в Asp.net для SSO|приложение]] или через хранилище сертификатов.

Также для удобства тестирования конечных точек можно настроить [[Аутентификация по Bearer в Swagger|соответствующую аутентификацию в Swagger]].