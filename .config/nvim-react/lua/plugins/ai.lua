return {
  --#AI插件支持
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- 如果你想要始终获取最新的更改，请设置这个
    opts = {
      provider = "openai",
      providers = {

        openai = {
          -- linux.do 的配置
          -- endpoint = "https://api.oaipro.com/v1",
          -- model = "claude-3-5-sonnet-20241022",

          -- deepseek
          -- endpoint = "https://api.deepseek.com/v1",
          -- model = "deepseek-chat",
          -- model = "deepseek-coder",

          -- 魔搭
          endpoint = "https://api-inference.modelscope.cn/v1/",
          model = "ZhipuAI/GLM-4.5",
          --
          -- 硅基流动
          -- endpoint = "https://api.siliconflow.cn/v1/",
          -- model = "Qwen/QwQ-32B",
          -- model = "Qwen/Qwen2.5-Coder-32B-Instruct",

          timeout = 30000, -- Timeout in milliseconds
          max_tokens = 4096,
          extra_request_body = {
            temperature = 0.75,
            -- max_tokens = 20480,
          },
        },
      },
    },
    -- 如果你想从源代码构建，使用 `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- Windows系统使用这个
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- 以下依赖是可选的
      "hrsh7th/nvim-cmp", -- 用于avante命令和提及的自动补全
      "nvim-tree/nvim-web-devicons", -- 或使用 echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- 当 providers='copilot' 时需要
      {
        -- 支持图片粘贴
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- 推荐设置
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
          },
        },
      },
      -- {
      --   -- 如果你设置了lazy=true，确保正确设置这个
      --   "MeanderingProgrammer/render-markdown.nvim",
      --   opts = {
      --     file_types = { "markdown", "Avante" },
      --   },
      --   ft = { "markdown", "Avante" },
      -- },
    },
  },
  {
    "robitx/gp.nvim",
    config = function()
      local system_prompt = [[
DO NOT GIVE ME HIGH LEVEL STUFF, IF I ASK FOR FIX OR EXPLANATION, I WANT ACTUAL CODE OR EXPLANATION!!! I DON'T WANT "Here's how you can blablabla"

- Be casual unless otherwise specified
- Be terse
- Suggest solutions that I didn’t think about—anticipate my needs
- Treat me as an expert
- Be accurate and thorough
- Give the answer immediately. Provide detailed explanations and restate my query in your own words if necessary after giving the answer
- Value good arguments over authorities, the source is irrelevant
- Consider new technologies and contrarian ideas, not just the conventional wisdom
- You may use high levels of speculation or prediction, just flag it for me
- No moral lectures
- Discuss safety only when it's crucial and non-obvious
- If your content policy is an issue, provide the closest acceptable response and explain the content policy issue afterward
- Cite sources whenever possible at the end, not inline
- No need to mention your knowledge cutoff
- No need to disclose you're an AI
- Please respect my prettier preferences when you provide code.
- Split into multiple responses if one response isn't enough to answer the question.
  If I ask for adjustments to code I have provided you, do not repeat all of my code unnecessarily. Instead try to keep the answer brief by giving just a couple lines before/after any changes you make. Multiple code blocks are ok.
  Reply in 中文 when interpreting the code.
]]

      --------------------ollama 开始---------------------

      --   default_command_agent = "qwen2.5-coder:14b",
      --   default_chat_agent = "qwen2.5-coder:14b",
      -- providers = {
      --   ollama = {
      --     endpoint = "https://4fc26fbad99b915f46.gradio.live/v1/chat/completions",
      --   },
      -- },
      -- agents = {
      --   {
      --     name = "qwen2.5-coder:14b", -- 你可以自定义名字
      --     provider = "ollama",
      --     chat = true, -- 用于聊天
      --     command = true, -- 用于命令
      --     model = { model = "qwen2.5-coder:14b" }, -- 在这里指定模型
      --     system_prompt = system_prompt,
      --   },
      -- },

      --------------------ollama 结束---------------------
      --------------------百炼 开始---------------------

      --   default_command_agent = "qwen2.5-coder-32b-instruct",
      --   default_chat_agent = "qwen2.5-coder-32b-instruct",
      -- providers = {
      --   openai = {
      --     -- 百炼
      --     endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
      --     -- API key
      --     secret = os.getenv("OPENAI_API_KEY"),
      --   },
      -- },
      -- agents = {
      --   {
      --     name = "qwen2.5-coder-32b-instruct",
      --     provider = "openai",
      --     chat = true, -- 用于聊天
      --     command = true, -- 用于命令
      --     model = { model = "qwen2.5-coder-32b-instruct" },
      --     system_prompt = system_prompt,
      --   },
      -- },
      --

      --------------------百炼 结束---------------------
      --
      local conf = {

        --------------------魔搭 开始---------------------
        default_command_agent = "ZhipuAI/GLM-4.5",
        default_chat_agent = "ZhipuAI/GLM-4.5",
        providers = {
          openai = {
            --百炼
            endpoint = "https://api-inference.modelscope.cn/v1/chat/completions",
            -- API key
            secret = os.getenv("AVANTE_OPENAI_API_KEY"),
          },
        },
        agents = {
          {
            name = "ZhipuAI/GLM-4.5",
            provider = "openai",
            chat = true, -- 用于聊天
            command = true, -- 用于命令
            model = { model = "ZhipuAI/GLM-4.5" }, -- 在这里指定模型
            system_prompt = system_prompt,
          },
        },

        --------------------魔搭 结束---------------------
      }

      require("gp").setup(conf)

      require("which-key").add({
        -- VISUAL 模式映射
        {
          mode = { "v" },
          nowait = true,
          remap = false,
          -- { "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", desc = "新建聊天（新标签页）" },
          -- { "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", desc = "新建聊天（水平分割）" },
          -- { "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", desc = "新建聊天" },
          { "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", desc = "在选中内容后追加" },
          { "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", desc = "在选中内容前追加" },
          { "<C-g>c", ":<C-u>'<,'>GpChatNew vsplit<cr>", desc = "新建聊天（垂直分割）" },
          { "<C-g>g", group = "生成到新位置.." },
          { "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", desc = "生成到弹出窗口" },
          { "<C-g>gv", ":<C-u>'<,'>GpVnew<cr>", desc = "生成到垂直分割" },
          { "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", desc = "实现选中内容" },
          { "<C-g>n", "<cmd>GpNextAgent<cr>", desc = "下一个 Agent" },
          { "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", desc = "粘贴到聊天" },
          { "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", desc = "重写选中内容" },
          { "<C-g>s", "<cmd>GpStop<cr>", desc = "停止生成" },
          { "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", desc = "切换聊天窗口" },
          -- { "<C-g>gt", ":<C-u>'<,'>GpTabnew<cr>", desc = "生成到新标签页" },
          -- { "<C-g>ge", ":<C-u>'<,'>GpEnew<cr>", desc = "生成到新缓冲区" },
          -- { "<C-g>gn", ":<C-u>'<,'>GpNew<cr>", desc = "生成到新窗口" },
        },

        -- NORMAL 模式映射
        {
          mode = { "n" },
          nowait = true,
          remap = false,
          -- { "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", desc = "新建聊天（新标签页）" },
          -- { "<C-g><C-x>", "<cmd>GpChatNew split<cr>", desc = "新建聊天（水平分割）" },
          -- { "<C-g>c", "<cmd>GpChatNew<cr>", desc = "新建聊天" },
          { "<C-g>a", "<cmd>GpAppend<cr>", desc = "在当前位置后追加" },
          { "<C-g>b", "<cmd>GpPrepend<cr>", desc = "在当前位置前追加" },
          { "<C-g>c", "<cmd>GpChatNew vsplit<cr>", desc = "新建聊天（垂直分割）" },
          { "<C-g>f", "<cmd>GpChatFinder<cr>", desc = "聊天查找器" },
          { "<C-g>g", group = "生成到新位置.." },
          { "<C-g>gp", "<cmd>GpPopup<cr>", desc = "生成到弹出窗口" },
          { "<C-g>gv", "<cmd>GpVnew<cr>", desc = "生成到垂直分割" },
          { "<C-g>n", "<cmd>GpNextAgent<cr>", desc = "下一个 Agent" },
          { "<C-g>r", "<cmd>GpRewrite<cr>", desc = "行内重写" },
          { "<C-g>s", "<cmd>GpStop<cr>", desc = "停止生成" },
          { "<C-g>t", "<cmd>GpChatToggle<cr>", desc = "切换聊天窗口" },
          -- { "<C-g>ge", "<cmd>GpEnew<cr>", desc = "生成到新缓冲区" },
          -- { "<C-g>gn", "<cmd>GpNew<cr>", desc = "生成到新窗口" },
          -- { "<C-g>gt", "<cmd>GpTabnew<cr>", desc = "生成到新标签页" },
        },

        -- INSERT 模式映射
        {
          mode = { "i" },
          nowait = true,
          remap = false,
          -- { "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", desc = "新建聊天（新标签页）" },
          -- { "<C-g><C-x>", "<cmd>GpChatNew split<cr>", desc = "新建聊天（水平分割）" },
          -- { "<C-g>c", "<cmd>GpChatNew<cr>", desc = "新建聊天" },
          { "<C-g>a", "<cmd>GpAppend<cr>", desc = "在当前位置后追加" },
          { "<C-g>b", "<cmd>GpPrepend<cr>", desc = "在当前位置前追加" },
          { "<C-g>c", "<cmd>GpChatNew vsplit<cr>", desc = "新建聊天（垂直分割）" },
          { "<C-g>f", "<cmd>GpChatFinder<cr>", desc = "聊天查找器" },
          { "<C-g>g", group = "生成到新位置.." },
          { "<C-g>gp", "<cmd>GpPopup<cr>", desc = "生成到弹出窗口" },
          { "<C-g>gv", "<cmd>GpVnew<cr>", desc = "生成到垂直分割" },
          { "<C-g>n", "<cmd>GpNextAgent<cr>", desc = "下一个 Agent" },
          { "<C-g>r", "<cmd>GpRewrite<cr>", desc = "行内重写" },
          { "<C-g>s", "<cmd>GpStop<cr>", desc = "停止生成" },
          { "<C-g>t", "<cmd>GpChatToggle<cr>", desc = "切换聊天窗口" },
          -- { "<C-g>ge", "<cmd>GpEnew<cr>", desc = "生成到新缓冲区" },
          -- { "<C-g>gn", "<cmd>GpNew<cr>", desc = "生成到新窗口" },
          -- { "<C-g>gt", "<cmd>GpTabnew<cr>", desc = "生成到新标签页" },
        },
      })
    end,
  },
}
