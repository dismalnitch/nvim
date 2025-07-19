-- bootstrap lazy.nvim, LazyVim and your plugins

require("config.lazy")
require("config.autocmds")
require("config.lsp")

vim.o.mouse = "a"

-- Virtual scrolling

-- Ensure your custom keybinding is set after all plugins are loaded
-- And by that, I of course mean that copilot is scooping my keybindings. So here's a hack.
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
  end,
})
-- Turn on treesitter folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"

vim.g.copilot_no_tab_map = false

vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#A4A7A4" })

vim.keymap.set(
  { "n", "v", "i" },
  "<PageUp>",
  "<C-u>",
  { desc = "Page up -> half screen up" }
)

vim.keymap.set(
  { "n", "v", "i" },
  "<PageDown>",
  "<C-d>",
  { desc = "Page down -> half screen down" }
)
