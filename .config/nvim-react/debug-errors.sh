#!/bin/bash

echo "=== nvim-react 启动错误诊断 ==="
echo "时间: $(date)"
echo ""

# 创建临时文件存储错误信息
ERROR_LOG="/tmp/nvim-react-errors-$(date +%Y%m%d_%H%M%S).log"

echo "1. 尝试启动 nvim-react 并捕获错误..."
echo "--------------------------------"

# 方法1：捕获标准错误输出
echo "捕获标准错误输出到: $ERROR_LOG"
NVIM_APPNAME=nvim-react nvim --headless -c 'qall!' > "$ERROR_LOG" 2>&1

if [ -s "$ERROR_LOG" ]; then
    echo "发现错误信息:"
    cat "$ERROR_LOG"
else
    echo "标准错误输出中未发现错误"
fi

echo ""
echo "2. 检查 Neovim 日志文件..."
echo "--------------------------------"

# 检查日志文件
if [ -f ~/.local/state/nvim-react/log ]; then
    echo "主日志文件内容:"
    cat ~/.local/state/nvim-react/log
else
    echo "未找到主日志文件"
fi

echo ""
echo "3. 检查 Mason 日志..."
echo "--------------------------------"

if [ -f ~/.local/state/nvim-react/mason.log ]; then
    echo "Mason 日志最后50行:"
    tail -50 ~/.local/state/nvim-react/mason.log
else
    echo "未找到 Mason 日志"
fi

echo ""
echo "4. 检查插件安装状态..."
echo "--------------------------------"

# 尝试运行 Lazy 状态检查
NVIM_APPNAME=nvim-react nvim --headless -c 'lua vim.opt.loadplugins = false' -c 'lua require("lazy").setup()' -c 'lua print("Lazy 加载完成")' -c 'qall!' 2>&1

echo ""
echo "5. 尝试最小配置启动..."
echo "--------------------------------"

# 创建最小配置测试
NVIM_APPNAME=nvim-react nvim --headless -c 'lua vim.opt.loadplugins = false' -c 'echo "最小配置启动成功"' -c 'qall!' 2>&1

echo ""
echo "错误日志已保存到: $ERROR_LOG"
echo "=== 诊断完成 ==="
