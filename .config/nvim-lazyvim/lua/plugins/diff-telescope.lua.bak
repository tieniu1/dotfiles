return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>dt",
        function()
          -- 获取项目根目录
          local project_root = vim.fn.getcwd()

          -- 创建搜索目录选项
          local search_dirs = {
            { name = "当前目录", path = vim.fn.expand("%:p:h") },
            { name = "项目根目录", path = project_root },
            { name = "项目上层目录", path = vim.fn.fnamemodify(project_root, ":h") },
          }

          -- 显示目录选择菜单
          vim.ui.select(search_dirs, {
            prompt = "选择搜索目录",
            format_item = function(item)
              return item.name .. " (" .. item.path .. ")"
            end,
          }, function(choice)
            if not choice then
              return
            end

            require("telescope.builtin").find_files({
              cwd = choice.path,
              path_display = { "truncate" },

              attach_mappings = function(prompt_bufnr, map)
                local actions = require("telescope.actions")
                actions.select_default:replace(function()
                  actions.close(prompt_bufnr)
                  local selection = require("telescope.actions.state").get_selected_entry()

                  -- 保存原始 buffer 和窗口
                  local original_buf = vim.api.nvim_get_current_buf()
                  local original_win = vim.api.nvim_get_current_win()

                  -- 创建垂直分割并打开文件
                  vim.cmd("vsplit " .. selection.cwd .. "/" .. selection.value)

                  -- 保存新窗口和 buffer 的信息
                  local new_win = vim.api.nvim_get_current_win()
                  local new_buf = vim.api.nvim_get_current_buf()

                  -- 开启 diff 模式和滚动同步
                  vim.cmd("windo diffthis")
                  vim.cmd("windo set scrollbind")

                  -- 同步滚动位置到顶部
                  vim.cmd("normal! gg")
                  vim.cmd("windo normal! gg")

                  -- 添加退出功能的快捷键
                  vim.keymap.set("n", "q", function()
                    -- 关闭 diff 和滚动同步
                    vim.cmd("windo diffoff")
                    vim.cmd("windo set noscrollbind")

                    -- 关闭新打开的窗口和 buffer
                    vim.api.nvim_win_close(new_win, true)
                    vim.api.nvim_buf_delete(new_buf, { force = true })

                    -- 确保焦点回到原始窗口
                    vim.api.nvim_set_current_win(original_win)
                  end, { noremap = true, silent = true, buffer = true })
                end)
                return true
              end,
            })
          end)
        end,
        desc = "Diff with telescope",
      },
    },
  },
}
