local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- 加载 LazyVim 及其插件
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- 启用 LazyVim extras
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.vue" },
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.markdown", enabled = not vim.g.vscode },
    -- 导入自定义插件配置
    { import = "plugins" },
  },
  defaults = {
    -- 默认只有 LazyVim 插件会懒加载，自定义插件会在启动时加载
    -- 如果你清楚自己在做什么，可以设为 true 让所有自定义插件也默认懒加载
    lazy = false,
    -- 建议保持 version=false，因为很多支持版本号的插件发布版本过旧，可能导致 Neovim 出问题
    version = false, -- 始终使用最新的 git commit
    -- version = "*", -- 尝试安装支持 semver 的插件的最新稳定版
  },
  install = { colorscheme = { "catppuccin", "habamax" } },
  checker = {
    enabled = true, -- 定期检查插件更新
    notify = false, -- 有更新时不弹通知
  }, -- 自动检查插件更新
  performance = {
    rtp = {
      -- 禁用部分内置 rtp 插件
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
