-- LSP setup handled via plugin specs in lua/plugins/
-- TypeScript: vtsls (see lua/plugins/ts.lua)
-- Python: pyright (see ~/.config/nvim/lsp/pyright.lua)

-- nvim-lspconfig removed :LspRestart/:LspStop/:LspInfo in favor of the
-- native vim.lsp API. Recreate :LspRestart on top of vim.lsp.enable(),
-- which stops the client and re-attaches it to matching buffers.

-- Only restart servers managed by vim.lsp.enable() — skips clients like
-- copilot that start themselves and have no vim.lsp.config entry.
local function restartable(name)
  local ok, enabled = pcall(vim.lsp.is_enabled, name)
  if ok then
    return enabled
  end
  return name ~= "copilot"
end

local function active_names()
  local names = {}
  for _, c in ipairs(vim.lsp.get_clients()) do
    if restartable(c.name) and not vim.tbl_contains(names, c.name) then
      table.insert(names, c.name)
    end
  end
  return names
end

vim.api.nvim_create_user_command("LspRestart", function(opts)
  local names = #opts.fargs > 0 and opts.fargs
    or vim.tbl_map(function(c)
      return c.name
    end, vim.tbl_filter(function(c)
      return restartable(c.name)
    end, vim.lsp.get_clients({ bufnr = 0 })))

  if #names == 0 then
    vim.notify("LspRestart: no restartable clients attached", vim.log.levels.WARN)
    return
  end

  for _, name in ipairs(names) do
    vim.lsp.enable(name, false)
  end
  -- Give the servers a moment to exit before re-enabling.
  vim.defer_fn(function()
    for _, name in ipairs(names) do
      vim.lsp.enable(name, true)
    end
    vim.notify("Restarted: " .. table.concat(names, ", "))
  end, 500)
end, {
  nargs = "*",
  complete = active_names,
  desc = "Restart LSP clients (current buffer's, or named ones)",
})

-- Muscle-memory alias: :LspInfo -> native health report
vim.api.nvim_create_user_command("LspInfo", function()
  vim.cmd("checkhealth vim.lsp")
end, { desc = "Show LSP status (checkhealth vim.lsp)" })
