#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd -- "$script_dir/.." && pwd)"
source_settings="$repo_root/.vscode/settings.json"
source_extensions="$repo_root/.vscode/extensions.json"
user_directory="$HOME/Library/Application Support/Code/User"
target_settings="$user_directory/settings.json"

if [[ ! -f "$source_settings" ]]; then
  echo "找不到配置文件：$source_settings" >&2
  exit 1
fi

if [[ ! -f "$source_extensions" ]]; then
  echo "找不到扩展列表：$source_extensions" >&2
  exit 1
fi

if ! command -v code >/dev/null 2>&1; then
  echo "找不到 VS Code CLI。请先执行 Shell Command: Install 'code' command in PATH。" >&2
  exit 1
fi

mkdir -p "$user_directory"

if [[ -f "$target_settings" ]]; then
  timestamp="$(date '+%Y%m%d-%H%M%S')"
  backup_settings="$target_settings.backup-$timestamp"
  cp "$target_settings" "$backup_settings"
  echo "已备份现有设置：$backup_settings"
fi

cp "$source_settings" "$target_settings"
echo "已应用全局设置：$target_settings"

while IFS= read -r extension; do
  echo "安装扩展：$extension"
  code --install-extension "$extension"
done < <(grep -oE '"[A-Za-z0-9_-]+\.[A-Za-z0-9_.-]+"' "$source_extensions" | tr -d '"')

echo 'VS Code 全局配置和扩展已应用完成。'
