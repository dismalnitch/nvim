return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      provider = "claude",
      n_completions = 1, -- one suggestion per request keeps output tokens down
      context_window = 8000, -- chars around the cursor; smaller = cheaper
      throttle = 1000,
      debounce = 400,
      request_timeout = 5,
      provider_options = {
        claude = {
          model = "claude-haiku-5-5",
          max_tokens = 256,
          api_key = "ANTHROPIC_API_KEY",
          optional = {
            thinking = { type = "disabled" },
            output_config = { effort = "low" },
          },
        },
      },
      virtualtext = {
        auto_trigger_ft = { "*" },
        auto_trigger_ignore_ft = { "help", "TelescopePrompt", "snacks_picker_input" },
        keymap = {
          accept = nil, -- <Tab>, via LazyVim's cmp chain below
          accept_line = "<M-j>",
          accept_n_lines = "<M-z>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
    },
    config = function(_, opts)
      require("minuet").setup(opts)
      local vt = require("minuet.virtualtext")
      LazyVim.cmp.actions.ai_accept = function()
        if vt.action.is_visible() then
          vt.action.accept()
          return true
        end
      end
    end,
    keys = {
      { "<leader>aT", "<cmd>Minuet virtualtext toggle<cr>", desc = "Toggle Minuet autocomplete" },
    },
  },

  -- Copilot off so its ghost text and <Tab> don't fight Minuet. Delete these to bring it back.
  { "github/copilot.vim", enabled = false },
  { "neovim/nvim-lspconfig", opts = { servers = { copilot = { enabled = false } } } },
}
