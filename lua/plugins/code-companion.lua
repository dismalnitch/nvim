return {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    -- Default options
    -- See Configuration section for options
    mappings = {
      -- Mappings for the default commands
      -- See Commands section for default commands if you want to lazy load on them
      ["<leader>aa"] = {
        "<cmd>CodeCompanionActions<cr>",
        desc = "Code Companion",
      },
      ["<leader>ac"] = {
        "<cmd>CodeCompanionClose<cr>",
        desc = "Code Companion Close",
      },
    },
  },
}
