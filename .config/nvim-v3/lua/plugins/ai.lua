return {
  --#AI插件支持
  {
    "yetone/avante.nvim",
    lazy = false, -- 保持启动时加载，以便 :Avante 命令始终可用
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
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
      -- 1. 设置默认提供商
      provider = "openai", -- 你之前设置的 provider = "openai" 移到这里并改名

      -- 2. 在 providers 表中配置你的服务
      providers = {
        -- 我们将你所有的配置都放在 openai 这个键下
        openai = {
          -- avante 会去读取 `OPENAI_API_KEY`
          endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",

          model = "qwen2.5-coder-32b-instruct",

          -- 其他参数也一并移入
          request_options = {
            timeout = 30000, -- Timeout in milliseconds
            temperature = 0,
            max_tokens = 4096,
          },
        },
      },
      -- 其他 avante 的全局设置可以放在这里，比如 UI
      ui = {
        border = "rounded",
      },
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

        --------------------百炼 开始---------------------
        default_command_agent = "qwen2.5-coder-32b-instruct",
        default_chat_agent = "qwen2.5-coder-32b-instruct",
        providers = {
          openai = {
            --百炼
            endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
            -- API key
            secret = os.getenv("BAILIAN_API_KEY"),
          },
        },
        agents = {
          {
            name = "qwen2.5-coder-32b-instruct",
            provider = "openai",
            chat = true, -- 用于聊天
            command = true, -- 用于命令
            model = { model = "qwen2.5-coder-32b-instruct" }, -- 在这里指定模型
            system_prompt = system_prompt,
          },
        },

        --------------------百炼 结束---------------------
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
