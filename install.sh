#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 检测平台
detect_platform() {
    case "$(uname -s)" in
        Darwin)  echo "macos" ;;
        Linux)
            if grep -qi microsoft /proc/version 2>/dev/null; then
                echo "wsl"
            else
                echo "linux"
            fi
            ;;
        *)       echo "unknown" ;;
    esac
}

PLATFORM=$(detect_platform)

# 创建符号链接
create_symlink() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo -e "${YELLOW}Backing up: $dest -> ${dest}.backup${NC}"
        mv "$dest" "${dest}.backup"
    fi

    [ -L "$dest" ] && rm "$dest"

    ln -s "$src" "$dest"
    echo -e "${GREEN}Linked: $dest -> $src${NC}"
}

# 链接目录内容
link_directory_contents() {
    local src_dir="$1"
    local dest_dir="$2"

    # 如果目标是断开的符号链接，先删除
    [ -L "$dest_dir" ] && rm "$dest_dir"

    mkdir -p "$dest_dir"

    for item in "$src_dir"/*; do
        [ -e "$item" ] || continue
        local name=$(basename "$item")
        [ "$name" = ".DS_Store" ] && continue
        create_symlink "$item" "$dest_dir/$name"
    done
}

# 安装通用配置
install_common() {
    echo -e "\n${GREEN}=== 安装通用配置 ===${NC}"

    # Shell 配置
    create_symlink "$DOTFILES/.zshrc" "$HOME/.zshrc"
    create_symlink "$DOTFILES/.p10k.zsh" "$HOME/.p10k.zsh"

    # Tmux
    create_symlink "$DOTFILES/common/tmux/tmux.conf" "$HOME/.tmux.conf"
    [ -f "$DOTFILES/common/tmux/tmux.conf.local" ] && \
        create_symlink "$DOTFILES/common/tmux/tmux.conf.local" "$HOME/.tmux.conf.local"

    # Neovim
    link_directory_contents "$DOTFILES/common/nvim" "$HOME/.config/nvim"

    # Neovim 多配置 (NVIM_APPNAME)
    [ -d "$DOTFILES/common/nvim-lazyvim" ] && \
        create_symlink "$DOTFILES/common/nvim-lazyvim" "$HOME/.config/nvim-lazyvim"
    [ -d "$DOTFILES/archive/nvim-v3" ] && \
        create_symlink "$DOTFILES/archive/nvim-v3" "$HOME/.config/nvim-v3"
    [ -d "$DOTFILES/archive/nvim-react" ] && \
        create_symlink "$DOTFILES/archive/nvim-react" "$HOME/.config/nvim-react"

    # Yazi
    link_directory_contents "$DOTFILES/common/yazi" "$HOME/.config/yazi"

    # Htop
    link_directory_contents "$DOTFILES/common/htop" "$HOME/.config/htop"
}

# 安装 macOS 配置
install_macos() {
    echo -e "\n${GREEN}=== 安装 macOS 配置 ===${NC}"

    # Aerospace
    link_directory_contents "$DOTFILES/macos/aerospace" "$HOME/.config/aerospace"

    # Karabiner
    link_directory_contents "$DOTFILES/macos/karabiner" "$HOME/.config/karabiner"

    # Kitty
    link_directory_contents "$DOTFILES/macos/kitty" "$HOME/.config/kitty"
}

# 安装 WSL/Linux 配置
install_linux() {
    echo -e "\n${GREEN}=== 安装 Linux/WSL 配置 ===${NC}"
    echo "暂无 Linux 专用配置"
}

# 处理本地配置模板
setup_local_config() {
    local template="$DOTFILES/.zshrc.local.template"
    local target="$DOTFILES/.zshrc.local"

    if [ ! -f "$target" ] && [ -f "$template" ]; then
        cp "$template" "$target"
        echo -e "${YELLOW}Created .zshrc.local from template${NC}"
        echo -e "${RED}Please edit $target to add your private info${NC}"
    fi

    [ -f "$target" ] && create_symlink "$target" "$HOME/.zshrc.local"
}

# 主函数
main() {
    echo -e "${GREEN}Dotfiles 安装脚本${NC}"
    echo -e "检测到平台: ${YELLOW}$PLATFORM${NC}\n"

    install_common
    setup_local_config

    case "$PLATFORM" in
        macos)  install_macos ;;
        wsl|linux) install_linux ;;
        *)      echo -e "${RED}未知平台，跳过平台特定配置${NC}" ;;
    esac

    echo -e "\n${GREEN}安装完成!${NC}"
}

main
