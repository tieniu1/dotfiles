return {
  {
    "ibhagwan/fzf-lua",
    opts = {
      files = {
        fd_opts = "--hidden --exclude .git --exclude node_modules --exclude uni_modules --type f",
      },
      grep = {
        rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=512 --glob '!.git' --glob '!node_modules' --glob '!uni_modules'",
      },
      previewer = {
        builtin = {
          extensions = {
            ["png"] = { "chafa" },
            ["jpg"] = { "chafa" },
            ["jpeg"] = { "chafa" },
            ["gif"] = { "chafa" },
            ["ico"] = { "chafa" },
            ["webp"] = { "chafa" },
          },
        },
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
}
