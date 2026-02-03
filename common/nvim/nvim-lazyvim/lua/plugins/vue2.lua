return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true, -- 启用透明背景
      flavour = "mocha", -- mocha, macchiato, frappe, latte
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        -- 设置为 true 让标签栏始终显示
        always_show_bufferline = true,
        -- -- 其他选项...
        -- show_buffer_close_icons = true,
        -- show_close_icon = true,
        -- -- 可以设置标签样式
        -- separator_style = "slant", -- 可选: "thick", "thin", "slant", "padded_slant"
      },
    },
  },
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
  -- 添加 mason 相关配置
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "vetur-vls", -- vue2支持 vuels(mason中vetur-vls就是vue2 的lsp vuels)
        "some-sass-language-server", -- sass支持
        "typescript-language-server", -- js/ts支持
        "stylelint-lsp", -- stylelint 支持
      },
    },
  },
  -- 添加 lspconfig 配置
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- vuels 配置
        vuels = { -- vue2 的lsp,对应的就是 mason 安装的 vetur-ls
          filetypes = { "vue" },
          init_options = {
            config = {
              -- 添加路径别名配置 ,项目的根目录中也要配置（https://vuejs.github.io/vetur/guide/setup.html#project-setup）
              alias = {
                ["@"] = "${workspaceFolder}/src",
                ["~@"] = "${workspaceFolder}/src",
                ["@components"] = "${workspaceFolder}/src/components",
                -- 添加其他别名...
              },
              vetur = {
                completion = {
                  autoImport = true,
                  useScaffoldSnippets = true,
                },
                validation = {
                  template = true,
                  script = true,
                  style = true,
                  templateProps = true,
                  interpolation = true,
                },
              },
            },
          },
        },
      },
    },
  },
  { -- 这里配置 stylelint 保存自动格式化
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        stylelint_lsp = {
          filetypes = { "css", "less", "scss", "vue", "sass" },
          settings = {
            stylelintplus = {
              autoFixOnFormat = true,
              validate = { "css", "less", "scss", "vue", "sass" },
            },
          },
        },
      },
      setup = {
        stylelint_lsp = function()
          local function get_client(buf)
            return LazyVim.lsp.get_clients({ name = "stylelint_lsp", bufnr = buf })[1]
          end

          local formatter = LazyVim.lsp.formatter({
            name = "stylelint: lsp",
            primary = false,
            priority = 200,
            filter = "stylelint_lsp",
          })

          formatter.sources = function(buf)
            local client = get_client(buf)
            return client and { "stylelint_lsp" } or {}
          end

          formatter.format = function(buf)
            local client = get_client(buf)
            if client then
              vim.lsp.buf.format({
                async = false,
                filter = function(c)
                  return c.name == "stylelint_lsp"
                end,
              })
            end
          end

          -- 注册格式化器
          LazyVim.format.register(formatter)
        end,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["ar"] = "@class.outer",
            ["ir"] = "@class.inner",
          },
        },
      },
    },
  },
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",

    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })
    end,
  },
  { import = "lazyvim.plugins.extras.linting.eslint" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  {
    "nvim-telescope/telescope.nvim",
    -- change some options
    opts = {
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "%.git/",
          "%.DS_Store",
          "%.hbuilderx",
          "%.history",
          "dist",
        },
      },
    },
  },
}
