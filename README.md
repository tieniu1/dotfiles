# Dotfiles

跨平台配置文件管理，支持 macOS 和 Linux/WSL。

## 目录结构

```
dotfiles/
├── common/                 # 跨平台通用配置
│   ├── nvim/               # Neovim
│   ├── yazi/               # 文件管理器
│   ├── htop/               # 系统监控
│   ├── shell/              # Shell 配置
│   └── tmux/               # Tmux
├── macos/                  # macOS 专用
│   ├── aerospace/          # 窗口管理器
│   ├── karabiner/          # 键盘映射
│   ├── kitty/              # 终端
│   └── shell/
├── windows/                # WSL 专用
│   └── shell/
├── .zshrc                  # Zsh 主配置
├── .p10k.zsh               # Powerlevel10k 主题
└── install.sh              # 安装脚本
```

## 快速开始

### 1. 克隆仓库

```bash
git clone https://github.com/tieniu1/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. 安装依赖

**macOS:**

```bash
# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

# Zsh 插件
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# 其他工具 (可选)
brew install neovim yazi htop autojump
```

### 3. 运行安装脚本

```bash
chmod +x install.sh
./install.sh
```

### 4. 创建本地配置

```bash
cp .zshrc.local.template .zshrc.local
# 编辑 .zshrc.local 添加私密配置
```

## 平台检测

脚本会自动检测平台并加载对应配置：

| 平台 | 检测方式 | 加载配置 |
|------|----------|----------|
| macOS | `uname -s` = Darwin | `macos/shell/macos.sh` |
| WSL | `/proc/version` 包含 microsoft | `windows/shell/windows.sh` |
| Linux | 其他 Linux | `windows/shell/windows.sh` |

## 注意事项

1. **首次安装前**：确保已安装 Oh My Zsh 和 Powerlevel10k
2. **备份**：脚本会自动备份已存在的配置文件到 `*.backup`
3. **私密配置**：API 密钥等敏感信息放在 `.zshrc.local`（已被 gitignore）
4. **重新安装**：可多次运行 `./install.sh`，会自动更新链接

## 包含的工具配置

- **Neovim** - 编辑器
- **Tmux** - 终端复用
- **Yazi** - 文件管理器
- **Htop** - 系统监控
- **Kitty** - 终端模拟器 (macOS)
- **Aerospace** - 窗口管理 (macOS)
- **Karabiner** - 键盘映射 (macOS)

## 常用命令

```bash
# 代理开关
proxy      # 开启代理
noproxy    # 关闭代理
testproxy  # 测试代理

# Neovim 配置切换
nvim-lazy   # LazyVim 配置
nvim-v3     # V3 配置
nvim-react  # React 配置
```
