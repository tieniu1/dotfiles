-- -----------------------安装lazy插件----------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- --------------------基础配置--------------------
-- 使用相对行号
vim.opt.number = true
vim.opt.relativenumber = true
-- 高亮所在行
vim.opt.cursorline = true

-- 默认情况下忽略搜索大小写
vim.o.ignorecase = true
-- 如果搜索包含大写字母,切换为大小写敏感
vim.o.smartcase = true

-- 启用搜索高亮 
vim.opt.hlsearch = true
-- 设置高亮颜色
vim.cmd([[highlight Search guifg=NONE guibg=#5f00af]])

vim.opt.shiftwidth = 2  -- 设置 >> 和 << 命令移动时的宽度为2
vim.opt.tabstop = 2     -- 设置Tab键的宽度为2
vim.opt.softtabstop = 2 -- 设置软制表符的宽度为2
vim.opt.expandtab = true  -- 将Tab转换为空格
vim.opt.shiftround = true
-- 禁止产生交换文件
vim.opt.swapfile = false

-- 将leader键配置为空格键(注意：这个配置要放到其他leader配置之前，否则其他的leader配置不效果)
vim.g.mapleader = " "
-- -------------------------------------------------------

-- -----------------------修改键绑定----------------------
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end
-- J向下移动5行
map({"n","v"}, "J", "5j")
-- K向上移动5行
map({"n","v"}, "K", "5k")
-- 重新配置y，将复制内容写入系统剪切板 
map({"n","v"}, "y", '"+y')

-- H移动到行首
-- map({"n","o"}, "H", "^")
-- L移动到行尾
-- map({"n","o"}, "L", "g_")

-- 可视化模式选中文本，// 搜索选中文本 
map("v", "//", 'y/<C-r>"<CR>')

-- ----------- 功能性 开始------------------
-- 上下移动行
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })
-- 修改.的功能
map("v", ".", ":normal! .<CR>")

-- ----------- 功能性 结束------------------

-- ------------ leader 开始 ------------------

-- leader + enter 取消搜索高亮
map("n", "<leader><CR>", ":nohlsearch<CR>")

-- leader + v 把光标下单词替换为最近一次复制内容
map("n", "<leader>v", ':normal viw"+p<CR>')

map("n", "<leader>'", ":normal ysiw'el<CR>")
map("n", "<leader>`", ":normal ysiw`el<CR>")
-- 搜索文件中的中文
map("n", "<leader>ch", "/[\\u4e00-\\u9fa5]\\+<CR>")


-- 可视化选中函数或对象
map("n", "<leader>vf", "V$%")
-- 删除函数或对象
map("n", "<leader>df", "V$%d")
-- 复制函数或对象
map("n", "<leader>yf", "V$%y")
-- html标签跳转到开始标签的结束>
map({"n","v"}, "<leader>tl", "^%")


-- ------------ leader 结束 ------------------

-- --------------配置窗口 开始------------------
-- 取消s的默认事件
-- map({"n","v"}, "s", "<NOP>")
-- map({"n","v"}, "S", "<NOP>")

-- 使用<ctrl> hjkl键移动到窗口
map("n", "<C-h>", "<C-w>h", { desc = "转到上窗口", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "转到下窗口", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "转到左窗口", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "转到右窗口", remap = true })
-- 分割屏幕
map("n", "<leader>|", "<C-W>v")
map("n", "<leader>-", "<C-W>s")
-- --------------配置窗口 结束------------------

-- 文本被"yank"后，高亮显示被复制的文本，持续时间为100毫秒
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
  end,
})


