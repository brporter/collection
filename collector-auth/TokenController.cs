using Microsoft.AspNetCore.Mvc;

using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text;

namespace collector_auth;

[ApiController]
[Route("[controller]")]
public class TokenController : Controller
{
    private readonly IConfiguration _configuration;

    public TokenController(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    [HttpGet("/[controller]/auth/{provider}")]
    public IActionResult Authenticate(string provider)
    {
        if (provider.Equals("google", StringComparison.OrdinalIgnoreCase))
        {
            var clientId = "863855792774-l90tlmpj2rj8728dia0ib5rtlbnranks.apps.googleusercontent.com"; // TODO: replace with lookup in configuration

            var responseType = "code";
            var scope = "openid email";
            var redirect_uri = "https://localhost:5001/token/redeem/google";
            var state = Guid.NewGuid();
            var nonce = Guid.NewGuid();

            var uri = new UriBuilder();
            uri.Host = "accounts.google.com";
            uri.Scheme = "https";
            uri.Path = "/o/oauth2/v2/auth";
            uri.Query = $"response_type={responseType}&client_id={clientId}&scope={scope}&redirect_uri={redirect_uri}&state={state}&nonce={nonce}";
            // "https:///o/oauth2/v2/auth?"
            
            Response.Cookies.Append("state", state.ToString(), new CookieOptions()
            {
                IsEssential = true,
                Expires = DateTime.UtcNow.AddMinutes(10),
                Secure = true,
                HttpOnly = true,
                SameSite = SameSiteMode.Strict
            });

            return Redirect(uri.ToString());
        }

        throw new NotImplementedException("Unknown provider.");
    }

    [HttpGet("/[controller]/redeem/{provider}")]
    public IActionResult ConvertToken(string provider, string state, string code)
    {
        if (provider.Equals("google", StringComparison.OrdinalIgnoreCase))
        {
            
        }
        
        throw new NotImplementedException("Unknown provider.");
        
        // string jwtToken = null;
        //
        // if (provider.Equals("microsoft", StringComparison.OrdinalIgnoreCase))
        // {
        //     // Validate and process Microsoft token
        //     // Your Microsoft token validation and processing logic here
        //
        //     // Generate JWT token
        //     jwtToken = GenerateJwtToken();
        // }
        // else if (provider.Equals("google", StringComparison.OrdinalIgnoreCase))
        // {
        //     // Validate and process Google token
        //     // Your Google token validation and processing logic here
        //
        //     // Generate JWT token
        //     jwtToken = GenerateJwtToken();
        // }
        // else
        // {
        //     return BadRequest("Invalid token provider");
        // }
        //
        // return Ok(new { jwtToken });
    }

    private string GenerateJwtToken()
    {
        var claims = new[]
        {
            new Claim(JwtRegisteredClaimNames.Sub, "exampleuser"),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
        };

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:SecretKey"]));
        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        var expires = DateTime.UtcNow.AddHours(1);

        var token = new JwtSecurityToken(
            issuer: _configuration["Jwt:Issuer"],
            audience: _configuration["Jwt:Audience"],
            claims: claims,
            expires: expires,
            signingCredentials: credentials
        );

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}
