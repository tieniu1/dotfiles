-- 自动命令在 VeryLazy 事件上自动加载
-- 默认的自动命令始终设置：https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- 在此添加任何额外的自动命令

-- markdown 文件关闭拼写检查
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.spell = false
  end,
})