---------------设置lazy 开始------------------
require("lazy").setup({
  "tpope/vim-surround",
  "tpope/vim-repeat",
  "wellle/targets.vim",
  "yianwillis/vimcdoc",
  -- 快速移动
-- 	{
-- 				"smoka7/hop.nvim",
-- opts={
--  keys = 'etovxqpdygfblzhckisuran', case_insensitive = false 
-- },
-- config=function(_,opts)
-- 				local hop = require('hop')
-- 				hop.setup(opts)
--
-- 				map("n", "f", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>")
-- 				map("n", "F", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>")
-- 				map("n", "t", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>")
-- 				map("n", "T", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>")
-- end
-- 	}
--
-- TODO: flit.nvim 依赖 leap
  -- {
  --   "ggandor/flit.nvim",
  --   enabled = true,
  --   keys = function()
  --     ---@type LazyKeysSpec[]
  --     local ret = {}
  --     for _, key in ipairs({ "f", "F", "t", "T" }) do
  --       ret[#ret + 1] = { key, mode = { "n", "x", "o" } }
  --     end
  --     return ret
  --   end,
  --   opts = { labeled_modes = "nx" },
  -- },
--   {
--   "ggandor/leap.nvim",
--   enabled = true,
--   keys = {
--     { "s", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
--     { "S", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
--     { "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
--   },
--   config = function(_, opts)
--     local leap = require("leap")
--     for k, v in pairs(opts) do
--       leap.opts[k] = v
--     end
--     leap.add_default_mappings(true)
--     vim.keymap.del({ "x", "o" }, "x")
--     vim.keymap.del({ "x", "o" }, "X")
--   end,
-- }
{
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  --- vscode中会输入中文时会退出,很难用.
  -- opts = {
  -- modes={
  --  search={
  --      -- 修改默认搜索模式
  --     enabled = true
  --  }
  -- }
  -- },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  },
}
})

---------------设置lazy 结束------------------

if vim.g.vscode then

local vscode = require('vscode')

-- vscode命令映射
local function vscodeMap(mode,lhs,rhs,opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend("force", options, opts) end

  local action
  if type(rhs) == "string" then
    -- 如果rhs是字符串，action则是一个有vscode.call调用的函数
      action = function() vscode.call(rhs) end
    elseif type(rhs) == "function" then
    -- 如果rhs是函数，直接使用该函数
      action = rhs
  end
  
  vim.keymap.set(mode, lhs, action, options)
end

    -- VSCode 生效 
    -- --------- 文本操作  开始-------
    -- 折叠代码
    vscodeMap("n", "zc", "editor.fold")

    -- 展开折叠代码
    vscodeMap("n", "zo", "editor.unfold")

    -- 跳过折叠代码(<silent>表示不希望显示提示信息)
    vscodeMap("n", "zj", "editor.gotoNextFold")
    vscodeMap("n", "zk", "editor.gotoPreviousFold")

    -- 重命名变量名 
    vscodeMap("n", "<leader>cr", "editor.action.rename")
    -- 智能修复
    vscodeMap("v", "<D-.>", function() vscode.call('editor.action.quickFix') end )

    -- 行注释 
    vscodeMap({"n","v","i"}, "<D-/>", "editor.action.commentLine")
    -- --------- 文本操作  结束-------
    -- --------- 多窗口管理  开始--------
    
    -- 切换分屏大小 
    vscodeMap("n", "<leader>wm", "workbench.action.toggleEditorWidths")

    -- 将编辑器移动到下一组
    vscodeMap("n", "<leader>mj", "workbench.action.moveEditorToNextGroup")

    -- 将编辑器移动到上一组
    vscodeMap("n", "<leader>mk", "workbench.action.moveEditorToPreviousGroup")

    -- 将编辑器移动到下一组
    vscodeMap("n", "<leader>ml", "workbench.action.moveEditorToNextGroup")

    -- 将编辑器移动到上一组
    vscodeMap("n", "<leader>mh", "workbench.action.moveEditorToPreviousGroup")
    
    -- 关闭组内其他编辑器
    vscodeMap("n", "<leader>bo", "workbench.action.closeOtherEditors")

    -- 查看: 关闭其他组中的编辑器
    vscodeMap("n", "<leader>bO", "workbench.action.closeEditorsInOtherGroups")

    -- 查看: 关闭编辑器
    vscodeMap("n", "<leader>bd", "workbench.action.closeActiveEditor")

    -- 查看: 关闭编辑器组  
    vscodeMap("n", "<leader>bD", "workbench.action.closeEditorsAndGroup")

    -- 查看: 打开组中的上一个编辑器
    vscodeMap("n", "[b", "workbench.action.previousEditorInGroup")
    vscodeMap("n", "<s-h>", "workbench.action.previousEditorInGroup")

    -- 查看: 打开组中的下一个编辑器 
    vscodeMap("n", "]b", "workbench.action.nextEditorInGroup")
    vscodeMap("n", "<s-l>", "workbench.action.nextEditorInGroup")

    -- 水平分屏
    -- vscodeMap("n", "<leader>ws", "workbench.action.splitEditorRight")
    -- 垂直分屏
    -- vscodeMap("n", "<leader>wv", "workbench.action.duplicateActiveEditorGroupDown")
    --
    -- -- 查看: 聚焦到左侧编辑器组 
    -- vscodeMap("n", "<leader>wh", "workbench.action.focusLeftGroup")
    --
    -- -- 查看: 聚焦到右侧编辑器组
    -- vscodeMap("n", "<leader>wl", "workbench.action.focusRightGroup")
    --
    -- -- 查看: 聚焦到上一组编辑器
    -- vscodeMap("n", "<leader>wk", "workbench.action.focusPreviousGroup")
    --
    -- -- 查看: 聚焦到下一组编辑器
    -- vscodeMap("n", "<leader>wj", "workbench.action.focusNextGroup")
    -- --------- 多窗口管理  结束--------

else
    -- Neovim 生效
    -- f4 格式化json
    map("n", "<F4>", ":%!python3 -m json.tool<CR>")
    -- 分屏快捷键 (只在nvim中生效!!!vscode中是下方调用vscode的快捷键实现)
    map("n", "<leader>wv", ":vsp<CR>")
    map("n", "<leader>ws", ":sp<CR>")
end
