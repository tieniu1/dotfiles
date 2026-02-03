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

-- leader + v 把光标下单词替换为最近一次复制内容
map("n", "<leader>vp", ':normal viw"+p<CR>')

-- React 开发专用键位映射
-- 快速创建 React 组件
map("n", "<leader>rc", ":lua require('react-utils').create_component()<CR>", { desc = "Create React Component" })
-- 快速导入 React hooks
map("n", "<leader>rh", ":lua require('react-utils').insert_hook_import()<CR>", { desc = "Insert React Hook Import" })
-- JSX 标签快速包围
map("v", "<leader>rt", ":lua require('react-utils').wrap_with_tag()<CR>", { desc = "Wrap with JSX Tag" })
-- 快速创建 useState
map("n", "<leader>rs", ":lua require('react-utils').insert_use_state()<CR>", { desc = "Insert useState" })
-- 快速创建 useEffect
map("n", "<leader>re", ":lua require('react-utils').insert_use_effect()<CR>", { desc = "Insert useEffect" })
-- 运行 Jest 测试
map("n", "<leader>rj", ":lua require('jester').run()<CR>", { desc = "Run Jest Test" })
map("n", "<leader>rJ", ":lua require('jester').run_file()<CR>", { desc = "Run Jest File" })
-- 调试 Jest 测试
map("n", "<leader>rd", ":lua require('jester').debug()<CR>", { desc = "Debug Jest Test" })
-- Package.json 依赖管理
map("n", "<leader>rp", ":lua require('package-info').show()<CR>", { desc = "Show Package Info" })
map("n", "<leader>ru", ":lua require('package-info').update()<CR>", { desc = "Update Package" })
map("n", "<leader>ri", ":lua require('package-info').install()<CR>", { desc = "Install Package" })
-- Emmet 快速展开
map("i", "<C-e>", "<C-z>,", { desc = "Expand Emmet" })
