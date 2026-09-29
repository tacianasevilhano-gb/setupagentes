# setupagentes

Scripts and guidance for configuring Cursor Cloud Agents with internal tools.

## Kanbanize / Businessmap

Configures API access to the Grupo Boticário Businessmap (Kanbanize) account and prepares the Businessmap MCP server.

### Prerequisites

- PowerShell 5.1+ (Windows nativo) **ou** PowerShell 7+ (`pwsh`)
- Git (só se for clonar o repositório)
- Variável/secret `KANBANIZE_API_KEY` (Businessmap → My Account → API)

### Setup no Windows (cole estes comandos)

Você precisa estar **fora** de `C:\WINDOWS\system32`. O caminho Unix `~/.config/...` **não funciona** no Windows — use `$env:USERPROFILE\.config\kanbanize\`.

#### Opção A — baixar só o script (mais rápido)

Cole no PowerShell (pode começar em `System32`):

```powershell
$dir = "$env:USERPROFILE\.config\kanbanize"
New-Item -ItemType Directory -Force -Path $dir | Out-Null
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/tacianasevilhano-gb/setupagentes/cursor/kanbanize-credentials-setup-5be9/kanbanize/setup.ps1" -OutFile "$dir\setup.ps1"

$env:KANBANIZE_API_KEY = "cole-sua-chave-aqui"
pwsh -NoProfile -ExecutionPolicy Bypass -File "$dir\setup.ps1"
```

Se `pwsh` não existir, troque a última linha por:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "$dir\setup.ps1"
```

#### Opção B — clonar o repositório

```powershell
cd $env:USERPROFILE
git clone https://github.com/tacianasevilhano-gb/setupagentes.git
cd setupagentes
git fetch origin cursor/kanbanize-credentials-setup-5be9
git checkout cursor/kanbanize-credentials-setup-5be9

$env:KANBANIZE_API_KEY = "cole-sua-chave-aqui"
.\kanbanize\setup.cmd
```

### Setup no Linux / macOS / Cloud Agent

```bash
mkdir -p ~/.config/kanbanize
cp kanbanize/setup.ps1 ~/.config/kanbanize/setup.ps1
export KANBANIZE_API_KEY="sua-chave"
pwsh -NoProfile -File ~/.config/kanbanize/setup.ps1
```

Optional: also install the MCP package into `~/.npm-global`:

```bash
KANBANIZE_INSTALL_MCP=1 pwsh -NoProfile -File ~/.config/kanbanize/setup.ps1
export PATH="$HOME/.npm-global/bin:$PATH"
```

### What it writes

| Path (Linux/macOS) | Path (Windows) | Contents |
| --- | --- | --- |
| `~/.config/kanbanize/config.json` | `%USERPROFILE%\.config\kanbanize\config.json` | Non-secret account metadata |
| `~/.config/kanbanize/.env` | `%USERPROFILE%\.config\kanbanize\.env` | API token + Businessmap env vars |
| `~/.config/kanbanize/mcp.snippet.json` | `%USERPROFILE%\.config\kanbanize\mcp.snippet.json` | MCP client snippet |
| `~/.config/kanbanize/setup.ps1` | `%USERPROFILE%\.config\kanbanize\setup.ps1` | Idempotent launcher |

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
