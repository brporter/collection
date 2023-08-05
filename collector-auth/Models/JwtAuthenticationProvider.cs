namespace collector_auth.Models;

public record JwtAuthenticationProvider(string Name, string ClientId, string ClientSecret, Uri RedirectUri, Uri AuthEndpoint, string AuthEndpointQueryFormat, Uri TokenEndpoint);