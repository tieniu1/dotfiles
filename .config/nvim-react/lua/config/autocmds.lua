-- 自动命令在 VeryLazy 事件上自动加载
-- 默认的自动命令始终设置：https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- 在此添加任何额外的自动命令

-- markdown 文件关闭拼写检查
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.spell = false
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function()
    local file_path = vim.fn.expand("%:p")
    local project_root = vim.fn.getcwd()
    local relative_path = vim.fn.fnamemodify(file_path, ":.")

    -- 计算当前文件内容的 hash
    local current_content = vim.fn.join(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
    local current_hash = vim.fn.sha256(current_content)

    -- 在 .history 目录下存储 hash 文件，保持原有的目录结构
    local history_dir = project_root .. "/.history/" .. relative_path:gsub("/[^/]+$", "")
    local file_name = vim.fn.expand("%:t")
    local hash_file = history_dir .. "/." .. file_name .. ".hash"

    -- 创建历史目录（如果不存在）
    vim.fn.mkdir(history_dir, "p")

    -- 读取上次的 hash（如果存在）
    local last_hash = ""
    if vim.fn.filereadable(hash_file) == 1 then
      last_hash = vim.fn.readfile(hash_file)[1]
    end

    -- 只有当文件内容发生变化时才创建历史记录
    if current_hash ~= last_hash then
      -- 保存当前 hash
      vim.fn.writefile({ current_hash }, hash_file)

      local timestamp = os.date("%Y%m%d_%H%M%S")
      local base_name = file_name:gsub("%..+$", "")
      local ext = file_name:match("%.(.+)$") or ""
      local history_file = history_dir .. "/" .. base_name .. "_" .. timestamp .. (ext ~= "" and ("." .. ext) or "")

      vim.fn.system("cp " .. file_path .. " " .. history_file)
    end
  end,
})
