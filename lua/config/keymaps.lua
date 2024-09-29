-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local map = vim.keymap.set

map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })
map("n", "t", "<A-d>", { desc = "<cmd>Lspsaga term_toggle" })
map({ "i", "v" }, "jk", "<esc>")

map("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Show Hover Doc" })
map("n", "<leader>ci", "<cmd>Lspsaga finder", { desc = "Search Current Symbol In Lspsaga Finder" })
map("n", "py", "<cmd>Lspsaga peek_definition", { desc = "Peek Definition" })
map("n", "pd", "<cmd>Lspsaga peek_type_definition", { desc = "Peek Type Definition" })
