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

-- 重新配置y，将复制内容写入系统剪切板
map({ "n", "v" }, "y", '"+y')

-- 可视化选中函数或对象
map("n", "<leader>vf", "V$%")
-- 删除函数或对象
map("n", "<leader>df", "V$%d")
-- 复制函数或对象
map("n", "<leader>yf", "V$%y")
-- html标签跳转到开始标签的结束>
map({ "n", "v" }, "<leader>tl", "^%")

-- J向下移动5行
map({ "n", "v" }, "J", "5j")
-- K向上移动5行
map({ "n", "v" }, "K", "5k")

-- leader + v 把光标下单词替换为最近一次复制内容
map("n", "<leader>vp", ':normal viw"+p<CR>')
