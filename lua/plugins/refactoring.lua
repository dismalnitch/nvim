-- The editor.refactoring extra calls telescope.load_extension("refactoring"),
-- but refactoring.nvim no longer ships a telescope extension, so any telescope
-- load errored. Same setup minus that hook.
return {
  "ThePrimeagen/refactoring.nvim",
  config = function(_, opts)
    require("refactoring").setup(opts)
  end,
}
