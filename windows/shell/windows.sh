# Windows/WSL 专用配置

# WSL 特定设置
if grep -qi microsoft /proc/version 2>/dev/null; then
    # Windows 路径互操作
    export WSLENV="PATH/l"

    # pnpm (WSL 路径)
    export PNPM_HOME="$HOME/.local/share/pnpm"
    case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
fi
