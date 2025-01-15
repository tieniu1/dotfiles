return {
  -- 添加 mason 相关配置
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "vetur-vls", -- vue2支持 vuels(mason中vetur-vls就是vue2 的lsp vuels)
        "some-sass-language-server", -- sass支持
        "typescript-language-server", -- js/ts支持
        "stylelint-lsp", -- stylelint 支持
        "html-lsp", -- html支持
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
      ensure_installed = { "vue", "scss", "html", "css", "javascript" }, -- 根据需要添加其他语言
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
  { -- 这里配置 stylelint 保存自动格式化
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- 配置 eslint
        eslint = {
          -- 添加对 json 文件的支持
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "vue",
            "svelte",
            "astro",
            "json", -- 添加 json 支持
          },
        },
      },
    },
  },
}
