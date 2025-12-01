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
-- Folding is configured in lua/plugins/ufo.lua using nvim-ufo plugin

vim.g.copilot_no_tab_map = false

-- Set window separator color after colorscheme loads
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#A4A7A4" })
  end,
})
-- Also set it immediately on startup
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

-- Truncate the inlayHint to prevent kabob type hinting
-- vim.lsp.handlers["textDocument/inlayHint"] = function(_, result, ctx, config)
--   -- Custom truncation logic here
--   for _, hint in ipairs(result or {}) do
--     if hint.label and #hint.label > 50 then
--       hint.label = string.sub(hint.label, 1, 20) .. "..."
--     end
--   end
--   return vim.lsp.handlers["textDocument/inlayHint"](_, result, ctx, config)
-- end
