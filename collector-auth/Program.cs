using System.Collections.Immutable;
using collector_auth.Models;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddSingleton<HttpClient>();

builder.Services.AddSingleton<JwtConfiguration>();

var app = builder.Build();

app.MapControllers();

app.MapGet("/", () => "Hello World!");

app.Run();