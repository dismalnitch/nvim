return {
  -- typescript-tools communicates directly with tsserver (bypasses LSP translation layer)
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = {},
  },
  -- Disable ts_ls since typescript-tools replaces it
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = { enabled = false },
      },
    },
  },
}

