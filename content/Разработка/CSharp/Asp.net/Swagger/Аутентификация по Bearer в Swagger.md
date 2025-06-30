---
created: 2024-05-15T20:52:41+03:00
modified: 2025-02-15T04:32:17+03:00
tags:
  - inbox
  - development/dotnet/scharp/aspnet/swagger/auth
categories:
  - bearer
  - swagger
  - aspnet
  - auth
  - sso
  - service-collection
publish: true
sr-due: 2025-02-15
sr-interval: 3
sr-ease: 250
---
### Подключение схемы

Добавим пакет `Microsoft.AspNetCore.OpenApi`:

```sh
dotnet add Microsoft.AspNetCore.OpenApi
```

Выделим получение схемы в отдельный метод:

```csharp title:BearerSchemeBuilder.cs ln:true unwrap
using Microsoft.OpenApi.Models;

public class BearerSchemeBuilder
{
	public OpenApiSecurityScheme Build() => new()
	{
		Description = "JWT Authorization header using the Bearer scheme (Example: 'Bearer 12345abcdef')",
		Name = "Authorization",
		In = ParameterLocation.Header,
		Type = SecuritySchemeType.ApiKey,
		Scheme = "bearer",
		Reference = new OpenApiReference
		{
			Type = ReferenceType.SecurityScheme,
			Id = "bearer"
		},
	};
}
```

Создадим *Extensions* для подключения *Swagger*. В моем случае это файл `DependencyInjection/Swagger.cs` в основном проекте *Asp.net*:

```csharp titile:DependencyInjection/Swagger.cs ln:true unwrap
using Microsoft.OpenApi.Models;

public static class Swagger
{
    public static IServiceCollection ConfigureSwagger(
        this IServiceCollection services
    )
    {
        var bearerBuilder = new BearerSchemeBuilder();

        var bearer = bearerBuilder.Build();

        return services.AddSwaggerGen(c =>
        {
            c.AddSecurityDefinition("bearer", bearer);

            c.AddSecurityRequirement(new OpenApiSecurityRequirement
            {
                {
                    bearer,
                    new List<string> { }
                }
            });
    }

    public static IApplicationBuilder UseConfigureSwagger(
		this IApplicationBuilder app
	)
    {
        app.UseSwagger();

        app.UseSwaggerUI(s =>
        {
            s.SwaggerEndpoint("v1/swagger.json", "Api v1");
            s.EnablePersistAuthorization();
        });

        return app;
    }
}
```

Подключим в `Program.cs`:

```csharp titile:Program.cs ln:true hl:6,12-13 unwrap
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();

builder.Services.ConfigureSwagger();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseStaticFiles();
    app.UseConfigureSwagger();
}

app.UseHttpsRedirection();
app.MapControllers();

app.Run();
```

Предполагается, что вы также предварительно настроили соответствующую [[Аутентификация по Bearer в Asp.net|аутентификацию]].
### Свзанные материалы

[[Refresh Token Rotation| Как настроить ротацию в Keycloak]]

[[Token Tower в Swagger|Как настроить автоматическое обновление токена доступа]]

### Полезные ссылки

В этом примере кажется есть возможность сделать выбор из юзеров:
[c# - good practice for adding auth in asp.net (swagger/open api) - Stack Overflow](https://stackoverflow.com/questions/76215671/good-practice-for-adding-auth-in-asp-net-swagger-open-api)
