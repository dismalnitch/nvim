-- bootstrap lazy.nvim, LazyVim and your plugins

require("config.lazy")
require("config.autocmds")

vim.o.mouse = "a"

-- Ensure your custom keybinding is set after all plugins are loaded
-- And by that, I of course mean that copilot is scooping my keybindings. So here's a hack.
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
  end,
})

require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
  layout = {
    window = {
      max_width = { 40, 0.2 },
    },
    default_direction = "prefer_right",
    border = {
      highlight = "FloatBorder",
      style = "single",
    },
  },
  filter_kind = {
    "Class",
    "Type",
    "Constructor",
    "Enum",
    "Function",
    "Interface",
    "Module",
    "Method",
    "Struct",
  },
})

require("mini.pairs").setup({
  -- Disable all auto-pairing
  disable = true,
})

require("nvim-ts-autotag").setup({
  enable = false,
})

-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
--
local nvim_lsp = require("lspconfig")
-- Example for configuring the tsserver (TypeScript) LSP
nvim_lsp.tsserver.setup({
  on_attach = function(client, bufnr)
    -- Custom handler to filter out specific diagnostics
    client.handlers["textDocument/inlayHint"] = function(_, result, ctx, config)
      local diagnostics = result.diagnostics
      local filtered_diagnostics = {}

      for _, diagnostic in ipairs(diagnostics) do
        -- Filter out diagnostics with specific codes or messages
        if
          diagnostic.code ~= "-32603"
          and not diagnostic.message:match("<semantic> (.+)")
        then
          table.insert(filtered_diagnostics, diagnostic)
        end
      end

      result.diagnostics = filtered_diagnostics
      vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
    end
  end,
  flags = {
    debounce_text_changes = 150,
  },
})
