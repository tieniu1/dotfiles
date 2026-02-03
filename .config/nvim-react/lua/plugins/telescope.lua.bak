return {
  "nvim-telescope/telescope.nvim",
  config = function()
    -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#file-and-text-search-in-hidden-files-and-directories
    local telescopeConfig = require("telescope.config")

    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

    table.insert(vimgrep_arguments, "--hidden")

    require("telescope").setup({
      defaults = {
        -- 允许 live_grep 在.文件搜索文本
        vimgrep_arguments = vimgrep_arguments,
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          -- 允许搜索.文件
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    })
  end,
}
