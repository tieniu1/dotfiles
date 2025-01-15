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
  -- { -- AI插件支持deepseek
  --   "Kurama622/llm.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  --   cmd = { "LLMSesionToggle", "LLMSelectedTextHandler" },
  --   config = function()
  --     require("llm").setup({
  --       url = "https://api.deepseek.com/v1/chat/completions",
  --       model = "deepseek-chat",
  --       api_type = "openai",
  --       max_tokens = 4096,
  --     })
  --   end,
  --   keys = {
  --     { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
  --   },
  -- },
  --
  --#AI插件支持
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- 如果你想要始终获取最新的更改，请设置这个
    opts = {
      provider = "openai",
      openai = {
        -- linux.do 的配置
        -- endpoint = "https://api.oaipro.com/v1",
        -- model = "claude-3-5-sonnet-20241022",

        -- deepseek
        endpoint = "https://api.deepseek.com/v1",
        -- model = "deepseek-chat",
        model = "deepseek-coder",

        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        max_tokens = 4096,
      },
      -- 在这里添加任何选项
    },
    -- 如果你想从源代码构建，使用 `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- Windows系统使用这个
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- 以下依赖是可选的
      "hrsh7th/nvim-cmp", -- 用于avante命令和提及的自动补全
      "nvim-tree/nvim-web-devicons", -- 或使用 echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- 当 providers='copilot' 时需要
      {
        -- 支持图片粘贴
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- 推荐设置
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- Windows用户必需
            use_absolute_path = true,
          },
        },
      },
      -- {
      --   -- 如果你设置了lazy=true，确保正确设置这个
      --   "MeanderingProgrammer/render-markdown.nvim",
      --   opts = {
      --     file_types = { "markdown", "Avante" },
      --   },
      --   ft = { "markdown", "Avante" },
      -- },
    },
  },
}
