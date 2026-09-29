@echo off
setlocal EnableExtensions

REM Launcher Windows: usa pwsh se existir; senao PowerShell 5.1.
REM Uso:
REM   kanbanize\setup.cmd
REM   set KANBANIZE_API_KEY=... && kanbanize\setup.cmd

set "SCRIPT_DIR=%~dp0"
set "TARGET_DIR=%USERPROFILE%\.config\kanbanize"
set "TARGET_SCRIPT=%TARGET_DIR%\setup.ps1"

if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"
copy /Y "%SCRIPT_DIR%setup.ps1" "%TARGET_SCRIPT%" >nul

where pwsh >nul 2>&1
if %ERRORLEVEL%==0 (
  pwsh -NoProfile -ExecutionPolicy Bypass -File "%TARGET_SCRIPT%" %*
  exit /b %ERRORLEVEL%
)

where powershell >nul 2>&1
if %ERRORLEVEL%==0 (
  echo !! pwsh nao encontrado; usando Windows PowerShell 5.1
  echo !! Opcional: winget install --id Microsoft.PowerShell -e
  powershell -NoProfile -ExecutionPolicy Bypass -File "%TARGET_SCRIPT%" %*
  exit /b %ERRORLEVEL%
)

echo ERRO: nem pwsh nem powershell foram encontrados no PATH.
exit /b 1
