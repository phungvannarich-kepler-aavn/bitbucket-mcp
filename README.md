# Bitbucket MCP

A Model Context Protocol (MCP) server for integrating with Bitbucket Cloud and Server APIs. This MCP server enables AI assistants like Cursor to interact with your Bitbucket repositories, pull requests, and other resources.

## Safety First

This is a safe and responsible package — no DELETE operations are used, so there's no risk of data loss.
Every pull request is analyzed with CodeQL to ensure the code remains secure.

[![CodeQL](https://github.com/MatanYemini/bitbucket-mcp/actions/workflows/github-code-scanning/codeql/badge.svg)](https://github.com/MatanYemini/bitbucket-mcp/actions/workflows/github-code-scanning/codeql)
[![GitHub Repository](https://img.shields.io/badge/GitHub-Repository-blue.svg)](https://github.com/MatanYemini/bitbucket-mcp)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![npm version](https://badge.fury.io/js/bitbucket-mcp.svg)](https://www.npmjs.com/package/bitbucket-mcp)

## Overview

Checkout out the [official npm package](https://www.npmjs.com/package/bitbucket-mcp)
This server implements the Model Context Protocol standard to provide AI assistants with access to Bitbucket data and operations. It includes tools for:

- Listing and retrieving repositories
- Getting repository details
- Fetching pull requests
- And more...

## Installation

-- Since it has been asked, in many cases we have seen - "BITBUCKET_USERNAME" is usually your email

### Using NPX (Recommended)

The easiest way to use this MCP server is via NPX, which allows you to run it without installing it globally:

```bash
# Option A (recommended): API URL + explicit workspace
BITBUCKET_URL="https://api.bitbucket.org/2.0" \
BITBUCKET_WORKSPACE="your-workspace" \
BITBUCKET_USERNAME="your-username" \
BITBUCKET_PASSWORD="your-app-password" \
npx -y bitbucket-mcp@latest

# Option B (legacy-compatible): web URL only; workspace is auto-extracted
BITBUCKET_URL="https://bitbucket.org/your-workspace" \
BITBUCKET_USERNAME="your-username" \
BITBUCKET_PASSWORD="your-app-password" \
npx -y bitbucket-mcp@latest
```

### Manual Installation

Alternatively, you can install it globally or as part of your project:

```bash
# Install globally
npm install -g bitbucket-mcp

# Or install in your project
npm install bitbucket-mcp
```

Then run it with:

```bash
# If installed globally (Option A)
BITBUCKET_URL="https://api.bitbucket.org/2.0" \
BITBUCKET_WORKSPACE="your-workspace" \
BITBUCKET_USERNAME="your-username" \
BITBUCKET_PASSWORD="your-app-password" \
bitbucket-mcp

# If installed globally (Option B - legacy-compatible)
BITBUCKET_URL="https://bitbucket.org/your-workspace" \
BITBUCKET_USERNAME="your-username" \
BITBUCKET_PASSWORD="your-app-password" \
bitbucket-mcp

# If installed in your project (Option A)
BITBUCKET_URL="https://api.bitbucket.org/2.0" \
BITBUCKET_WORKSPACE="your-workspace" \
BITBUCKET_USERNAME="your-username" \
BITBUCKET_PASSWORD="your-app-password" \
npx bitbucket-mcp

# If installed in your project (Option B - legacy-compatible)
BITBUCKET_URL="https://bitbucket.org/your-workspace" \
BITBUCKET_USERNAME="your-username" \
BITBUCKET_PASSWORD="your-app-password" \
npx bitbucket-mcp
```

## Configuration

### Environment Variables

Configure the server using the following environment variables:

| Variable                     | Description                                                                    | Required |
| ---------------------------- | ------------------------------------------------------------------------------ | -------- |
| `BITBUCKET_URL`              | Bitbucket API base URL. Defaults to `https://api.bitbucket.org/2.0`            | No       |
| `BITBUCKET_TOKEN`            | **Recommended:** Your Bitbucket API token (no mobile verification needed)      | Yes\*    |
| `BITBUCKET_USERNAME`         | Your Bitbucket username/email (only if using password auth)                    | No       |
| `BITBUCKET_PASSWORD`         | Your Bitbucket app password (requires mobile verification - not recommended)   | No       |
| `BITBUCKET_WORKSPACE`        | Default workspace to use. If omitted and `BITBUCKET_URL` contains it, auto-set | No       |
| `BITBUCKET_ENABLE_DANGEROUS` | Set to `true` to enable dangerous tools (e.g., deletions). Default: disabled   | No       |
| `MCP_TRANSPORT`              | Transport type: `stdio` (default) or `http` for HTTP server mode               | No       |
| `MCP_PORT`                   | Port for HTTP server (default: 3000). Only used when `MCP_TRANSPORT=http`     | No       |
| `BITBUCKET_LOG_DISABLE`      | Disable file logging when set to `true`/`1`                                    | No       |
| `BITBUCKET_LOG_FILE`         | Absolute path to a specific log file                                           | No       |
| `BITBUCKET_LOG_DIR`          | Directory to store logs (defaults to OS-specific app log dir)                  | No       |
| `BITBUCKET_LOG_PER_CWD`      | When `true`, nest logs under a per-working-directory subfolder                 | No       |

**Authentication:** Either `BITBUCKET_TOKEN` (recommended) or both `BITBUCKET_USERNAME` and `BITBUCKET_PASSWORD` must be provided.

**⚠️ Important:** `BITBUCKET_TOKEN` is strongly recommended as it doesn't require mobile app verification. Username/password authentication may require 2FA verification on your mobile device.

**📝 Client-Side Configuration (Recommended):** Configuration can now be provided through the MCP client config file (`initializationOptions`) instead of environment variables. See [Client Configuration Guide](./CLIENT_CONFIG_GUIDE.md) for details.

### Creating a Bitbucket API Token (Recommended)

**API tokens are preferred** as they don't require mobile app verification. Here's how to get one:

#### Step-by-Step Instructions:

1. **Log in to Bitbucket Cloud**
   - Go to https://bitbucket.org and sign in

2. **Navigate to Atlassian Account Settings**
   - Click your profile avatar (top right)
   - Select **Personal settings**
   - Click **Atlassian account settings** (or go directly to https://id.atlassian.com/manage-profile/security/api-tokens)

3. **Create API Token**
   - Click the **Security** tab
   - Scroll down to **"Create and manage API tokens"**
   - Click **Create API token**

4. **Configure the Token**
   - **Label**: Give it a descriptive name (e.g., "MCP Server" or "VS Code Integration")
   - **Expiry**: Set an expiration date (optional, recommended for security)
   - **Permissions**: Select the minimum scopes needed:
     - ✅ **`repository:read`** - Required for reading repositories
     - ✅ **`repository:write`** - Required for creating/updating PRs
     - ✅ **`pullrequest:read`** - Required for reading pull requests
     - ✅ **`pullrequest:write`** - Required for creating/updating PRs
     - ✅ **`pipeline:read`** - Required for reading pipeline logs

5. **Copy the Token**
   - Click **Create token**
   - **⚠️ IMPORTANT**: Copy the token immediately - you won't be able to see it again!
   - Store it securely (password manager, environment variable, etc.)

6. **Use the Token**
   - Set it as the `BITBUCKET_TOKEN` environment variable
   - Example: `BITBUCKET_TOKEN="ATATT3xFfGF0..."`

#### Quick Link:
- Direct link to create API tokens: https://id.atlassian.com/manage-profile/security/api-tokens

#### Alternative: Using App Passwords (Legacy)

If you're using the older App Passwords method:
1. Go to https://bitbucket.org/account/settings/app-passwords/
2. Click **Create app password**
3. Select permissions and create
4. **Note**: App passwords are being deprecated and may require mobile verification

**Note:** API tokens are scoped, can be revoked at any time, and don't require 2FA mobile verification. They're the recommended authentication method going forward.

### Testing API Token Authentication

To test your API token works correctly:

```bash
# Test with curl using API token (replace YOUR_API_TOKEN and your-workspace)
curl -H "Authorization: Bearer YOUR_API_TOKEN" \
  "https://api.bitbucket.org/2.0/repositories/your-workspace"
```

You should see a JSON response with your repositories. If you get a `401 Unauthorized` error, check:
- The token was copied correctly (no extra spaces)
- The token hasn't expired
- The token has the required scopes/permissions

### Alternative: Using App Password (Legacy - Not Recommended)

If you must use username/password authentication (legacy method):

1. Log in to your Bitbucket account
2. Go to Personal Settings > App Passwords (https://bitbucket.org/account/settings/app-passwords/)
3. Create a new app password with the required permissions
4. **Note:** You may be prompted for mobile app verification
5. Use `BITBUCKET_USERNAME` (your email) and `BITBUCKET_PASSWORD` (the app password)

**⚠️ Warning:** App passwords are being deprecated and will be disabled in June 2026. Use API tokens instead.

## Troubleshooting

### 401 Authentication Errors

If you're getting 401 authentication errors, check the following:

1. **Verify your app password**: Make sure you're using an App Password, not your regular Bitbucket password
1. **Verify app password permissions**: Your app password needs at least "Repositories: Read" permission
1. **Try the API URL format**: If you're still getting 401 errors, try using the direct API URL format:

```bash
BITBUCKET_URL="https://api.bitbucket.org/2.0"
```

1. **Test API access**: Verify your credentials work by testing the Bitbucket API directly:

```bash
# Test with curl (replace with your actual values)
curl -u "your-username:your-app-password" \
  "https://api.bitbucket.org/2.0/repositories/your-workspace"
```

### Testing API Token Authentication

To test your API token:

```bash
# Test with curl using API token
curl -H "Authorization: Bearer YOUR_API_TOKEN" \
  "https://api.bitbucket.org/2.0/repositories/your-workspace"
```

### Atlassian API Key (Legacy)

If you're using an Atlassian API Key instead of a Bitbucket API token:

1. Put the Atlassian API Key in the `BITBUCKET_PASSWORD` variable, not `BITBUCKET_TOKEN`
2. Use your Bitbucket email as `BITBUCKET_USERNAME` instead of your regular username

For reference you can check the [API token documentation](https://support.atlassian.com/bitbucket-cloud/docs/using-api-tokens/)

### Getting Help

If you encounter issues:

1. Check the [Bitbucket REST API documentation](https://developer.atlassian.com/cloud/bitbucket/rest/intro/) for API details
2. Review the [Bitbucket Cloud documentation](https://support.atlassian.com/bitbucket-cloud/) for general help

## Running as HTTP Server (for VS Code)

To run the MCP server as an HTTP server for VS Code or other HTTP-based MCP clients:

### 1. Start the HTTP Server

**Option A: Using the provided scripts (Recommended)**

**Windows (PowerShell):**
```powershell
.\start-http-server.ps1
```

**Linux/Mac (Bash):**
```bash
./start-http-server.sh
```

**Option B: Manual start**

```bash
MCP_TRANSPORT=http MCP_PORT=3000 node dist/index.js
```

The server will start on `http://localhost:3000` with the following endpoints:
- `POST /mcp` - MCP protocol endpoint
- `GET /health` - Health check endpoint
- `GET /sse` - Server-Sent Events endpoint (for streaming)
- `POST /sse` - SSE message endpoint
- `POST /message` - Alternative message endpoint

### 2. Configure VS Code

**⚠️ Important:** Configuration is now provided through the MCP client config file, not environment variables!

Create `.vscode/mcp.json` in your workspace:

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

**⚠️ Important:** VS Code's HTTP MCP client does NOT support `initializationOptions`. You must use the `headers` field. This is the only supported method according to [VS Code's MCP documentation](https://code.visualstudio.com/docs/copilot/customization/mcp-servers).

**Key points:**
- Use `"url": "http://localhost:3000/sse"` for SSE transport (recommended)
- Configuration goes in `headers` with `X-Bitbucket-` prefix (VS Code requirement)
- The server must be started separately (via `start-http-server.ps1` or `start-http-server.sh`) with `MCP_TRANSPORT=http` and `MCP_PORT=3000`
- Environment variables are optional fallback only
- See [Client Configuration Guide](./CLIENT_CONFIG_GUIDE.md) for detailed instructions

### Using Input Variables (Recommended for Security)

For better security, use VS Code's input variables:

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

Or configure globally:
1. Open Command Palette (Ctrl+Shift+P / Cmd+Shift+P)
2. Run: `MCP: Add Server`
3. Select "HTTP" type
4. Enter URL: `http://localhost:3000/sse`
5. Add configuration in `initializationOptions`

### 3. Verify Connection

Check the health endpoint:
```bash
curl http://localhost:3000/health
```

You should see:
```json
{
  "status": "ok",
  "service": "bitbucket-mcp",
  "transport": "http"
}
```

## Integration with Cursor

To integrate this MCP server with Cursor:

1. Open Cursor
2. Go to Settings > Extensions
3. Click on "Model Context Protocol"
4. Add a new MCP configuration:

```json
"bitbucket": {
  "command": "npx",
  "env": {
    "BITBUCKET_URL": "https://api.bitbucket.org/2.0",
    "BITBUCKET_WORKSPACE": "your-workspace",
    "BITBUCKET_USERNAME": "your-username",
    "BITBUCKET_PASSWORD": "your-app-password"
  },
  "args": ["-y", "bitbucket-mcp@latest"]
}
```

1. Save the configuration
2. Use the "/bitbucket" command in Cursor to access Bitbucket repositories and pull requests

### Using a Local Build with Cursor

If you're developing locally and want to test your changes:

```json
"bitbucket-local": {
  "command": "node",
  "env": {
    "BITBUCKET_URL": "https://api.bitbucket.org/2.0",
    "BITBUCKET_WORKSPACE": "your-workspace",
    "BITBUCKET_USERNAME": "your-username",
    "BITBUCKET_PASSWORD": "your-app-password"
  },
  "args": ["/path/to/your/local/bitbucket-mcp/dist/index.js"]
}
```

## Available Tools

This MCP server provides tools for interacting with Bitbucket repositories and pull requests. Below is a comprehensive list of the available operations:

### Pagination

Unless noted otherwise, listing tools accept the following optional parameters:

- `pagelen`: Number of items per page (Bitbucket `pagelen`). Defaults to 10 and is capped at 100.
- `page`: 1-based Bitbucket page number to fetch. When omitted, the first page is returned.
- `all`: When `true` (and `page` is not provided), the server automatically follows Bitbucket `next` links until all items are fetched or a safety cap of 1,000 entries is reached.
- `limit`: Deprecated alias for `pagelen` kept for backward compatibility.

Use these knobs to page through large collections without hitting CLI truncation.

### Repository Operations

#### `listRepositories`

Lists repositories in a workspace.

**Parameters:**

- `workspace` (optional): Bitbucket workspace name
- `name` (optional): Filter repositories by partial name match
- Pagination controls described in [Pagination](#pagination)

#### `getRepository`

Gets details for a specific repository.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug

### Pull Request Operations

#### `getPullRequests`

Gets pull requests for a repository.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `state` (optional): Pull request state (`OPEN`, `MERGED`, `DECLINED`, `SUPERSEDED`)
- Pagination controls described in [Pagination](#pagination)

#### `createPullRequest`

Creates a new pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `title`: Pull request title
- `description`: Pull request description
- `sourceBranch`: Source branch name
- `targetBranch`: Target branch name
- `reviewers` (optional): List of reviewer usernames
- `draft` (optional): Whether to create the pull request as a draft

#### `getPullRequest`

Gets details for a specific pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID
- Pagination controls described in [Pagination](#pagination)
- Pagination controls described in [Pagination](#pagination)
- Pagination controls described in [Pagination](#pagination)
- Pagination controls described in [Pagination](#pagination)

#### `updatePullRequest`

Updates a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID
- Pagination controls described in [Pagination](#pagination)
- Pagination controls described in [Pagination](#pagination)
- Various optional update parameters (title, description, etc.)

#### `getPullRequestActivity`

Gets the activity log for a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID

#### `approvePullRequest`

Approves a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID

#### `unapprovePullRequest`

Removes an approval from a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID

#### `declinePullRequest`

Declines a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID
- `message` (optional): Reason for declining

#### `mergePullRequest`

Merges a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID
- `message` (optional): Merge commit message
- `strategy` (optional): Merge strategy (`merge-commit`, `squash`, `fast-forward`)

#### `requestChanges`

Requests changes on a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID

#### `removeChangeRequest`

Removes a change request from a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID

#### `createDraftPullRequest`

Creates a new draft pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `title`: Pull request title
- `description`: Pull request description
- `sourceBranch`: Source branch name
- `targetBranch`: Target branch name
- `reviewers` (optional): List of reviewer usernames

**Note:** This is equivalent to calling `createPullRequest` with `draft: true`.

#### `publishDraftPullRequest`

Publishes a draft pull request to make it ready for review.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID

#### `convertTodraft`

Converts a regular pull request to draft status.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID

### Pull Request Comment Operations

#### `getPullRequestComments`

Lists comments on a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID

#### `addPullRequestComment`

Creates a comment on a pull request (general or inline).

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID
- `content`: Comment content in markdown format
- `inline` (optional): Inline comment information for commenting on specific lines

**Inline Comment Format:**

The `inline` parameter allows you to create comments on specific lines of code in the pull request diff:

```json
{
  "path": "src/file.ts",
  "to": 15, // Line number in NEW version (for added/modified lines)
  "from": 10 // Line number in OLD version (for deleted/modified lines)
}
```

**Examples:**

- **General comment**: Omit the `inline` parameter for a general pull request comment
- **Comment on new line**: Use only `to` parameter
- **Comment on deleted line**: Use only `from` parameter
- **Comment on modified line**: Use both `from` and `to` parameters

**Usage:**

```javascript
// General comment
addPullRequestComment(workspace, repo, pr_id, "Great work!");

// Inline comment on new line 25
addPullRequestComment(workspace, repo, pr_id, "Consider error handling here", {
  path: "src/service.ts",
  to: 25,
});
```

#### `getPullRequestComment`

Gets a specific comment on a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID
- `comment_id`: Comment ID

#### `updatePullRequestComment`

Updates a comment on a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID
- `comment_id`: Comment ID
- `content`: Updated comment content

#### `deletePullRequestComment`

Deletes a comment on a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID
- `comment_id`: Comment ID

#### `resolveComment`

Resolves a comment thread on a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID
- `comment_id`: Comment ID

#### `reopenComment`

Reopens a resolved comment thread on a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID
- `comment_id`: Comment ID

### Pull Request Diff Operations

#### `getPullRequestDiff`

Gets the diff for a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID

#### `getPullRequestDiffStat`

Gets the diff statistics for a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID

#### `getPullRequestPatch`

Gets the patch for a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID

### Pull Request Task Operations

#### `getPullRequestTasks`

Lists tasks on a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID

#### `createPullRequestTask`

Creates a task on a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID
- `content`: Task content
- `comment` (optional): Comment ID to associate with the task
- `pending` (optional): Whether the task is pending

#### `getPullRequestTask`

Gets a specific task on a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID
- `task_id`: Task ID

#### `updatePullRequestTask`

Updates a task on a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID
- `task_id`: Task ID
- `content` (optional): Updated task content
- `state` (optional): Updated task state

#### `deletePullRequestTask`

Deletes a task on a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID
- `task_id`: Task ID

### Other Pull Request Operations

#### `getPullRequestCommits`

Lists commits on a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID

#### `getPullRequestStatuses`

Lists commit statuses for a pull request.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pull_request_id`: Pull request ID

### Pipeline Operations

#### `listPipelineRuns`

Lists pipeline runs for a repository.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- Pagination controls described in [Pagination](#pagination)
- `status` (optional): Filter pipelines by status (`PENDING`, `IN_PROGRESS`, `SUCCESSFUL`, `FAILED`, `ERROR`, `STOPPED`)
- `target_branch` (optional): Filter pipelines by target branch
- `trigger_type` (optional): Filter pipelines by trigger type (`manual`, `push`, `pullrequest`, `schedule`)

#### `getPipelineRun`

Gets details for a specific pipeline run.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pipeline_uuid`: Pipeline UUID
- Pagination controls described in [Pagination](#pagination)

#### `runPipeline`

Triggers a new pipeline run.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `target`: Pipeline target configuration (object with `ref_type`, `ref_name`, and optional `commit_hash`, `selector_type`, `selector_pattern`)
- `variables` (optional): Array of pipeline variables (objects with `key`, `value`, and optional `secured` fields)

#### `stopPipeline`

Stops a running pipeline.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pipeline_uuid`: Pipeline UUID

#### `getPipelineSteps`

Lists steps for a pipeline run.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pipeline_uuid`: Pipeline UUID

#### `getPipelineStep`

Gets details for a specific pipeline step.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pipeline_uuid`: Pipeline UUID
- `step_uuid`: Step UUID

#### `getPipelineStepLogs`

Gets logs for a specific pipeline step.

**Parameters:**

- `workspace`: Bitbucket workspace name
- `repo_slug`: Repository slug
- `pipeline_uuid`: Pipeline UUID
- `step_uuid`: Step UUID

## Development

### Prerequisites

- Node.js 18 or higher
- npm or yarn

### Setup

```bash
# Clone the repository
git clone https://github.com/MatanYemini/bitbucket-mcp.git
cd bitbucket-mcp

# Install dependencies
npm install

# Build the project
npm run build

# Run in development mode
npm run dev
```

## Publishing to the MCP Registry

Use the official Model Context Protocol publishing guide when you are ready to make a new server release. The repository includes
everything that guide expects:

1. Build the project so `dist/index.js` is up to date:
   ```bash
   npm run build
   ```
2. Generate the registry manifest (this reads `package.json` and emits `registry/bitbucket-mcp.manifest.json`):
   ```bash
   npm run registry:manifest
   ```
3. Follow the [publish-server guide](https://github.com/modelcontextprotocol/registry/blob/main/docs/guides/publishing/publish-server.md)
   to push the manifest with `smithery publish` or the recommended workflow from the guide.

The generated manifest captures the CLI command (`node dist/index.js`), all documented configuration options, and pointers back to
this README for setup instructions, so it can be submitted directly to the MCP registry.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Links

- [GitHub Repository](https://github.com/MatanYemini/bitbucket-mcp)
- [npm Package](https://www.npmjs.com/package/bitbucket-mcp)
- [Model Context Protocol](https://modelcontextprotocol.io/)
- [Bitbucket REST API Documentation](https://developer.atlassian.com/cloud/bitbucket/rest/intro/)
- [Bitbucket Cloud Documentation](https://support.atlassian.com/bitbucket-cloud/)
