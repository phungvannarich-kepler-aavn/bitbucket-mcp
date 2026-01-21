# Bitbucket MCP Server - Tools Reference

This document lists all tools supported by the Bitbucket MCP Server, organized by category.

## Table of Contents

- [Repository Tools](#repository-tools)
- [Pull Request Tools](#pull-request-tools)
- [Comment Tools](#comment-tools)
- [Task Tools](#task-tools)
- [Branching Model Tools](#branching-model-tools)
- [Pipeline Tools](#pipeline-tools)

## Tools Summary

| Tool Name | Category | Description | Notes |
|-----------|----------|-------------|-------|
| `listRepositories` | Repository | List Bitbucket repositories in a workspace | Supports filtering by name |
| `getRepository` | Repository | Get detailed information about a specific repository | |
| `getEffectiveDefaultReviewers` | Repository | Get effective default reviewers for a repository | |
| `getPullRequests` | Pull Request | List pull requests for a repository | Supports filtering by state |
| `getPullRequest` | Pull Request | Get details for a specific pull request | |
| `createPullRequest` | Pull Request | Create a new pull request | |
| `updatePullRequest` | Pull Request | Update a pull request's title and/or description | |
| `approvePullRequest` | Pull Request | Approve a pull request | |
| `unapprovePullRequest` | Pull Request | Remove approval from a pull request | |
| `declinePullRequest` | Pull Request | Decline a pull request | |
| `mergePullRequest` | Pull Request | Merge a pull request | Supports merge strategies |
| `getPullRequestActivity` | Pull Request | Get activity log for a pull request | |
| `getPullRequestDiff` | Pull Request | Get diff for a pull request | |
| `getPullRequestCommits` | Pull Request | Get commits included in a pull request | |
| `getPullRequestDiffStat` | Pull Request | Get diff statistics for a pull request | |
| `getPullRequestPatch` | Pull Request | Get unified patch/diff for a pull request | |
| `getPullRequestStatuses` | Pull Request | List commit statuses associated with a pull request | |
| `createDraftPullRequest` | Pull Request | Create a new draft pull request | |
| `publishDraftPullRequest` | Pull Request | Publish a draft pull request to make it ready for review | |
| `convertTodraft` | Pull Request | Convert a regular pull request to draft status | |
| `getPendingReviewPRs` | Pull Request | List open PRs where user is a reviewer and hasn't approved | |
| `getPullRequestComments` | Comment | List comments on a pull request | |
| `getPullRequestComment` | Comment | Get a specific comment on a pull request | |
| `addPullRequestComment` | Comment | Add a comment to a pull request (general or inline) | |
| `addPendingPullRequestComment` | Comment | Add a pending (draft) comment to a pull request | |
| `publishPendingComments` | Comment | Publish all pending comments for a pull request | |
| `updatePullRequestComment` | Comment | Update a comment on a pull request | |
| `deletePullRequestComment` | Comment | Delete a comment on a pull request | ⚠️ Dangerous |
| `resolveComment` | Comment | Resolve a comment thread on a pull request | |
| `reopenComment` | Comment | Reopen a resolved comment thread on a pull request | |
| `getPullRequestTasks` | Task | List tasks on a pull request | |
| `getPullRequestTask` | Task | Get a specific task on a pull request | |
| `createPullRequestTask` | Task | Create a task on a pull request | |
| `updatePullRequestTask` | Task | Update a task on a pull request | |
| `deletePullRequestTask` | Task | Delete a task from a pull request | ⚠️ Dangerous |
| `getRepositoryBranchingModel` | Branching Model | Get the branching model for a repository | |
| `getRepositoryBranchingModelSettings` | Branching Model | Get the branching model configuration for a repository | |
| `updateRepositoryBranchingModelSettings` | Branching Model | Update the branching model configuration for a repository | |
| `getEffectiveRepositoryBranchingModel` | Branching Model | Get the effective branching model for a repository | |
| `getProjectBranchingModel` | Branching Model | Get the branching model for a project | |
| `getProjectBranchingModelSettings` | Branching Model | Get the branching model configuration for a project | |
| `updateProjectBranchingModelSettings` | Branching Model | Update the branching model configuration for a project | |
| `listPipelineRuns` | Pipeline | List pipeline runs for a repository | Supports filtering by status/branch/trigger |
| `getPipelineRun` | Pipeline | Get details for a specific pipeline run | |
| `runPipeline` | Pipeline | Trigger a new pipeline run | |
| `stopPipeline` | Pipeline | Stop a running pipeline | |
| `getPipelineSteps` | Pipeline | List steps for a pipeline run | |
| `getPipelineStep` | Pipeline | Get details for a specific pipeline step | |
| `getPipelineStepLogs` | Pipeline | Get logs for a specific pipeline step | Supports filtering and search |

**Total: 46 tools**

⚠️ **Dangerous Tools**: Tools marked with ⚠️ require `BITBUCKET_ENABLE_DANGEROUS=true` to be enabled.

## Common Parameters

Many tools share common parameters:

- **workspace** (string): Bitbucket workspace name. Can be omitted if `BITBUCKET_WORKSPACE` is configured.
- **repo_slug** (string): Repository slug/name
- **pull_request_id** (string): Pull request ID/number
- **pagelen** (number, optional): Number of items per page (1-100, default: 30)
- **page** (number, optional): Page number to fetch (1-based)
- **all** (boolean, optional): When true, automatically follows pagination links to return all items (up to 10,000)
- **limit** (number, optional): Deprecated alias for `pagelen`. Use `pagelen`/`page`/`all` instead.

---

## Repository Tools

### listRepositories

List Bitbucket repositories in a workspace.

**Parameters:**
- `workspace` (string, optional): Workspace name
- `name` (string, optional): Filter repositories by name (partial match supported)
- `pagelen` (number, optional): Items per page
- `page` (number, optional): Page number
- `all` (boolean, optional): Return all items
- `limit` (number, optional): Deprecated alias for pagelen

**Example:**
```json
{
  "workspace": "my-workspace",
  "name": "api",
  "all": true
}
```

---

### getRepository

Get detailed information about a specific repository.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo"
}
```

---

### getEffectiveDefaultReviewers

Get effective default reviewers for a repository (inherited from project/workspace settings).

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo"
}
```

---

## Pull Request Tools

### getPullRequests

List pull requests for a repository.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `state` (string, optional): Filter by state - `OPEN`, `MERGED`, `DECLINED`, or `SUPERSEDED`
- `pagelen` (number, optional): Items per page
- `page` (number, optional): Page number
- `all` (boolean, optional): Return all items
- `limit` (number, optional): Deprecated alias for pagelen

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "state": "OPEN",
  "all": true
}
```

---

### getPullRequest

Get details for a specific pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `pagelen` (number, optional): Items per page
- `page` (number, optional): Page number
- `all` (boolean, optional): Return all items

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123"
}
```

---

### createPullRequest

Create a new pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `title` (string, required): Pull request title
- `description` (string, required): Pull request description
- `sourceBranch` (string, required): Source branch name
- `targetBranch` (string, required): Target branch name
- `reviewers` (array of strings, optional): List of reviewer UUIDs (e.g., `["{04776764-62c7-453b-b97e-302f60395ceb}"]`)
- `draft` (boolean, optional): Whether to create as a draft

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "title": "Add new feature",
  "description": "This PR adds a new feature",
  "sourceBranch": "feature/new-feature",
  "targetBranch": "main",
  "draft": false
}
```

---

### updatePullRequest

Update a pull request's title and/or description.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `title` (string, optional): New title
- `description` (string, optional): New description

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123",
  "title": "Updated title"
}
```

---

### approvePullRequest

Approve a pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `pagelen` (number, optional): Items per page
- `page` (number, optional): Page number
- `all` (boolean, optional): Return all items

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123"
}
```

---

### unapprovePullRequest

Remove approval from a pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `pagelen` (number, optional): Items per page
- `page` (number, optional): Page number
- `all` (boolean, optional): Return all items

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123"
}
```

---

### declinePullRequest

Decline a pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `message` (string, optional): Reason for declining

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123",
  "message": "Needs more work"
}
```

---

### mergePullRequest

Merge a pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `message` (string, optional): Merge commit message
- `strategy` (string, optional): Merge strategy - `merge-commit`, `squash`, or `fast-forward`

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123",
  "strategy": "squash"
}
```

---

### getPullRequestActivity

Get activity log for a pull request (all events: comments, approvals, updates, etc.).

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `pagelen` (number, optional): Items per page
- `page` (number, optional): Page number
- `all` (boolean, optional): Return all items

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123",
  "all": true
}
```

---

### getPullRequestDiff

Get diff for a pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123"
}
```

