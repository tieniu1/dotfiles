-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- 保存时自动修复 ESLint 警告
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(event)
    local clients = vim.lsp.get_clients({ bufnr = event.buf, name = "eslint" })
    if #clients > 0 then
      vim.cmd("LspEslintFixAll")
    end
  end,
})
