-- 快捷键会在 VeryLazy 事件时加载
-- 默认快捷键: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- 在此添加自定义快捷键
--
local map = LazyVim.safe_keymap_set
-- local delMap = vim.keymap.del

-- 使用cmd+s保存文件
-- delMap({ "i", "x", "n", "s" }, "<C-s>")
-- map({ "i", "x", "n", "s" }, "<M-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- 浮动窗口显示lsp报错
map("n", "gl", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- 重新配置y，将复制内容写入系统剪切板
map({ "n", "v" }, "y", '"+y')
