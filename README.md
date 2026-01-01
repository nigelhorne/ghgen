# GHGen GitHub Action

Automatically analyze and optimize your GitHub Actions workflows using [GHGen](https://github.com/your-org/ghgen).

## Features

- 🔍 **Analyze workflows** for performance, security, and cost issues
- 💬 **Comment on PRs** with optimization suggestions
- 🤖 **Auto-fix issues** automatically
- 🔄 **Create PRs** with improvements
- 💰 **Estimate savings** in CI minutes and costs

## Usage

### Mode 1: Comment on PRs

Add workflow analysis comments to pull requests that modify workflows:

```yaml
name: Analyze Workflows

on:
  pull_request:
    paths:
      - '.github/workflows/**'

permissions:
  contents: read
  pull-requests: write

jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6
      
      - name: Analyze workflows
        uses: your-org/ghgen-action@v1
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          mode: comment
```

This will post a comment like:

> ## 🔍 GHGen Workflow Analysis
>
> | Category | Count | Auto-fixable |
> |----------|-------|--------------|
> | ⚡ Performance | 2 | 2 |
> | 🔒 Security | 1 | 1 |
> | 💰 Cost | 1 | 1 |
>
> ### 💰 Potential Savings
> - ⏱️ Save **~650 CI minutes/month**
> - 💵 Save **~$5/month** (private repos)

### Mode 2: Auto-Fix and Create PR

Automatically fix issues and create a PR (great for scheduled runs):

```yaml
name: Weekly Workflow Optimization

on:
  schedule:
    - cron: '0 9 * * 1'  # Monday 9am
  workflow_dispatch:

permissions:
  contents: write
  pull-requests: write

jobs:
  optimize:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6
      
      - name: Optimize workflows
        uses: your-org/ghgen-action@v1
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          auto-fix: true
          create-pr: true
```

### Mode 3: CI Check (Fail on Issues)

Require workflows to pass analysis before merging:

```yaml
name: Workflow Quality Check

on:
  pull_request:
    paths:
      - '.github/workflows/**'

permissions:
  contents: read

jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6
      
      - name: Check workflows
        id: check
        uses: your-org/ghgen-action@v1
      
      - name: Fail if issues found
        if: steps.check.outputs.issues-found > 0
        run: exit 1
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `github-token` | GitHub token for API access | Yes | `${{ github.token }}` |
| `mode` | Action mode: `comment`, `check`, or `auto-fix` | No | `comment` |
| `auto-fix` | Automatically fix issues | No | `false` |
| `create-pr` | Create PR with fixes | No | `false` |
| `perl-version` | Perl version to use | No | `5.40` |

## Outputs

| Output | Description |
|--------|-------------|
| `issues-found` | Number of issues found |
| `fixes-applied` | Number of fixes applied |
| `comment-url` | URL of created comment (if any) |

## What It Checks

- ✅ **Missing dependency caching** - Adds appropriate caching for npm, pip, cargo, etc.
- ✅ **Unpinned action versions** - Updates `@master` to specific versions
- ✅ **Outdated actions** - Updates to latest versions (v4→v5, v5→v6)
- ✅ **Missing permissions** - Adds `permissions: contents: read` for security
- ✅ **Missing concurrency** - Adds concurrency groups to cancel old runs
- ✅ **Overly broad triggers** - Suggests branch/path filters
- ✅ **Outdated runners** - Updates to latest runner versions

## Example Output

When issues are found, the action will:

1. **Analyze** your workflows
2. **Estimate savings** in CI minutes and costs
3. **Suggest fixes** with code examples
4. **Optionally fix** issues automatically
5. **Create a PR** with improvements

## Advanced Configuration

### Custom Comment Format

```yaml
- uses: your-org/ghgen-action@v1
  with:
    mode: comment
    github-token: ${{ secrets.GITHUB_TOKEN }}
```

### Run on Specific Files

```yaml
on:
  pull_request:
    paths:
      - '.github/workflows/ci.yml'
      - '.github/workflows/deploy.yml'
```

### Auto-Fix Only Specific Types

Currently auto-fixes all detectable issues. Future versions will support:

```yaml
- uses: your-org/ghgen-action@v1
  with:
    auto-fix: true
    fix-types: 'performance,security'  # Coming soon
```

## Requirements

- GitHub Actions runner with bash
- Perl 5.36+ (automatically installed)
- Write permissions (for auto-fix/PR modes)

## Troubleshooting

### "Permission denied" errors

Make sure you have the correct permissions:

```yaml
permissions:
  contents: write        # For auto-fix
  pull-requests: write   # For comments
```

### Action fails to install dependencies

Check that the runner has internet access and can reach CPAN.

### No issues found but you expect some

Make sure you're running from the repository root and `.github/workflows/` exists.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development setup and guidelines.

## License

This action is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

## Links

- [GHGen CLI Tool](https://github.com/your-org/ghgen)
- [Documentation](https://your-org.github.io/ghgen)
- [Issue Tracker](https://github.com/your-org/ghgen/issues)
