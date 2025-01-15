return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        markdownlint = {
          args = { "--config", "~/.markdownlint.jsonc", "--" },
        },
        ["markdownlint-cli2"] = {
          args = { "--config", ".markdownlint-cli2.yaml", "--" },
        },
      },
    },
  },
}
