-- /Users/zfox/.config/nvim/lua/plugins/smart-splits.lua

return {
  "mrjones2014/smart-splits.nvim",
  build = "./kitty/install-kittens.bash",
  config = function()
    -- recommended mappings
    vim.keymap.set(
      "n",
      "<C-A-h>",
      require("smart-splits").resize_left,
      { noremap = true, silent = true }
    )
    vim.keymap.set(
      "n",
      "<C-A-j>",
      require("smart-splits").resize_down,
      { noremap = true, silent = true }
    )
    vim.keymap.set(
      "n",
      "<C-A-k>",
      require("smart-splits").resize_up,
      { noremap = true, silent = true }
    )
    vim.keymap.set(
      "n",
      "<C-A-l>",
      require("smart-splits").resize_right,
      { noremap = true, silent = true }
    )
    -- moving between splits
    vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
    vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
    vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
    vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
    vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
    -- swapping buffers between windows
    vim.keymap.set(
      "n",
      "<leader><leader>h",
      require("smart-splits").swap_buf_left
    )
    vim.keymap.set(
      "n",
      "<leader><leader>j",
      require("smart-splits").swap_buf_down
    )
    vim.keymap.set(
      "n",
      "<leader><leader>k",
      require("smart-splits").swap_buf_up
    )
    vim.keymap.set(
      "n",
      "<leader><leader>l",
      require("smart-splits").swap_buf_right
    )
  end,
}
