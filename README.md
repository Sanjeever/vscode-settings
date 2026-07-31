# 我的 VS Code 配置

这是一套面向 AI 辅助开发和代码审查的轻量 VS Code 配置。

我的主要工作方式是让 Codex 完成大部分编码工作，然后使用 VS Code 阅读 diff、审查实现并进行少量修改。因此，这套配置保留了常用语言的导航、诊断和格式化能力，同时减少自动修改、后台扫描和不必要的界面干扰。

## 适用技术栈

- Java、Maven、Spring Boot
- Vue、React
- Node.js、JavaScript、TypeScript
- Go

React、Node.js、JavaScript 和 TypeScript 主要使用 VS Code 内置语言服务，不额外安装重复的语言扩展。

## 外观与交互

| 项目 | 配置 |
| --- | --- |
| 颜色主题 | Vitesse Dark Soft |
| 编辑器字体 | JetBrains Mono |
| 文件图标 | Catppuccin Mocha |
| 产品图标 | Carbon |
| 快捷键 | JetBrains |
| 界面语言 | 简体中文 |

配置开启了 minimap、inlay hints 和 sticky scroll。自动保存与保存时格式化默认关闭，避免代码审查过程中产生意外修改或无关 diff。

## 一键安装

### 1. 获取仓库

```bash
git clone https://github.com/Sanjeever/vscode-settings.git
cd vscode-settings
```

### 2. Windows

使用 PowerShell 7 执行：

```powershell
pwsh -File .\scripts\install.ps1
```

脚本会：

- 将现有用户设置备份为 `settings.json.backup-时间戳`
- 将仓库配置复制到 `%APPDATA%\Code\User\settings.json`
- 读取 `.vscode/extensions.json` 并安装推荐扩展

脚本优先使用 `PATH` 中的 `code` 命令；如果找不到，则尝试 VS Code 默认的用户安装路径。

### 3. macOS

先在 VS Code 命令面板中执行：

```text
Shell Command: Install 'code' command in PATH
```

然后使用 Bash 执行：

```bash
bash ./scripts/install.sh
```

脚本会：

- 将现有用户设置备份为 `settings.json.backup-时间戳`
- 将仓库配置复制到 `~/Library/Application Support/Code/User/settings.json`
- 读取 `.vscode/extensions.json` 并安装推荐扩展

两个脚本都会完整替换原有的 `settings.json`，不会修改快捷键、`argv.json`、SSH 配置或其他用户数据。

`.vscode/extensions.json` 只列出主动选择的扩展。Remote SSH 需要的 `Remote - SSH: Editing Configuration Files` 和 `Remote Explorer` 会作为依赖自动安装。

## 手动安装

如果不想运行脚本，可以使用 VS Code 打开仓库：

```bash
code .
```

打开扩展视图后执行 `Extensions: Show Recommended Extensions`，安装工作区推荐的扩展。

若要将仓库设置作为全局用户配置使用，请手动复制 `.vscode/settings.json`。

Windows：

```text
%APPDATA%\Code\User\settings.json
```

macOS：

```text
~/Library/Application Support/Code/User/settings.json
```

## 设置中文界面

安装简体中文语言包后，在命令面板中执行：

```text
Configure Display Language
```

选择 `zh-cn`，然后重新启动 VS Code。显示语言属于机器级运行参数，因此没有将 `argv.json` 放入本仓库。

## 跨平台说明

配置中不包含 JDK、Maven、Go、终端或字体的本机绝对路径。

- Windows 和 macOS 应分别安装 JetBrains Mono。
- Java 项目通过各平台的 `JAVA_HOME` 或项目配置选择 JDK。
- Maven 项目优先使用仓库内的 Maven Wrapper。
- Go 工具链通过各平台的 `PATH` 管理。
- VS Code Settings Sync 可继续用于个人设备之间的日常同步，本仓库只发布经过检查的公开配置快照。

## 隐私与安全

本仓库刻意不包含：

- API Key、Token、密码和其他凭据
- SSH 主机、用户名和私钥配置
- 本机代理地址
- 本地项目路径
- JDK、Maven 等工具的绝对路径
- `argv.json`、`globalStorage`、`workspaceStorage` 和扩展缓存

不要直接把整个 VS Code 用户目录复制到公开仓库。更新本仓库前，应检查配置 diff，确认没有引入机器信息或凭据。

## License

[MIT](LICENSE)
