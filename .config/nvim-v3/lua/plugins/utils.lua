return {
  -- eslint
  { import = "lazyvim.plugins.extras.linting.eslint" },
  -- prettier
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  -- 开启vscode支持
  { import = "lazyvim.plugins.extras.vscode" },
  -- telescope
  { import = "lazyvim.plugins.extras.editor.telescope" },
  -- yanky
  { import = "lazyvim.plugins.extras.coding.yanky" },
  -- codeium
  -- { import = "lazyvim.plugins.extras.ai.codeium" },
  -- diff
  { import = "lazyvim.plugins.extras.editor.mini-diff" },
  -- markdown
  { import = "lazyvim.plugins.extras.lang.markdown" },
  {
    -- TODO 高亮注释
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {

        pattern = [[.*<(KEYWORDS)\s*]], -- 匹配，而不带额外的冒号。您可能会得到误报
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]], -- 匹配，而不带额外的冒号。您可能会得到误报
      },
    },
  },
}