---

### getPullRequestCommits

Get commits included in a pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `pagelen` (number, optional): Items per page
- `page` (number, optional): Page number
- `all` (boolean, optional): Return all items

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123"
}
```

---

### getPullRequestDiffStat

Get diff statistics for a pull request (files changed, additions, deletions).

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123"
}
```

---

### getPullRequestPatch

Get unified patch/diff for a pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123"
}
```

---

### getPullRequestStatuses

List commit statuses (CI/CD checks) associated with a pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123"
}
```

---

### createDraftPullRequest

Create a new draft pull request (same as `createPullRequest` with `draft: true`).

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `title` (string, required): Pull request title
- `description` (string, required): Pull request description
- `sourceBranch` (string, required): Source branch name
- `targetBranch` (string, required): Target branch name
- `reviewers` (array of strings, optional): List of reviewer UUIDs

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "title": "WIP: New feature",
  "description": "Work in progress",
  "sourceBranch": "feature/new-feature",
  "targetBranch": "main"
}
```

---

### publishDraftPullRequest

Publish a draft pull request to make it ready for review.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123"
}
```

---

### convertTodraft

Convert a regular pull request to draft status.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123"
}
```

---

### getPendingReviewPRs

List all open pull requests in the workspace where the authenticated user is a reviewer and has not yet approved.

**Parameters:**
- `workspace` (string, optional): Workspace name (defaults to `BITBUCKET_WORKSPACE`)
- `limit` (number, optional): Maximum number of PRs to return
- `repositoryList` (array of strings, optional): List of repository slugs to check

**Example:**
```json
{
  "workspace": "my-workspace",
  "limit": 50
}
```

---

## Comment Tools

### getPullRequestComments

List comments on a pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `pagelen` (number, optional): Items per page
- `page` (number, optional): Page number
- `all` (boolean, optional): Return all items

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123",
  "all": true
}
```

