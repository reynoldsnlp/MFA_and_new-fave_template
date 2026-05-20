$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

if (-not (Get-Command pixi -ErrorAction SilentlyContinue)) {
  (Invoke-WebRequest -Uri https://pixi.sh/install.ps1 -UseBasicParsing).Content | Invoke-Expression
  $env:PATH = "$(Join-Path $env:USERPROFILE '.pixi\bin');$env:PATH"
}

Set-Location $ScriptDir
pixi run python toy_import_check.py
