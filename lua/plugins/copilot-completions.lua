return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = { enabled = false },
        suggestion = { enabled = true },
        filetypes = {
          markdown = true,
          help = true,
          gitcommit = true,
          gitrebase = true,
          hgcommit = true,
          svncommit = true,
          text = true,
        },
        keymap = {
          accept = "<Tab>",
          accept_word = false,
          accept_line = false,
          jump_next = "]]",
          jump_prev = "[[",
          dismiss = "<C-e>",
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