---

### getPullRequestComment

Get a specific comment on a pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `comment_id` (string, required): Comment ID

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123",
  "comment_id": "456"
}
```

---

### addPullRequestComment

Add a comment to a pull request (general or inline).

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `content` (string, required): Comment content in markdown format
- `pending` (boolean, optional): Whether to create as a pending comment (draft state)
- `inline` (object, optional): Inline comment information
  - `path` (string, required): Path to the file in the repository
  - `from` (number, optional): Line number in the old version (for deleted/modified lines)
  - `to` (number, optional): Line number in the new version (for added/modified lines)

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123",
  "content": "Great work!",
  "inline": {
    "path": "src/index.ts",
    "to": 42
  }
}
```

---

### addPendingPullRequestComment

Add a pending (draft) comment to a pull request that can be published later.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `content` (string, required): Comment content in markdown format
- `inline` (object, optional): Inline comment information
  - `path` (string, required): Path to the file
  - `from` (number, optional): Line number in old version
  - `to` (number, optional): Line number in new version

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123",
  "content": "This needs review",
  "inline": {
    "path": "src/index.ts",
    "to": 42
  }
}
```

---

### publishPendingComments

Publish all pending comments for a pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123"
}
```

---

### updatePullRequestComment

Update a comment on a pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `comment_id` (string, required): Comment ID
- `content` (string, required): Updated comment content

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123",
  "comment_id": "456",
  "content": "Updated comment"
}
```

---

### deletePullRequestComment ⚠️ DANGEROUS

Delete a comment on a pull request.

**⚠️ This tool requires `BITBUCKET_ENABLE_DANGEROUS=true` to be enabled.**

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `comment_id` (string, required): Comment ID

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123",
  "comment_id": "456"
}
```

---

### resolveComment

Resolve a comment thread on a pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `comment_id` (string, required): Comment ID (thread root)

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123",
  "comment_id": "456"
}
```

---

### reopenComment

Reopen a resolved comment thread on a pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `comment_id` (string, required): Comment ID (thread root)

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123",
  "comment_id": "456"
}
```

