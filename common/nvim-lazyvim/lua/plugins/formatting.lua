return {
  {
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

          LazyVim.format.register(formatter)
        end,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylelint-lsp",
      },
    },
  },
}
