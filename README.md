# setupagentes

Scripts and guidance for configuring Cursor Cloud Agents with internal tools.

## Kanbanize / Businessmap

Configures API access to the Grupo Boticário Businessmap (Kanbanize) account and prepares the Businessmap MCP server.

### Prerequisites

- PowerShell 7+ (`pwsh`)
- Node.js 22+ (for the optional MCP package)
- Secret `KANBANIZE_API_KEY` injected in the Cloud Agent environment

### Setup

```bash
# From the repo (first time)
mkdir -p ~/.config/kanbanize
cp kanbanize/setup.ps1 ~/.config/kanbanize/setup.ps1

# Run
pwsh -NoProfile -File ~/.config/kanbanize/setup.ps1
```

Optional: also install the MCP package into `~/.npm-global`:

```bash
KANBANIZE_INSTALL_MCP=1 pwsh -NoProfile -File ~/.config/kanbanize/setup.ps1
export PATH="$HOME/.npm-global/bin:$PATH"
```

### What it writes

| Path | Contents |
| --- | --- |
| `~/.config/kanbanize/config.json` | Non-secret account metadata |
| `~/.config/kanbanize/.env` | API token + Businessmap env vars (mode 600) |
| `~/.config/kanbanize/mcp.snippet.json` | Ready-to-paste MCP client snippet |
| `~/.config/kanbanize/setup.ps1` | Idempotent launcher |

### Environment variables

| Name | Required | Default |
| --- | --- | --- |
| `KANBANIZE_API_KEY` | yes | — |
| `KANBANIZE_SUBDOMAIN` | no | `grupoboticario` |
| `KANBANIZE_API_URL` / `BUSINESSMAP_API_URL` | no | `https://<subdomain>.kanbanize.com/api/v2` |
| `BUSINESSMAP_READ_ONLY_MODE` | no | `false` |
| `BUSINESSMAP_TOOL_PROFILE` | no | `essential` |
| `BUSINESSMAP_DEFAULT_WORKSPACE_ID` | no | unset |
| `KANBANIZE_INSTALL_MCP` | no | unset |
