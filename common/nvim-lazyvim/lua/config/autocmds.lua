-- 自动命令会在 VeryLazy 事件时加载
-- 默认自动命令: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- 在此添加自定义自动命令

-- 保存时自动修复 ESLint 警告
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(event)
    local clients = vim.lsp.get_clients({ bufnr = event.buf, name = "eslint" })
    if #clients > 0 then
      vim.cmd("LspEslintFixAll")
    end
  end,
})
