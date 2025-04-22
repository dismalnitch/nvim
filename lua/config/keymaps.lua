-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- Define the path to the init.lua file

-- Create a key mapping to source the init.lua file
local map = vim.keymap.set

-- yanky --------

vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

-----------------

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
-----------------

map(
  "n",
  "pd",
  "<cmd>Lspsaga peek_type_definition",
  { desc = "Peek Type Definition" }
)
map(
  "n",
  "<leader>aa",
  "<cmd>CodeCompanionActions<cr>",
  { desc = "Code Companion" }
)
map(
  "n",
  "<leader>ac",
  "<cmd>CodeCompanionClose<cr>",
  { desc = "Code Companion Close" }
)

-- Load new config without closing
local config_path = vim.fn.stdpath("config")
local init_lua_path = config_path .. "/init.lua"
map(
  "n",
  "<leader>rr",
  ':lua vim.cmd("source ' .. init_lua_path .. '")<CR>',
  { noremap = true, silent = true }
)
map(
  "n",
  "<Space>xi",
  "<cmd>lua vim.diagnostic.open_float(0, { scope = 'line' })<CR>",
  { desc = "Floating error (current line)" }
)
map(
  "n",
  "<C-j>",
  "<cmd> TmuxNavigateDown <CR>",
  { desc = "Tmux Navigate Down" }
)
map("n", "<C-k>", "<cmd> TmuxNavigateUp <CR>", { desc = "Tmux Navigate Up" })
map(
  "n",
  "<C-h>",
  "<cmd> TmuxNavigateLeft <CR>",
  { desc = "Tmux Navigate Left" }
)
map(
  "n",
  "<C-l>",
  "<cmd> TmuxNavigateRight <CR>",
  { desc = "Tmux Navigate Right" }
)
