return {
  { -- eslint 支持json
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
        unocss = { -- 如果需要禁用unocss，也要把这里禁用
          filetypes = { "vue" },
          -- 1. 添加 colorProvider 能力
          capabilities = {
            textDocument = {
              colorProvider = {
                dynamicRegistration = true,
              },
            },
          },

          -- 2. 在 on_attach 中启用 document-color
          on_attach = function(client, bufnr)
            if client.server_capabilities.colorProvider then
              require("document-color").buf_attach(bufnr)
            end
          end,
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { -- 安装unocss lsp， 如果需要禁用unocss，记得把nvim-lapconfig 中unocss的配置禁用，不然还是会自动安装
        "unocss-language-server",
      },
    },
  },
  {
    "mrshmllow/document-color.nvim",
    opts = {
      mode = "background",
    },
  },
}
