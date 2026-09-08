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
# Powerlevel10k is loaded explicitly below, so skip OMZ theme loading.
ZSH_THEME=""

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    colorize
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

# CoPaw
export PATH="$HOME/.copaw/bin:$PATH"

# 别名
alias ls='lsd'
alias l='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree'



# yazi
# 使用y命令打开yazi ，它允许在退出 Yazi 时更改当前工作目录
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	cwd
	command yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" # boot up x-cmd.

# opencode
export PATH=/Users/haland/.opencode/bin:$PATH

# bun completions
[ -s "/Users/haland/.bun/_bun" ] && source "/Users/haland/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# zoxide
eval "$(zoxide init zsh)"



# 使用 yt-dlp 下载最高 720p 的中文配音视频
yt-zh() {
    if [ -z "$1" ]; then
        echo "❌ 错误: 请提供视频链接！"
        echo "用法: yt-zh \"视频链接\""
        return 1
    fi
    
    # 终极过滤规则：
    # 1. 视频(bv)不限制语言，只要求音频(ba)匹配 zh
    # 2. 备注(format_note)支持正则匹配 zh 或 chi 或 中文字符
    yt-dlp -f "bv*[height<=720]+ba[language~='(?i)zh']/bv*[height<=720]+ba[format_note~='(?i)zh|chi|中']/b[height<=720][language~='(?i)zh']/b[height<=720][format_note~='(?i)zh|chi|中']/best[height<=720]" \
           --extractor-args "youtube:lang=zh-CN" \
           --merge-output-format mp4 \
           "$1"
}


# 快速使用 yt-dlp 下载 mp3
alias ytmp3='yt-dlp -x --audio-format mp3 '



# ============================================
# NVM 自动切换 (放到最后)
# ============================================
# autoload -U add-zsh-hook
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc
#
#
#

# ============================================
# NVM 初始化与自动切换 (🔥 必须放在文件最末尾)
# ============================================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"          # 加载 nvm 核心
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # 加载补全

# 清理干扰 nvm 的 PREFIX 变量
unset PREFIX

# 安全的自动切换函数 (静默输出，完美兼容 Powerlevel10k Instant Prompt)
_auto_nvm_use() {
  [[ -f .nvmrc ]] && nvm use --silent > /dev/null
}
autoload -U add-zsh-hook
add-zsh-hook chpwd _auto_nvm_use
_auto_nvm_use  # 终端启动时立即执行一次
