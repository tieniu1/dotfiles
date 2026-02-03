return {
  "ibhagwan/fzf-lua",
  opts = {
    keymap = {
      builtin = {
        -- 将帮助键位从 F1 改为其他键位，比如 ?
        -- ["<F1>"] = false, -- 禁用原来的 F1
        -- ["?"] = "toggle-help",
      },
    },
    files = {
      -- 配置文件搜索，`--hidden`包含隐藏文件，`--exclude .git` 排除.git `--exclude uni_modules` 排除uni_modules 目录 `--type f` 只显示文件不显示文件夹
      fd_opts = "--hidden --exclude .git --exclude uni_modules --type f",
      -- 或者使用 rg 命令
      -- rg_opts = "--hidden --files --glob '!.git'",
    },
    grep = {
      -- 配置文本搜索，包含隐藏文件，但排除 .git 、libs、uni_modules 目录
      rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=512 --glob '!.git' --glob '!libs' --glob '!uni_modules'",
    },
    -- 启用 chafa 图片预览
    previewer = {
      -- 设置预览器优先级
      builtin = {
        extensions = {
          -- 使用 chafa 预览图片文件
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
}
