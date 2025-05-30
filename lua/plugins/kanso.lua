return {
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanso").setup({
        theme = "ink", -- Load "zen" theme
        background = { -- map the value of 'background' option to a theme
          dark = "ink", -- try "ink" !
          light = "pearl",
        },
      })
    end,
  },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   -- Configure LazyVim to load gruvbox
  --   config = function()
  --     require("kanagawa").setup({
  --       compile = true, -- enable compiling the colorscheme
  --       undercurl = true, -- enable undercurls
  --       commentStyle = { italic = true },
  --       functionStyle = {},
  --       keywordStyle = { italic = true },
  --       statementStyle = { bold = true },
  --       typeStyle = {},
  --       dimInactive = false, -- dim inactive window `:h hl-NormalNC`
  --       terminalColors = true, -- define vim.g.terminal_color_{0,17}
  --       colors = { -- add/modify theme and palette colors
  --         palette = {},
  --         theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  --       },
  --       overrides = function(colors) -- add/modify highlights
  --         return {
  --           LineNr = { bg = "NONE" },
  --         }
  --       end,
  --       theme = "wave", -- Load "wave" theme when 'background' option is not set
  --       background = { -- map the value of 'background' option to a theme
  --         dark = "wave", -- try "dragon" !
  --         light = "lotus",
  --       },
  --     })
  --   end,
  -- },
}
