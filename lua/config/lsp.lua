-- LSP Configuration for Neovim 0.11+

-- Workaround for Neovim 0.11 change tracking bug
vim.lsp._changetracking = vim.lsp._changetracking or {}
local original_incremental_changes = vim.lsp._changetracking.incremental_changes
if original_incremental_changes then
  vim.lsp._changetracking.incremental_changes = function(...)
    local ok, result = pcall(original_incremental_changes, ...)
    if not ok then
      -- Fall back to full document sync on error
      return nil
    end
    return result
  end
end

-- LSP keymaps function
local function setup_lsp_keymaps(bufnr)
  local opts = { buffer = bufnr, silent = true }
  
  -- Goto definition
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  
  -- Find references
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  
  -- Hover and help
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  
  -- Type definition
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  
  -- Rename
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  
  -- Code actions
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  
  -- Diagnostics
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
end

-- Setup LSP attach autocmd
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    setup_lsp_keymaps(ev.buf)
  end,
})

-- Enable LSP servers (Neovim 0.11 will auto-discover lsp/*.lua files)
vim.lsp.enable({'ts', 'pyright', 'gopls'})

