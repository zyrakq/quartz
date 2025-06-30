---
tags:
  - development/dotnet/scharp/aspnet
  - inbox
categories:
  - aspnet
  - controller
  - api-versioning
  - service-collection
  - swagger
created: 2025-02-15T03:15:02+03:00
modified: 2025-02-15T04:13:54+03:00
publish: true
sr-due: 2025-02-18
sr-interval: 3
sr-ease: 250
---
Со временем в конечные точки апи требуется внести изменения ломающие работу клиентов, которые обращаются к этому апи. Чтобы дать время клиентам избежать ситуации при которой работа их приложений ломается при каждом критическом изменении - следует учитывать этот фактор при проектировании апи.
В частности одним из таких способов это выпуск новой версии при каждом изменении контракта, а также поддержание устаревших конечных точек еще какое то время после выпуска новой версии.
В идеале такие конечные точки должны поддерживаться до тех пор пока статистика показывает, что к конечным точкам все еще обращаются клиенты.

Данные расширение также влияет на отображение в *Swagger*.

### Настройка

Добавим пакет `Microsoft.AspNetCore.Mvc.Versioning.ApiExplorer`:

```sh
dotnet add Microsoft.AspNetCore.Mvc.Versioning.ApiExplorer
```

#### Создадим расширение настройки версионности контроллеров

Создадим *Extensions* для настройки версионности контроллеров. В моем случае это файл `DependencyInjection/ApiVersioning.cs` в основном проекте *Asp.net*:

```csharp titile:DependencyInjection/ApiVersioning.cs ln:true unwrap
public static class ApiVersioning
{
    public static IServiceCollection ConfigureApiVersioning(
        this IServiceCollection services
    ) => services
        .AddApiVersioning(config =>
        {
            config.DefaultApiVersion = new ApiVersion(1, 0);
            config.AssumeDefaultVersionWhenUnspecified = true;
            config.ReportApiVersions = true;
        })
        .AddVersionedApiExplorer(
            options =>
            {
                options.GroupNameFormat = "'v'VVV";

                options.SubstituteApiVersionInUrl = true;
            }
        );
}
```

#### Подключим версионность через зависимости

В `Program.cs`:

```csharp titile:Program.cs ln:true hl:5-6 unwrap
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();

builder.Services.AddEndpointsApiExplorer();
builder.Services.ConfigureApiVersioning();

var app = builder.Build();

app.UseHttpsRedirection();
app.MapControllers();

app.Run();
```

### Пример контроллера

Создадним контроллер с определенной версией `Controllers/v1/UserController.cs`:

```csharp title:Controllers/v1/UserController.cs ln:true unwrap
using Microsoft.AspNetCore.Mvc;

namespace WebApi.Controllers.v1;

[ApiVersion("1")]
[Route("api/v{version:apiVersion}/users")]
[ApiController]
public class UserController : Controller
{
...
}
```