---

## Task Tools

### getPullRequestTasks

List tasks on a pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123"
}
```

---

### getPullRequestTask

Get a specific task on a pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `task_id` (string, required): Task ID

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123",
  "task_id": "789"
}
```

---

### createPullRequestTask

Create a task on a pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `content` (string, required): Task content
- `comment` (number, optional): Optional comment ID to attach the task to
- `state` (string, optional): Initial task state - `OPEN` or `RESOLVED` (default: `OPEN`)

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123",
  "content": "Fix the bug on line 42"
}
```

---

### updatePullRequestTask

Update a task on a pull request.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `task_id` (string, required): Task ID
- `content` (string, optional): Updated task content
- `state` (string, optional): Updated task state - `OPEN` or `RESOLVED`

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123",
  "task_id": "789",
  "state": "RESOLVED"
}
```

---

### deletePullRequestTask ⚠️ DANGEROUS

Delete a task from a pull request.

**⚠️ This tool requires `BITBUCKET_ENABLE_DANGEROUS=true` to be enabled.**

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pull_request_id` (string, required): Pull request ID
- `task_id` (string, required): Task ID

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pull_request_id": "123",
  "task_id": "789"
}
```

---

## Branching Model Tools

### getRepositoryBranchingModel

Get the branching model for a repository.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo"
}
```

---

### getRepositoryBranchingModelSettings

Get the branching model configuration for a repository.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo"
}
```

---

### updateRepositoryBranchingModelSettings

Update the branching model configuration for a repository.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `development` (object, optional): Development branch settings
  - `name` (string): Branch name
  - `use_mainbranch` (boolean): Use main branch
- `production` (object, optional): Production branch settings
  - `name` (string): Branch name
  - `use_mainbranch` (boolean): Use main branch
  - `enabled` (boolean): Enable production branch
- `branch_types` (array, optional): Branch types configuration
  - `kind` (string, required): Branch type kind (e.g., `bugfix`, `feature`)
  - `prefix` (string): Branch prefix
  - `enabled` (boolean): Enable this branch type

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "development": {
    "name": "develop",
    "use_mainbranch": false
  },
  "production": {
    "name": "main",
    "use_mainbranch": true,
    "enabled": true
  },
  "branch_types": [
    {
      "kind": "feature",
      "prefix": "feature/",
      "enabled": true
    }
  ]
}
```

---

### getEffectiveRepositoryBranchingModel

Get the effective branching model for a repository (inherited from project/workspace).

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo"
}
```

---

### getProjectBranchingModel

Get the branching model for a project.

**Parameters:**
- `workspace` (string, required): Workspace name
- `project_key` (string, required): Project key

**Example:**
```json
{
  "workspace": "my-workspace",
  "project_key": "PROJ"
}
```

---

### getProjectBranchingModelSettings

Get the branching model configuration for a project.

**Parameters:**
- `workspace` (string, required): Workspace name
- `project_key` (string, required): Project key

**Example:**
```json
{
  "workspace": "my-workspace",
  "project_key": "PROJ"
}
```

---

### updateProjectBranchingModelSettings

Update the branching model configuration for a project.

**Parameters:**
- `workspace` (string, required): Workspace name
- `project_key` (string, required): Project key
- `development` (object, optional): Development branch settings
  - `name` (string): Branch name
  - `use_mainbranch` (boolean): Use main branch
- `production` (object, optional): Production branch settings
  - `name` (string): Branch name
  - `use_mainbranch` (boolean): Use main branch
  - `enabled` (boolean): Enable production branch
- `branch_types` (array, optional): Branch types configuration
  - `kind` (string, required): Branch type kind (e.g., `bugfix`, `feature`)
  - `prefix` (string): Branch prefix
  - `enabled` (boolean): Enable this branch type

**Example:**
```json
{
  "workspace": "my-workspace",
  "project_key": "PROJ",
  "development": {
    "name": "develop",
    "use_mainbranch": false
  }
}
```

---

## Pipeline Tools

### listPipelineRuns

