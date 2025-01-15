# 如果你从 bash 切换过来，可能需要更改你的 $PATH
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Oh My Zsh 安装路径
export ZSH="$HOME/.oh-my-zsh"

# 设置要加载的主题名称 --- 如果设置为 "random"，每次加载 Oh My Zsh 时会随机选择一个主题
# 要查看具体加载了哪个主题，可以运行: echo $RANDOM_THEME
# 参见 https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# 取消注释以下行以启用区分大小写的补全
# CASE_SENSITIVE="true"

# 取消注释以下行以启用不区分连字符的补全
# 区分大小写的补全必须关闭。_ 和 - 将可以互换
# HYPHEN_INSENSITIVE="true"

# 取消注释以下行之一以更改自动更新行为
# zstyle ':omz:update' mode disabled  # 禁用自动更新
# zstyle ':omz:update' mode auto      # 自动更新而不询问
# zstyle ':omz:update' mode reminder  # 仅在需要更新时提醒


# 取消注释以下行，如果粘贴 URL 和其他文本时出现问题
# DISABLE_MAGIC_FUNCTIONS="true"

# 取消注释以下行以禁用 ls 命令的颜色显示
# DISABLE_LS_COLORS="true"

# 取消注释以下行以禁用自动设置终端标题
# DISABLE_AUTO_TITLE="true"

# 取消注释以下行以启用命令自动纠正
# ENABLE_CORRECTION="true"

# 取消注释以下行以在等待补全时显示红点
# 你也可以将其设置为其他字符串以显示自定义提示
# 例如 COMPLETION_WAITING_DOTS="%F{yellow}等待中...%f"
# 注意：此设置在 zsh < 5.7.1 中可能会导致多行提示符问题（参见 #5765）
# COMPLETION_WAITING_DOTS="true"

# 取消注释以下行，如果你想禁用将未跟踪的文件标记为脏
# 这会使大型仓库的状态检查更快
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# 取消注释以下行，如果你想更改历史命令输出中显示的时间戳格式
# 你可以选择以下三种格式之一：
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# 或者使用 strftime 函数格式规范设置自定义格式
# 详情参见 'man strftime'
# HIST_STAMPS="mm/dd/yyyy"

# 你想使用 $ZSH/custom 以外的自定义文件夹吗？
# ZSH_CUSTOM=/path/to/new-custom-folder

# 你想加载哪些插件？
# 标准插件可以在 $ZSH/plugins/ 中找到
# 自定义插件可以添加到 $ZSH_CUSTOM/plugins/
# 示例格式: plugins=(rails git textmate ruby lighthouse)
# 请谨慎添加，因为过多的插件会减慢 shell 启动速度
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    colorize
    autojump
)

source $ZSH/oh-my-zsh.sh

# 用户配置

# export MANPATH="/usr/local/man:$MANPATH"

# 你可能需要手动设置语言环境
# export LANG=en_US.UTF-8

# 本地和远程会话的首选编辑器
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# 编译标志
# export ARCHFLAGS="-arch $(uname -m)"

# 设置个人别名，覆盖 Oh My Zsh 库、插件和主题提供的别名
# 别名可以放在这里，但建议 Oh My Zsh 用户在 $ZSH_CUSTOM 文件夹中创建一个顶级文件来定义别名
# 文件扩展名为 .zsh。例如：
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# 要查看所有活动别名，请运行 `alias`。
#
# 示例别名
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# TODO 从.zshrc.localf加载隐私数据
if [ -f "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi


# 设置代理
proxy() {

    # 代理设置
    export PROXY_HOST=127.0.0.1
    export PROXY_PORT=7890  # 根据您的代理端口修改

    export http_proxy="http://$PROXY_HOST:$PROXY_PORT"
    export https_proxy="http://$PROXY_HOST:$PROXY_PORT"
    export all_proxy="socks5://$PROXY_HOST:$PROXY_PORT"
    
    # Git 代理设置
    git config --global http.proxy "http://$PROXY_HOST:$PROXY_PORT"
    git config --global https.proxy "http://$PROXY_HOST:$PROXY_PORT"
    
    # Brew 代理设置
    export HOMEBREW_HTTP_PROXY="http://$PROXY_HOST:$PROXY_PORT"
    export HOMEBREW_HTTPS_PROXY="http://$PROXY_HOST:$PROXY_PORT"
    
    echo "已开启"
}

# 关闭代理
noproxy() {
    unset http_proxy
    unset https_proxy
    unset all_proxy
    
    # 取消 Git 代理设置
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    
    # 取消 Brew 代理设置
    unset HOMEBREW_HTTP_PROXY
    unset HOMEBREW_HTTPS_PROXY
    
    echo "已关闭"
}

# 测试代理
testproxy() {
    curl -I https://www.google.com -s | head -n 1 || echo "无法成功连接"
    echo ""
}

# 
alias nvim-lazy='NVIM_APPNAME=nvim-lazyvim nvim'
alias nvim-v3='NVIM_APPNAME=nvim-v3 nvim'



# 加载 nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

