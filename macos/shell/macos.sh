# macOS 专用配置

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# Homebrew 代理设置 (在 proxy 函数中使用)
proxy_brew() {
    export HOMEBREW_HTTP_PROXY="http://$PROXY_HOST:$PROXY_PORT"
    export HOMEBREW_HTTPS_PROXY="http://$PROXY_HOST:$PROXY_PORT"
}

noproxy_brew() {
    unset HOMEBREW_HTTP_PROXY
    unset HOMEBREW_HTTPS_PROXY
}

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Windsurf
if [ -d "$HOME/.codeium/windsurf/bin" ]; then
    export PATH="$HOME/.codeium/windsurf/bin:$PATH"
fi

# Antigravity
if [ -d "$HOME/.antigravity/antigravity/bin" ]; then
    export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
fi
