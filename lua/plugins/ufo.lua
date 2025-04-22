return {
  {
    "kevinhwang91/promise-async",
  },
  {
    "kevinhwang91/nvim-ufo",
    -- THIS IS THE IMPORTANT LINE:
    requires = "kevinhwang91/promise-async",
    config = function()
      require("ufo").setup({
        -- your ufo config...
        provider_selector = function(bufnr, filetype, buftype)
          return { "lsp", "indent" }
        end,
      })
      -- your fold settings vim.opt.fold...
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      -- Disables vims auto folding to prevent conflicts
      vim.opt.foldmethod = "manual"
    end,
  },
}
