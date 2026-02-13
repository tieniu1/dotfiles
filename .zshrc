# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================
# 平台检测
# ============================================
case "$(uname -s)" in
    Darwin)  DOTFILES_PLATFORM="macos" ;;
    Linux)
        if grep -qi microsoft /proc/version 2>/dev/null; then
            DOTFILES_PLATFORM="wsl"
        else
            DOTFILES_PLATFORM="linux"
        fi
        ;;
    *)       DOTFILES_PLATFORM="unknown" ;;
esac

# Dotfiles 路径
export DOTFILES="$HOME/dotfiles"

# ============================================
# Oh My Zsh 配置
# ============================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    colorize
    autojump
)

source $ZSH/oh-my-zsh.sh

# ============================================
# Powerlevel10k
# ============================================
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ============================================
# 加载通用配置
# ============================================
[[ -f "$DOTFILES/common/shell/env.sh" ]] && source "$DOTFILES/common/shell/env.sh"
[[ -f "$DOTFILES/common/shell/aliases.sh" ]] && source "$DOTFILES/common/shell/aliases.sh"
[[ -f "$DOTFILES/common/shell/functions.sh" ]] && source "$DOTFILES/common/shell/functions.sh"

# ============================================
# 加载平台特定配置
# ============================================
if [[ "$DOTFILES_PLATFORM" == "macos" ]]; then
    [[ -f "$DOTFILES/macos/shell/macos.sh" ]] && source "$DOTFILES/macos/shell/macos.sh"
elif [[ "$DOTFILES_PLATFORM" == "wsl" || "$DOTFILES_PLATFORM" == "linux" ]]; then
    [[ -f "$DOTFILES/windows/shell/windows.sh" ]] && source "$DOTFILES/windows/shell/windows.sh"
fi

# ============================================
# 本地配置 (隐私数据)
# ============================================
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# ============================================
# NVM 自动切换
# ============================================
autoload -U add-zsh-hook
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# ============================================
# 其他工具集成
# ============================================
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"



# 智能目录跳转
fcd() {
    local dir="${1:-.}"
    dir=$(fd -t d . "$dir" 2>/dev/null | fzf \
        --preview 'tree -L 1 -C {}' \
        --prompt 'Directory> ') && cd "$dir"
}
# 文件编辑
fe() {
    local file
    file=$(fd -t f . "${1:-.}" 2>/dev/null | fzf \
        --preview 'bat --color=always --line-range :50 {}' \
        --prompt 'File> ') && ${EDITOR:-nvim} "$file"
}
