# PowerShell script to start Bitbucket MCP server in HTTP mode
# NOTE: Configuration is now provided through MCP client config (initializationOptions)
# Environment variables are optional fallback only

$env:MCP_TRANSPORT = "http"
$env:MCP_PORT = "3000"

# Optional: Set these as fallback if not provided in client config
# For client-side configuration, see .vscode/mcp.json.example or CLIENT_CONFIG_GUIDE.md
# $env:BITBUCKET_URL = "https://api.bitbucket.org/2.0"
# $env:BITBUCKET_TOKEN = "YOUR_API_TOKEN_HERE"
# $env:BITBUCKET_USERNAME = "your-email@example.com"
# $env:BITBUCKET_WORKSPACE = "your-workspace"

Write-Host "Building project..." -ForegroundColor Green
npm run build

if ($LASTEXITCODE -eq 0) {
    Write-Host "Starting HTTP server on http://localhost:3000" -ForegroundColor Green
    Write-Host "Note: Configuration should be provided in MCP client config (initializationOptions)" -ForegroundColor Yellow
    Write-Host "See .vscode/mcp.json.example or CLIENT_CONFIG_GUIDE.md for details" -ForegroundColor Yellow
    npm start
} else {
    Write-Host "Build failed!" -ForegroundColor Red
    exit 1
}
