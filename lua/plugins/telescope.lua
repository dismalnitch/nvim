return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  -- or                              , branch = '0.1.x',
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      -- Use LazyVim's built-in root detection which caches the result
      -- This avoids running shell commands on every Telescope invocation
    },
    pickers = {
      find_files = {
        cwd = require("lazyvim.util").root.get,
      },
      live_grep = {
        cwd = require("lazyvim.util").root.get,
      },
    },
  },
}
