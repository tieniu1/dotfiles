# Neovim AI 工具使用指南

## 前置准备

```bash
# 1. 设置环境变量（加到 ~/.zshrc.local）
export OPENROUTER_API_KEY="你的key"
export OPENAI_API_KEY="你的key"   # avante 读这个变量

# 2. 创建 mcphub 配置文件
mkdir -p ~/.config/mcphub
echo '{"mcpServers": {}}' > ~/.config/mcphub/servers.json

# 3. 打开 nvim，安装插件
# nvim 启动后执行
:Lazy sync
```

## 1. minuet-ai.nvim — 实时代码补全

打字时自动给出补全建议，以灰色虚拟文本（ghost text）显示在光标后面。

**触发方式：** 正常写代码，自动触发。

| 按键 | 功能 |
|------|------|
| `Alt+A` | 接受完整补全 |
| `Alt+a` | 只接受当前行 |
| `Alt+]` | 下一个建议 |
| `Alt+[` | 上一个建议 |
| `Alt+e` | 关闭当前建议 |

> macOS 终端下 `Alt` 键需要终端支持 Meta 键。iTerm2: Preferences → Profiles → Keys，把 Left Option 改为 `Esc+`。

## 2. avante.nvim — AI 对话 & 代码重写

主力 AI 工具，类似 Cursor 的体验。

### 常用命令

| 命令 / 快捷键 | 功能 |
|---------------|------|
| `:AvanteAsk` / `<leader>aa` | 打开 AI 对话侧边栏 |
| `:AvanteEdit` / `<leader>ae` | 对选中代码进行编辑指令 |
| `:AvanteToggle` / `<leader>at` | 切换侧边栏显示/隐藏 |
| `:AvanteClear` | 清空当前对话 |
| `:AvanteRefresh` | 刷新 |

### 典型工作流

1. **问问题** — `<leader>aa`，输入问题，如"这个函数在做什么？"
2. **重写代码** — 选中代码（V 模式），`<leader>ae`，输入指令如"改成 async/await"
3. **应用修改** — avante 显示 diff，选择接受或拒绝

### 对话窗口按键

| 按键 | 功能 |
|------|------|
| `<CR>` | 发送消息 |
| `q` | 关闭侧边栏 |
| `<Tab>` | 在对话窗口和编辑区之间切换 |

当前配置了 `mode = "agentic"`，AI 可自主调用工具（通过 mcphub）读取项目文件、搜索代码，不需要手动粘贴上下文。

## 3. mcphub.nvim — MCP 工具中心

avante 的"工具箱"，让 AI 能调用外部工具。

### 管理界面

```
:MCPHub
```

### 添加 MCP 服务器

编辑 `~/.config/mcphub/servers.json`：

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/Users/haland"]
    }
  }
}
```

保存后自动加载，不需要重启 nvim。

在 avante 对话中可用 `/` 触发 mcphub 注册的 slash commands。

## 快速验证

1. `:Lazy` — 确认三个插件都已安装
2. `:checkhealth mcphub` — 检查 mcphub 是否正常
3. 打开代码文件开始打字 — 看是否出现 ghost text 补全
4. `<leader>aa` — 看 avante 侧边栏是否能正常对话
