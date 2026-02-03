# 通用函数

# 代理设置
proxy() {
    export PROXY_HOST=127.0.0.1
    export PROXY_PORT=7897

    export http_proxy="http://$PROXY_HOST:$PROXY_PORT"
    export https_proxy="http://$PROXY_HOST:$PROXY_PORT"
    export all_proxy="socks5://$PROXY_HOST:$PROXY_PORT"

    git config --global http.proxy "http://$PROXY_HOST:$PROXY_PORT"
    git config --global https.proxy "http://$PROXY_HOST:$PROXY_PORT"

    echo "代理已开启"
}

# 关闭代理
noproxy() {
    unset http_proxy
    unset https_proxy
    unset all_proxy

    git config --global --unset http.proxy
    git config --global --unset https.proxy

    echo "代理已关闭"
}

# 测试代理
testproxy() {
    curl -I https://www.google.com -s | head -n 1 || echo "无法连接"
}

# 根据 .nvmrc 自动切换 nvm 版本
load-nvmrc() {
    local nvmrc_path
    nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
        local nvmrc_node_version
        nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

        if [ "$nvmrc_node_version" = "N/A" ]; then
            nvm install
        elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
            nvm use
        fi
    elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
        echo "Reverting to nvm default version"
        nvm use default
    fi
}
