return {
  -- MCP Hub (AI 工具协议中心)
  {
    "ravitemer/mcphub.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup({
        port = 37373,
        config = vim.fn.expand("~/.config/mcphub/servers.json"),
        extensions = {
          avante = {
            make_slash_commands = true,
          },
        },
      })
    end,
  },
  -- AI IDE (avante.nvim)
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "stevearc/dressing.nvim",
      "nvim-tree/nvim-web-devicons",
      "MeanderingProgrammer/render-markdown.nvim",
      "ravitemer/mcphub.nvim",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true,
          },
        },
      },
    },
    opts = {
      provider = "openai",
      mode = "agentic",
      providers = {
        openai = {
          endpoint = "https://openrouter.ai/api/v1",
          model = "qwen/qwen3-coder-480b-a35b:free",
          timeout = 30000,
          extra_request_body = {
            temperature = 0.7,
            max_tokens = 8192,
          },
        },
      },
      -- 使用 mcphub 的工具，禁用 avante 自带的文件操作
      disabled_tools = {
        "list_files", "search_files", "read_file",
        "create_file", "rename_file", "delete_file",
        "create_dir", "rename_dir", "delete_dir", "bash",
      },
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
      ui = {
        border = "rounded",
      },
    },
  },
  -- AI 代码补全 (minuet-ai)
  {
    "milanglacier/minuet-ai.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("minuet").setup({
        provider = "openai_compatible",
        request_timeout = 3,
        throttle = 1500,
        debounce = 600,
        virtualtext = {
          auto_trigger_ft = {},
          keymap = {
            accept = "<A-A>",
            accept_line = "<A-a>",
            prev = "<A-[>",
            next = "<A-]>",
            dismiss = "<A-e>",
          },
        },
        provider_options = {
          openai_compatible = {
            api_key = "OPENROUTER_API_KEY",
            end_point = "https://openrouter.ai/api/v1/chat/completions",
            model = "qwen/qwen3-coder-480b-a35b:free",
            name = "OpenRouter",
            optional = {
              max_tokens = 256,
              top_p = 0.9,
            },
          },
        },
      })
    end,
  },
}
