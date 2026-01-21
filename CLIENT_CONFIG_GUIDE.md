# Client-Side Configuration Guide

## Overview

The Bitbucket MCP server now supports **client-side configuration** through MCP client config files. This means you no longer need to set environment variables on the server side - all configuration is provided by the MCP client (VS Code, Cursor, etc.).

## Configuration Method

**For VS Code HTTP/SSE Transport:** Configuration is provided through the `headers` field in your MCP client configuration file. This is the **only supported method** for VS Code's HTTP MCP client.

**For Other Clients (stdio transport):** Configuration can be provided through `initializationOptions` or `env` fields.

## VS Code Configuration (HTTP/SSE Transport)

Create or update `.vscode/mcp.json`:

```json
{
  "servers": {
    "bitbucket-mcp": {
      "type": "http",
      "url": "http://localhost:3000/sse",
      "headers": {
        "X-Bitbucket-URL": "https://api.bitbucket.org/2.0",
        "X-Bitbucket-Token": "YOUR_API_TOKEN_HERE",
        "X-Bitbucket-Username": "your-email@example.com",
        "X-Bitbucket-Workspace": "your-workspace",
        "X-Bitbucket-Enable-Dangerous": "false"
      }
    }
  }
}
```

**Note:** VS Code's HTTP MCP client does NOT support `initializationOptions`. You must use the `headers` field. The server is started separately (via `start-http-server.ps1` or `start-http-server.sh`).

### Using Input Variables (Recommended for Security)

For better security, use VS Code's input variables to avoid hardcoding tokens:

```json
{
  "inputs": [
    {
      "type": "promptString",
      "id": "bitbucket-token",
      "description": "Bitbucket API Token",
      "password": true
    },
    {
      "type": "promptString",
      "id": "bitbucket-username",
      "description": "Your Atlassian Account Email"
    }
  ],
  "servers": {
    "bitbucket-mcp": {
      "type": "http",
      "url": "http://localhost:3000/sse",
      "headers": {
        "X-Bitbucket-URL": "https://api.bitbucket.org/2.0",
        "X-Bitbucket-Token": "${input:bitbucket-token}",
        "X-Bitbucket-Username": "${input:bitbucket-username}",
        "X-Bitbucket-Workspace": "your-workspace"
      }
    }
  }
}
```

## Configuration Options

**For VS Code HTTP Transport:** All configuration options are provided in `headers`:

| Option | Required | Description |
|--------|----------|-------------|
| `BITBUCKET_URL` | No | Bitbucket API URL (defaults to `https://api.bitbucket.org/2.0`) |
| `BITBUCKET_TOKEN` | Yes* | Bitbucket API token |
| `BITBUCKET_USERNAME` | Yes* | Your Atlassian account email (required when using `BITBUCKET_TOKEN`) |
| `BITBUCKET_PASSWORD` | Yes* | App password (alternative to token) |
| `BITBUCKET_WORKSPACE` | No | Default workspace to use |
| `BITBUCKET_ENABLE_DANGEROUS` | No | Set to `"true"` to enable dangerous operations (default: `"false"`) |

\* Either `BITBUCKET_TOKEN` + `BITBUCKET_USERNAME` OR `BITBUCKET_USERNAME` + `BITBUCKET_PASSWORD` is required.

## How It Works

1. **Client sends configuration**: When VS Code/Cursor connects, it sends the `initializationOptions` in the `initialize` request
2. **Server extracts config**: The server extracts configuration from `params.initializationOptions` or `params.env`
3. **Config takes precedence**: Client configuration takes precedence over environment variables
4. **Fallback to env**: If no client config is provided, the server falls back to environment variables

## Benefits

✅ **No server-side env vars needed**: Configure everything in your MCP client config  
✅ **Per-client configuration**: Different clients can use different Bitbucket accounts  
✅ **Version controlled**: Configuration can be committed to your repo (except tokens!)  
✅ **Easy sharing**: Team members can copy the config structure  

## Security Notes

⚠️ **Important**: Never commit API tokens or passwords to version control!

- Use environment variables or secrets management for sensitive values
- Consider using `.vscode/mcp.json` with `.gitignore` for local config
- Or use environment variable substitution in your config file

## Example: Using Environment Variables in Config

You can still use environment variables by referencing them in your config:

```json
{
  "servers": {
    "bitbucket-mcp": {
      "type": "http",
      "url": "http://localhost:3000/sse",
      "env": {
        "MCP_TRANSPORT": "http",
        "MCP_PORT": "3000",
        "BITBUCKET_TOKEN": "${BITBUCKET_TOKEN}",
        "BITBUCKET_USERNAME": "${BITBUCKET_USERNAME}",
        "BITBUCKET_WORKSPACE": "${BITBUCKET_WORKSPACE}"
      },
      "initializationOptions": {
        "BITBUCKET_URL": "https://api.bitbucket.org/2.0"
      }
    }
  }
}
```

Note: VS Code may support environment variable substitution in `env`, but `initializationOptions` values are passed as-is.

## Migration from Environment Variables

If you were previously using environment variables:

**Before:**
```bash
export BITBUCKET_TOKEN="..."
export BITBUCKET_USERNAME="..."
export BITBUCKET_WORKSPACE="..."
```

**After:**
```json
{
  "initializationOptions": {
    "BITBUCKET_TOKEN": "...",
    "BITBUCKET_USERNAME": "...",
    "BITBUCKET_WORKSPACE": "..."
  }
}
```

The server will still accept environment variables as a fallback, but client configuration takes precedence.
