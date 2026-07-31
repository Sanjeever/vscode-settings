$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$sourceSettings = Join-Path $repoRoot '.vscode\settings.json'
$sourceExtensions = Join-Path $repoRoot '.vscode\extensions.json'
$userDirectory = Join-Path $env:APPDATA 'Code\User'
$targetSettings = Join-Path $userDirectory 'settings.json'

if (-not (Test-Path -LiteralPath $sourceSettings)) {
  throw "找不到配置文件：$sourceSettings"
}

if (-not (Test-Path -LiteralPath $sourceExtensions)) {
  throw "找不到扩展列表：$sourceExtensions"
}

$codeCommand = Get-Command code -ErrorAction SilentlyContinue
if ($null -ne $codeCommand) {
  $codePath = $codeCommand.Source
} else {
  $codePath = Join-Path $env:LOCALAPPDATA 'Programs\Microsoft VS Code\bin\code.cmd'
  if (-not (Test-Path -LiteralPath $codePath)) {
    throw "找不到 VS Code CLI。请将 code 加入 PATH，或安装到默认用户目录。"
  }
}

New-Item -ItemType Directory -Path $userDirectory -Force | Out-Null

if (Test-Path -LiteralPath $targetSettings) {
  $timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
  $backupSettings = "$targetSettings.backup-$timestamp"
  Copy-Item -LiteralPath $targetSettings -Destination $backupSettings
  Write-Host "已备份现有设置：$backupSettings"
}

Copy-Item -LiteralPath $sourceSettings -Destination $targetSettings -Force
Write-Host "已应用全局设置：$targetSettings"

$extensions = (Get-Content -LiteralPath $sourceExtensions -Raw | ConvertFrom-Json).recommendations
foreach ($extension in $extensions) {
  Write-Host "安装扩展：$extension"
  & $codePath --install-extension $extension
  if ($LASTEXITCODE -ne 0) {
    throw "扩展安装失败：$extension"
  }
}

Write-Host 'VS Code 全局配置和扩展已应用完成。'
