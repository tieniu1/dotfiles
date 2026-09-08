-- 项目类型检测：Vue2 / Vue3 / React / unknown
local function detect_project_type()
  local root = vim.fn.getcwd()

  -- 读取 package.json
  local pkg_path = root .. "/package.json"
  local pkg_file = io.open(pkg_path, "r")
  if not pkg_file then
    return "unknown"
  end
  local content = pkg_file:read("*a")
  pkg_file:close()

  -- Vue2: vue.config.js 或 @vue/cli 依赖
  if vim.fn.filereadable(root .. "/vue.config.js") == 1 then
    return "vue2"
  end
  if content:match('"@vue/cli') then
    return "vue2"
  end

  -- Vue3: vite.config.* 或 vue >= 3
  if vim.fn.glob(root .. "/vite.config.*") ~= "" and content:match('"vue"') then
    return "vue3"
  end
  if content:match('"vue"%s*:%s*"%^?3') or content:match('"vue"%s*:%s*"~?3') then
    return "vue3"
  end

  -- React
  if content:match('"react"') then
    return "react"
  end

  return "unknown"
end

local project_type = detect_project_type()

-- Vue2 项目：禁用 volar，启用 vuels
-- 非 Vue2 项目：volar 由 LazyVim extras.lang.vue 自动管理
local servers = {}
local setup = {}

if project_type == "vue2" then
  -- 禁用 volar（LazyVim extras.lang.vue 会启用它）
  servers.volar = { enabled = false }

  -- 启用 vuels
  servers.vuels = {
    filetypes = { "vue" },
    init_options = {
      config = {
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
  }
end

-- eslint: 扩展 html、json 支持（所有项目通用）
-- 注意：校验 HTML 内嵌 JS 需要项目侧额外配置：
--   1. 安装插件: npm install -D eslint-plugin-html
--   2. 在 .eslintrc 中启用:  { "plugins": ["html"] }
--      或在 eslint.config.js 中: import html from "eslint-plugin-html"
-- 否则 ESLint server 虽然会 attach 到 HTML 文件，但无法解析 <script> 标签中的代码。
servers.eslint = {
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
    "html",
    "json",
  },
}

-- unocss: Vue3 / React 项目启用
if project_type == "vue3" or project_type == "react" then
  local unocss_filetypes = { "vue" }
  if project_type == "react" then
    unocss_filetypes = { "javascriptreact", "typescriptreact" }
  end

  servers.unocss = {
    filetypes = unocss_filetypes,
    capabilities = {
      textDocument = {
        colorProvider = { dynamicRegistration = true },
      },
    },
    on_attach = function(client, bufnr)
      if client.server_capabilities.colorProvider then
        local ok, dc = pcall(require, "document-color")
        if ok then
          dc.buf_attach(bufnr)
        end
      end
    end,
  }
end

local plugins = {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = servers,
      setup = setup,
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "some-sass-language-server",
      },
    },
  },
}

-- Vue2 项目额外安装 vetur-vls
if project_type == "vue2" then
  plugins[2].opts.ensure_installed[#plugins[2].opts.ensure_installed + 1] = "vetur-vls"
end

-- Vue3 / React 项目额外安装 unocss + document-color 插件
if project_type == "vue3" or project_type == "react" then
  plugins[2].opts.ensure_installed[#plugins[2].opts.ensure_installed + 1] = "unocss-language-server"
  plugins[#plugins + 1] = {
    "mrshmllow/document-color.nvim",
    opts = { mode = "background" },
  }
end

return plugins
