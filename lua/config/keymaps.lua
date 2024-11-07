-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local map = vim.keymap.set

map({ "i", "v" }, "fd", "<esc>")
map({ "i", "v" }, "df", "<esc>")

map("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Show Hover Doc" })
map(
  "n",
  "<leader>ci",
  "<cmd>Lspsaga finder",
  { desc = "Search Current Symbol In Lspsaga Finder" }
)
map("n", "py", "<cmd>Lspsaga peek_definition", { desc = "Peek Definition" })
map(
  "n",
  "pd",
  "<cmd>Lspsaga peek_type_definition",
  { desc = "Peek Type Definition" }
)
map(
  "n",
  "pi",
  "<cmd>Lspsaga preview_definition",
  { desc = "Preview Definition" }
)
map(
  "n",
  "<Space>xi",
  "<cmd>lua vim.diagnostic.open_float(0, { scope = 'line' })",
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
