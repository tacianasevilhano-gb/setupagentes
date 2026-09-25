# setupagentes

Scripts and guidance for configuring Cursor Cloud Agents with internal tools.

## Kanbanize / Businessmap

Configures API access to the Grupo Boticário Businessmap (Kanbanize) account and prepares the Businessmap MCP server.

### Prerequisites

- PowerShell 5.1+ (Windows nativo) **ou** PowerShell 7+ (`pwsh`)
- Node.js 22+ (for the optional MCP package)
- Variável/secret `KANBANIZE_API_KEY`

### Setup no Windows

O erro `O termo 'pwsh' não é reconhecido` significa que o PowerShell 7 não está instalado. Use o PowerShell nativo:

```powershell
# 1) Defina a API key nesta sessão (ou use o secret do ambiente)
$env:KANBANIZE_API_KEY = "sua-chave"

# 2) A partir da pasta do repositório
cd caminho\para\setupagentes
.\kanbanize\setup.cmd
```

Ou, manualmente com Windows PowerShell 5.1:

```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config\kanbanize" | Out-Null
Copy-Item .\kanbanize\setup.ps1 "$env:USERPROFILE\.config\kanbanize\setup.ps1" -Force
powershell -NoProfile -ExecutionPolicy Bypass -File "$env:USERPROFILE\.config\kanbanize\setup.ps1"
```

Opcional — instalar PowerShell 7 e usar `pwsh`:

```powershell
winget install --id Microsoft.PowerShell -e
# Feche e reabra o terminal, depois:
pwsh -NoProfile -File "$env:USERPROFILE\.config\kanbanize\setup.ps1"
```

### Setup no Linux / macOS / Cloud Agent

```bash
mkdir -p ~/.config/kanbanize
cp kanbanize/setup.ps1 ~/.config/kanbanize/setup.ps1
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
| `~/.config/kanbanize/.env` | API token + Businessmap env vars (mode 600 on Unix) |
| `~/.config/kanbanize/mcp.snippet.json` | Ready-to-paste MCP client snippet |
| `~/.config/kanbanize/setup.ps1` | Idempotent launcher |

No Windows o diretório equivalente é `%USERPROFILE%\.config\kanbanize\`.

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
