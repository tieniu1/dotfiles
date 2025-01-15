-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local map = LazyVim.safe_keymap_set
-- local delMap = vim.keymap.del

-- 使用cmd+s保存文件
-- delMap({ "i", "x", "n", "s" }, "<C-s>")
-- map({ "i", "x", "n", "s" }, "<M-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- 浮动窗口显示lsp报错
map("n", "gl", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- -- 重新配置y，将复制内容写入系统剪切板
-- map({ "n", "v" }, "y", '"+y')

-- 取消 alt+k和alt+j 移动代码
vim.keymap.del("n", "<M-k>")
vim.keymap.del("i", "<M-k>")
vim.keymap.del("v", "<M-k>")
vim.keymap.del("n", "<M-j>")
vim.keymap.del("i", "<M-j>")
vim.keymap.del("v", "<M-j>")