List pipeline runs for a repository.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `status` (string, optional): Filter by status - `PENDING`, `IN_PROGRESS`, `SUCCESSFUL`, `FAILED`, `ERROR`, `STOPPED`
- `target_branch` (string, optional): Filter by target branch
- `trigger_type` (string, optional): Filter by trigger type - `manual`, `push`, `pullrequest`, `schedule`
- `pagelen` (number, optional): Items per page
- `page` (number, optional): Page number
- `all` (boolean, optional): Return all items
- `limit` (number, optional): Deprecated alias for pagelen

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "status": "FAILED",
  "all": true
}
```

---

### getPipelineRun

Get details for a specific pipeline run.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pipeline_uuid` (string, required): Pipeline UUID
- `pagelen` (number, optional): Items per page
- `page` (number, optional): Page number
- `all` (boolean, optional): Return all items

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pipeline_uuid": "abc123-def456"
}
```

---

### runPipeline

Trigger a new pipeline run.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `target` (object, required): Pipeline target configuration
  - `ref_type` (string, required): Reference type - `branch`, `tag`, `bookmark`, `named_branch`
  - `ref_name` (string, required): Reference name (branch, tag, etc.)
  - `commit_hash` (string, optional): Specific commit hash to run pipeline on
  - `selector_type` (string, optional): Pipeline selector type - `default`, `custom`, `pull-requests`
  - `selector_pattern` (string, optional): Pipeline selector pattern (for custom pipelines)
- `variables` (array, optional): Pipeline variables
  - `key` (string, required): Variable name
  - `value` (string, required): Variable value
  - `secured` (boolean, optional): Whether the variable is secured

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "target": {
    "ref_type": "branch",
    "ref_name": "main"
  },
  "variables": [
    {
      "key": "ENV",
      "value": "production"
    }
  ]
}
```

---

### stopPipeline

Stop a running pipeline.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pipeline_uuid` (string, required): Pipeline UUID

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pipeline_uuid": "abc123-def456"
}
```

---

### getPipelineSteps

List steps for a pipeline run.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pipeline_uuid` (string, required): Pipeline UUID

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pipeline_uuid": "abc123-def456"
}
```

---

### getPipelineStep

Get details for a specific pipeline step.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pipeline_uuid` (string, required): Pipeline UUID
- `step_uuid` (string, required): Step UUID

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pipeline_uuid": "abc123-def456",
  "step_uuid": "step-789"
}
```

---

### getPipelineStepLogs

Get logs for a specific pipeline step.

**Parameters:**
- `workspace` (string, required): Workspace name
- `repo_slug` (string, required): Repository slug
- `pipeline_uuid` (string, required): Pipeline UUID
- `step_uuid` (string, required): Step UUID
- `max_lines` (number, optional): Maximum number of log lines to return (1-5000, default: 500)
- `tail` (boolean, optional): When true, returns the most recent lines instead of the first lines
- `errors_only` (boolean, optional): When true, only include lines that look like errors
- `search_term` (string, optional): Case-insensitive search term to filter log lines
- `save_to_file` (boolean, optional): Save the full log to a temporary file and return the path

**Example:**
```json
{
  "workspace": "my-workspace",
  "repo_slug": "my-repo",
  "pipeline_uuid": "abc123-def456",
  "step_uuid": "step-789",
  "max_lines": 1000,
  "errors_only": true
}
```

---

## Notes

### Dangerous Tools

Some tools are marked as "dangerous" and require `BITBUCKET_ENABLE_DANGEROUS=true` to be enabled:

- `deletePullRequestComment` - Permanently deletes comments
- `deletePullRequestTask` - Permanently deletes tasks
- Any tool with a name starting with `delete` (case-insensitive)

### Pagination

Most list endpoints support pagination:

- Use `pagelen` and `page` for manual pagination
- Use `all: true` to automatically fetch all items (up to 10,000)
- The deprecated `limit` parameter is an alias for `pagelen`

### Workspace Parameter

The `workspace` parameter can often be omitted if `BITBUCKET_WORKSPACE` is configured in your environment or MCP client configuration.

### Authentication

All tools require proper authentication. Configure your credentials via:
- MCP client configuration (recommended)
- Environment variables (`BITBUCKET_TOKEN`, `BITBUCKET_USERNAME`, etc.)

See `CLIENT_CONFIG_GUIDE.md` for detailed configuration instructions.
